.PHONY: all pdf clean diagrams
.SILENT: all pdf clean diagrams

PWD := pwd

LOG_INFO := echo "- "

all: diagrams pdf

pdf:
	mkdir -p .build/
	
	cp res/demo.mp4 .build/.
	if [ ! -f "presentation.tex" ]; then \
		exit 1; \
	fi
	
	$(LOG_INFO) "Running LaTeX build. Output:";
	tectonic --keep-intermediates --outdir ./.build/ presentation.tex
	$(LOG_INFO) "Build finished."

diagrams:
	$(LOG_INFO) "Generating PlantUML diagrams..."
	mkdir -p diagrams/out
	cd diagrams && plantuml -png *.puml -o out/
	cd diagrams && plantuml -svg *.puml -o out/
	cd diagrams && for i in *.puml; do \
		$(LOG_INFO) "Generating PDF for $$i..."; \
		plantuml -tsvg -pipe < $$i | inkscape --pipe --export-filename=out/$$i.pdf; \
	done
	$(LOG_INFO) "Diagrams generated in diagrams/out/"
	$(LOG_INFO) "Copying png diagrams to img/."
	mkdir -p res/
	cp diagrams/out/*.pdf res/.

clean:
	$(LOG_INFO) "Cleaning all build artifacts..."
	rm -rf ./.build
