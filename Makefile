.PHONY: all help clean cleanall readme view html

SHELL=/usr/bin/env bash -eo pipefail

.SECONDARY:

.SUFFIXES:

all: rase.png

rase.png: figures/figure_1.pdf
	convert -density 300 "$<" -resize 25% "$@"

html: $(patsubst %.md,%.html,$(wildcard *.md))
html: ## Generate HTML versions of all markdown files

%.html: ## Generate a HTML version of the README
%.html: %.md
	 markdown_py "$<" > "$@"

view: ## Open README
	open README.html

help: ## Print help message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s : | sort)"

clean: ## Clean
	rm -f readme.html

cleanall: clean ## Clean all


