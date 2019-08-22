.PHONY: all help clean cleanall view

SHELL=/usr/bin/env bash -eo pipefail

.SECONDARY:

NAME=rase_supplementary_document

all: $(NAME).pdf

%.pdf: %.Rmd $(wildcard *.R)
	$(MAKE) clean
	R -e "rmarkdown::render('$<',output_file='$@')"

help: ## Print help message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s : | sort)"

view:
	open $(NAME).pdf

clean: ## Clean
	rm -fR $(NAME)*/

cleanall: clean ## Clean all
	rm -f $(NAME).pdf *.bib


