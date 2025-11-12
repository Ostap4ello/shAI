.PHONY: all pdf clean pdf.tex pdf.usernotes
.SILENT: all pdf pdf.tex pdf.usernotes

BUILDER_GITHUB_REPO = "https://github.com/Kyslik/FEIStyle"
BUILDER_FOLDER_NAME = FEIStyle

DOCUMENTS = thesis.tex img/ includes/

PWD := pwd

LOG_INFO := echo "- "

all: pdf

pdf: pdf.tex pdf.usernotes

pdf.usernotes:
	pandoc ./user-notes.md -o build/user-notes.pdf --pdf-engine=xelatex

tex.usernotes:
	pandoc ./user-notes.md -o build/user-notes.tex --pdf-engine=xelatex

pdf.tex:
	if [ ! -d "build" ]; then mkdir build; fi
	if [ ! -d "build/$(BUILDER_FOLDER_NAME)" ]; then \
		$(LOG_INFO) "Cloning builder repository..."; \
		git clone $(BUILDER_GITHUB_REPO) ./build/$(BUILDER_FOLDER_NAME); \
	fi
	
	if [ ! -f "thesis.tex" ]; then \
		exit 1; \
	fi
	cd ./build/$(BUILDER_FOLDER_NAME); \
		rm -rf $(DOCUMENTS); \
	
	cp -r $(DOCUMENTS) ./build/$(BUILDER_FOLDER_NAME)/.
	
	$(LOG_INFO) "Starting LaTeX build process..."
	cd ./build/$(BUILDER_FOLDER_NAME); \
		$(LOG_INFO) "Running LaTeX build. Output:"; \
		make; \
		$(LOG_INFO) "Build finished."
	
	$(LOG_INFO) "Copying built PDF to build folder..."
	cp ./build/$(BUILDER_FOLDER_NAME)/.build/thesis.pdf build/thesis.pdf

clean:
	rm -rf ./build
