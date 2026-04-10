---
title: "ShAI - AI wrapper for shell"
author: "Ostap Pelekh"
geometry: margin=2.5cm
pandoc_:
 - output: build/user-notes.pdf
 - template: codedoc.tex
 - pdf-engine: xelatex
output:
  pdf_document:
    latex_engine: xelatex
    fig_caption: true
---
<!-- nvim-pandoc header -->

\newpage <!-- --- -->
### future-todo

- features / func:
    - Dangerous command detection/prevention
    - Command autocompletion/suggestion
    - In-terminal AI assistant for help and questions
    - Command history awareness and customizations
    - Seamless integration with existing shell environments (incl. tui programs, where AI functionality should be disabled)
    - Fast and relatively lightweight performance
    - Combine online and offline models.
- Use OpenAI one shot training / few shot training / chain of thought to fine-tune a model to meet the specific needs of the application.
- bash plugin - shell plugins
- ? XAI - ecplainable AIng transformers](https://arxiv.org/html/2412.01655v1)
- This work can be used or compared with as detecting dangerous commands is one of the features:
    - [CLI Risc classification usi- User stories / Use cases / Examples (what it does in particular)

\newpage <!-- --- -->
### todo

- Read on features of existing shells (e.g. zsh, fish, bash) to see if they provide any hooks or APIs to interact with the shell process. (Implementing the whole shell interpreter (like a mockup) to be able to keep the context and know if the shell is waiting for input or executing commands. This seems to be complex and not very maintainable afterwards.)
    - [bash ref manual](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Controlling-the-Prompt)
    - zsh - [oh my zsh plugins](https://ohmyz.sh/)
    - fish shell - plugins - is not POSIX compliant, so not very useful for wider audience
    - [GNU readline, hooks](https://tiswww.case.edu/php/chet/readline/rltop.html), [HSTR](https://github.com/dvorka/hstr)
    - [athame](https://github.com/ardagnir/athame) - another bash wrapper, that uses vim process to scan the current screen and basically acts as a buffer for the whole terminal. Could be an interesting approach to explore. (read code again :) )
- [SHELLGPT](https://ieeexplore.ieee.org/abstract/document/10301251) - paper on specialized LLM for shell commands based on GPT-2
    also: use this article to find more related works, especially to define base info.
- [Agents](https://medium.com/@Shamimw/using-ai-agents-to-execute-shell-scripts-with-langgraph-using-ollama-a-smarter-approach-to-679fd3454b09)

- Test Pipeline Using cloud LLM

- add this info to bachelor:
    - UML, functional requirements, -- sw def
    - Expected behavior / look
    - users query types
        1. fact
        2. info from multiple points in database
        3. action
        4. action with hidden context (need to retrieve info)

- qualitative testing
- trying different models


\newpage <!-- --- -->
### to-sort


