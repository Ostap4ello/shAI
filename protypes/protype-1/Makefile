.PHONY: all run check check.venv check.ollama
# .SILENT: all run check check.venv check.ollama

VENV_DIR=.venv
PYTHON=$(VENV_DIR)/bin/python3
APP=app
LOG_INFO := echo "- "
LOG_ERR:= echo "! "

DOCKER_CHECK_CMD := docker ps | grep ollama | cut -d' ' -f1

all: run

check: check.venv check.ollama

check.venv:
	$(LOG_INFO) "Checking for virtual environment ($(VENV_DIR))..."
	if [ ! -d "$(VENV_DIR)" ]; then \
		$(LOG_ERR) "Virtual environment not found. Please create it first."; \
		exit 1; \
	else \
	$(LOG_INFO) "Virtual environment found."; \
	fi

check.ollama:
	$(LOG_INFO) "Checking if Ollama Docker container is running..."
	if [[ -z "$(DOCKER_CHECK_CMD)" ]]; then \
		$(LOG_ERR) "Ollama Docker container is not running. Please start it first."; \
		exit 1; \
	else \
		$(LOG_INFO) "Ollama Docker container is running."; \
	fi \
	
	# $(LOG_INFO) "Checking if Ollama is running inside the docker container..."
	# cont=$(DOCKER_CHECK_CMD); \
	# if [[ -z "$$(docker exec -it $(cont) bash -c 'pgrep ollama')" ]]; then \
	# $(LOG_ERR) "Ollama is not running inside the docker container. Please ensure it is running."; \
	# 	exit 1; \
	# else \
	# 	$(LOG_INFO) "Ollama is running inside the docker container."; \
	# fi

run: check
	$(PYTHON) $(APP)
