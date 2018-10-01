#! /usr/bin/env bash

set -e
set -o pipefail
set -u

d=$(mktemp -d)

(
	cd "$d"
	git clone http://github.com/c2-d2/rase-db
	git clone http://github.com/c2-d2/rase-predict
	make -C rase-db/spneumoniae_sparc cleanall
	make -C rase-predict cleanall
	rm -fr rase-db/.git
	rm -fr rase-predict/.git

	find rase-db -name '*.tsv' -exec rm {} \;
)

rm -fr code
mkdir code
cp -r "$d"/rase-db code/
cp -r "$d"/rase-predict code/
cp run.sh readme.md ../rase.png ../figures/Figure_1.pdf ../LICENSE code/

