.PHONY: all help clean

SHELL=/usr/bin/env bash -eo pipefail

.SECONDARY:

.SUFFIXES:

all: .data.complete .code.complete

.data.complete:
	./_prepare_data.sh
	touch $@

.code.complete:
	./_prepare_code.sh
	touch $@

clean: ## Clean
	rm -fr data/ code/

