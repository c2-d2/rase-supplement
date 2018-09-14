.PHONY: all help clean cleanall readme view

SHELL=/usr/bin/env bash -eo pipefail

.SECONDARY:

.SUFFIXES:

all: rase.png

rase.png: figures/figure_1.pdf
	convert -density 300 "$<" -resize 25% "$@"


readme: ## Generate a HTML version of the README
	 markdown_py readme.md > readme.html

view: ## Open README
	open README.html

help: ## Print help message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s : | sort)"

clean: ## Clean
	rm -f readme.html

cleanall: clean ## Clean all


