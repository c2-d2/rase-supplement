#! /usr/bin/env bash

set -e
set -o pipefail
set -u

d=$(mktemp -d)

(
	cd "$d"
	git clone http://github.com/c2-d2/rase-db
)

rm -fr data
mkdir data
mkdir data/isolates

(
	cd data/isolates
	"$d"/rase-db/spneumoniae_sparc/isolates/download_sparc1_assemblies.sh
)

(
	cd data
	tar cvf isolates.tar isolates
	rm -fr isolates/
)
