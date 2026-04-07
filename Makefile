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

# TODO: push fixes to builder repository
#
# BUILD_DIR change is related to \makeglossaries and \makeindex(?) commands not
# printing their tables in the document, if .acr ... files are not in the same
# directory as the .tex file.
#
# The ret variable change supresses error prints
pdf.thesis:
	if [ ! -d ".build" ]; then mkdir .build; fi
	if [ ! -d ".build/$(BUILDER_FOLDER_NAME)" ]; then \
		$(LOG_INFO) "Cloning builder repository..."; \
		git clone $(BUILDER_GITHUB_REPO) ./.build/$(BUILDER_FOLDER_NAME); \
		cd ./.build/$(BUILDER_FOLDER_NAME); \
		sed -i 's/  return ret;/  return $$ret;/' latexmkrc; \
		sed -i 's/^BUILD_DIR = .build/BUILD_DIR = ./' Makefile; \
	fi
	
	if [ ! -f "thesis.tex" ]; then \
		exit 1; \
	fi
	cd ./.build/$(BUILDER_FOLDER_NAME); \
	
	cp -r $(DOCUMENTS) ./.build/$(BUILDER_FOLDER_NAME)/.
	
	$(LOG_INFO) "Starting LaTeX build process..."
	cd ./.build/$(BUILDER_FOLDER_NAME); \
		$(LOG_INFO) "Running LaTeX build. Output:"; \
		sed -i "s/\\FEIdate{00}{00}{0000}/\\FEIdate$(shell date +{%d}{%m}{%Y})/g" thesis.tex ; \
		pdflatex -synctex=1 -output-directory=. -interaction=nonstopmode thesis 2>&1 1>/dev/null ; \
		makeglossaries thesis ; \
		make; \
		$(LOG_INFO) "Build finished."
	
	$(LOG_INFO) "Copying built PDF to build folder..."
	cp ./.build/$(BUILDER_FOLDER_NAME)/thesis.log .build/thesis.log
	cp ./.build/$(BUILDER_FOLDER_NAME)/thesis.pdf .build/thesis.pdf
	cp ./.build/$(BUILDER_FOLDER_NAME)/thesis.acr .build/thesis.acr
	cp ./.build/$(BUILDER_FOLDER_NAME)/thesis.bbl .build/thesis.bbl

pdf.thesis-clean:
	$(LOG_INFO) "Cleaning local build files..."
	if [ -d ".build/$(BUILDER_FOLDER_NAME)" ]; then \
		cd ./.build/$(BUILDER_FOLDER_NAME); \
		make clean; \
	fi



clean:
	rm -rf ./.build
