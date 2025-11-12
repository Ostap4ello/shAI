import sys, os
from getch import getch
import signal
from re import sub

import ai.ai_node as ai_node
import shell.bash_node as bash_node

def setup():
    # Handle Ctrl+C gracefully
    signal.signal(signal.SIGINT, signal_handler)

def signal_handler(sig, frame):
    print("\nExiting gracefully...")
    sys.exit(0)

def interpreter():
    setup()

    ai_model_name = 'gemma3:latest'
    request_format = """
    you are a witty, helpful, and versatile text-based expert.
    you sit between the user and the bash shell, providing guidance and checking commands.
    your primary goal is to minimize friction for valid commands while blocking
    only the most catastrophic or suspicious inputs.

    args:
        user_input: the text entered by the user.

    returns:
        a dictionary (which will be serialized as a json object) with the
        following format: {"action": "<action>", "explanation": "<explanation>"}

    the logic for setting 'action' and 'explanation' is prioritized as follows:

    1. action: "execute-dangerous"
       - condition: if the user input is an **extreme, irreversible, and uncommon bash command**
         (e.g., `rm -rf /`, fork bombs, or other inputs designed to cause immediate,
         catastrophic system failure or data loss). this should be reserved for
         *suspicious, system-destroying* commands only. E
       - explanation: a **brief, specific, and clear warning** about the potential for
         irreversible data/system destruction.

    2. action: "execute"
       - condition: if the user input appears to be a **valid executable bash command**.
         this is the preferred action for any command that is not *catastrophically* dangerous.
       - explanation: must be **empty** ("").

    3. action: "explain"
       - condition: if the user input is a **question/request to do something, a natural language statement, or an invalid/non-executable command syntax**.
       - explanation: **a helpful explanation, guidance, or a brief, engaging interaction**

    **Always ensure the final output is a single, valid JSON object and contains
    no additional text outside of the JSON structure.**

    user_input: "%s"
    """

    ai_model = ai_node.AIModel(ai_model_name, "-- new session --")

    path = os.path.dirname(os.path.abspath(__file__))
    bash_wrapper = bash_node.BashWrapper(path)

    print(f"Interpreter initialized at {path}. Using AI model: {ai_model_name}. Press Ctrl+C to exit.")
    print()

    command = []
    while True:
        ch = getch()

        if ch == "\n":
            # process command after Enter is pressed
            print()
            command_str = "".join(command).strip()
            request = repr(request_format % command_str)
            command = []

            response = ai_model.get_response(request) # dict

            if response is not None:
                action = response.get("action", "")
                if action == "execute":
                    bash_wrapper.execute_command(command_str)

                elif action == "explain":
                    print("Explanation:", repr(response.get("explanation", "No explanation provided.")))

                elif action == "execute-dangerous":
                    print("The command you entered may be potentially dangerous.")
                    explanation = response.get("explanation", "No explanation provided.")
                    explanation = explanation.encode('latin-1').decode('unicode_escape')
                    print("Explanation:", response.get("explanation", "No explanation provided."))

                    print("Do you want to proceed with execution? (y/N): ", end="", flush=True)
                    if getch() == 'y':
                        print()
                        bash_wrapper.execute_command(command_str)
                    else:
                        print("Command execution cancelled.")

                else:
                    print("Unknown action:", action)

                print()

        elif ch == "\x7f":
            # handle backspace
            if command:
                command.pop()
                # Move cursor back, overwrite with space, move cursor back again
                print("\b \b", end="", flush=True)
        else:
            # output to console
            print(ch, end="", flush=True)
            command.append(ch);

