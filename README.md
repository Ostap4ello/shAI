# shAI
### An AI-powered shell assistant/wrapper

## Project structure:

- `document/` - Documentation files. Uses [Kyslik/FEIStyle](https://github.com/Kyslik/FEIStyle) to build thesis PDF and `pandoc` for other docs.
    - `user-notes.md` - User notes on the project
    - `thesis.tex, includes/, img/` - LaTeX thesis files

## Usage

To generate documentation PDF:
```bash
cd document
make
```

The generated PDF files will be in the `build/` folder.



