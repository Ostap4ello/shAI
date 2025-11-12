# shAI
### An AI-powered shell assistant/wrapper

## Project structure:

- `document/` - Documentation files. Uses [Kyslik/FEIStyle](https://github.com/Kyslik/FEIStyle) to build thesis PDF and `pandoc` for other docs.
    - `user-notes.md` - User notes on the project
    - `thesis.tex, includes/, img/` - LaTeX thesis files
- `protypes/` - Protypes and Proof-of-concept implementations
    - `prototype-1/` - Initial prototype using local LLM to distinguish between commands and natural language.

## Usage

### Documentation

To generate documentation PDF:
```bash
cd document
make
```

The generated PDF files will be in the `build/` folder.

### Prototypes

#### Prototype 1
To run the initial prototype:

1. You need to have ollama docker image set up and running. Follow instructions at [Ollama](https://docs.ollama.com/docker#docker).
2. Enter the prototype-1 directory:
```bash
cd prototypes/prototype-1
```

3. Install dependencies:
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
deactivate # (optionally)
```

4. Run:
```bash
cd prototypes/prototype-1
make
```


