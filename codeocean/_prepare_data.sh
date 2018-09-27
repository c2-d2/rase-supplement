#! /usr/bin/env bash

set -e
set -o pipefail
set -u


rm -fr data
mkdir data

# 1) download metadata

(
	cd data
	for x in SPARC.core_genes.tree isolates.2013.tsv isolates.2015.tsv; do
		wget https://raw.githubusercontent.com/c2-d2/rase-db/466bc84318616950cd479c85bd86cb0bc31be321/spneumoniae_sparc/published/$x
	done
)


# 2) create isolates.tar

mkdir data/isolates
d=$(mktemp -d)
(
	cd "$d"
	git clone http://github.com/c2-d2/rase-db
)
(
	cd data/isolates
	"$d"/rase-db/spneumoniae_sparc/isolates/download_sparc1_assemblies.sh
)
(
	cd data
	tar cvf isolates.tar isolates
	rm -fr isolates/
)


# 3) download nanopore reads from Zenodo
(
	cd data
	curl https://zenodo.org/record/1405173 \
		| grep stream \
		| perl -pe 's/.*href="(.*)".*/\1/g' \
		> list.txt
	cat list.txt | parallel -j 6 --verbose --gnu "wget {}"
	rm list.txt
)

