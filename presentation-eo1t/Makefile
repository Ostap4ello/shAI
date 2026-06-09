.PHONY: all pdf clean
.SILENT: all pdf clean

PWD := pwd

LOG_INFO := echo "- "

all: pdf

pdf:
	mkdir -p .build/
	
	if [ ! -f "presentation.tex" ]; then \
		exit 1; \
	fi
	
	$(LOG_INFO) "Running LaTeX build. Output:";
	tectonic --keep-intermediates --outdir ./.build/ presentation.tex
	$(LOG_INFO) "Build finished."

clean:
	$(LOG_INFO) "Cleaning all build artifacts..."
	rm -rf ./.build
