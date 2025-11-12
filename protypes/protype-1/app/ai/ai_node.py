from ollama import chat
import json

class AIModel:
    def __init__(self, model_name, ai_setting):
        self.model_name = model_name

    def get_response(self, user_input) -> dict | None:
        response = chat(
            model=self.model_name,
            messages=[{'role': 'user', 'content': user_input}],
            format='json'
        )
        print("DEBUG: Raw response content:", response.message.content)

        if (response.message.content is None):
            return None

        response_dict = json.loads(response.message.content)

        return response_dict


