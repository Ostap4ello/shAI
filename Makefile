.PHONY: all pdf clean-pdf clean pdf.thesis pdf.usernotes pdf.thesis-clean
.SILENT: all pdf clean-pdf pdf.thesis pdf.usernotes pdf.thesis-clean

BUILDER_GITHUB_REPO = "https://github.com/Kyslik/FEIStyle"
BUILDER_FOLDER_NAME = FEIStyle

DOCUMENTS = thesis.tex img/ includes/

PWD := pwd

LOG_INFO := echo "- "

all: pdf

pdf: pdf.thesis pdf.usernotes

clean-pdf: pdf.thesis-clean pdf.thesis pdf.usernotes

pdf.usernotes:
	pandoc ./user-notes.md -o .build/user-notes.pdf --pdf-engine=xelatex

pdf.thesis:
	if [ ! -d ".build" ]; then mkdir .build; fi
	if [ ! -d ".build/$(BUILDER_FOLDER_NAME)" ]; then \
		$(LOG_INFO) "Cloning builder repository..."; \
		git clone $(BUILDER_GITHUB_REPO) ./.build/$(BUILDER_FOLDER_NAME); \
		cd ./.build/$(BUILDER_FOLDER_NAME); \
		sed -i 's/  return ret;/  return $$ret;/' latexmkrc; \
	fi
	
	if [ ! -f "thesis.tex" ]; then \
		exit 1; \
	fi
	cd ./.build/$(BUILDER_FOLDER_NAME); \
	
	cp -r $(DOCUMENTS) ./.build/$(BUILDER_FOLDER_NAME)/.
	
	$(LOG_INFO) "Starting LaTeX build process..."
	cd ./.build/$(BUILDER_FOLDER_NAME); \
		$(LOG_INFO) "Running LaTeX build. Output:"; \
		sed -i "s/\\FEIdate{00}{00}{0000}/\\FEIdate$(shell date +{%d}{%m}{%Y})/g" thesis.tex; \
		make; \
		$(LOG_INFO) "Build finished."
	
	$(LOG_INFO) "Copying built PDF to build folder..."
	cp ./.build/$(BUILDER_FOLDER_NAME)/.build/thesis.log .build/thesis.log
	cp ./.build/$(BUILDER_FOLDER_NAME)/.build/thesis.pdf .build/thesis.pdf

pdf.thesis-clean:
	$(LOG_INFO) "Cleaning local build files..."
	if [ -d ".build/$(BUILDER_FOLDER_NAME)" ]; then \
		cd ./.build/$(BUILDER_FOLDER_NAME); \
		make clean; \
	fi



clean:
	rm -rf ./.build
