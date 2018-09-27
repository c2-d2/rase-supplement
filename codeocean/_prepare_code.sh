#! /usr/bin/env bash

set -e
set -o pipefail
set -u

d=$(mktemp -d)

(
	cd "$d"
	git clone http://github.com/c2-d2/rase-db
	git clone http://github.com/c2-d2/rase-predict
	rm -fr rase-db/.git
	rm -fr rase-predict/.git
)

rm -fr code
mkdir code
cp -r "$d"/rase-db code/
cp -r "$d"/rase-predict code/
cp run.sh code/

