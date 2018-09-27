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
	cd data
	wget https://zenodo.org/record/1405173/files/sp01_sparc_br1117.fq
	wget https://zenodo.org/record/1405173/files/sp02_sparc_ch2017.fq
	wget https://zenodo.org/record/1405173/files/sp03_phili_312.fq
	wget https://zenodo.org/record/1405173/files/sp04_phili_3894.fq
	wget https://zenodo.org/record/1405173/files/sp05_phili_100.fq
	wget https://zenodo.org/record/1405173/files/sp06_phili_2047.fq
	wget https://zenodo.org/record/1405173/files/sp07_norwich_P28.filtered.fq
	wget https://zenodo.org/record/1405173/files/sp08_norwich_P03.filtered.fq
	wget https://zenodo.org/record/1405173/files/sp09_norwich_P30.filtered.fq
	wget https://zenodo.org/record/1405173/files/sp10_norwich_P33.filtered.fq
	wget https://zenodo.org/record/1405173/files/sp11_norwich_P40.filtered.fq
	wget https://zenodo.org/record/1405173/files/sp12_norwich_P36.filtered.fq
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
