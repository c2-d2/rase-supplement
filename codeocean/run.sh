#! /usr/bin/env bash

set -e
set -o pipefail

########################################
# 1) Add execution flags to all scripts
#
find /code -name '*.py' -or -name '*.sh' -or -name '*.R' -or -name 'sort_with_header' | xargs chmod +x



################################
# 2) Construct the main RASE DB
#

#    i) copy isolates from /data (otherwise they would be downloaded from the internet)
cd /code/rase-db/spneumoniae_sparc
tar xvf /data/isolates.tar

#    ii) run database construction
xvfb-run --server-args="-screen 0 1024x768x24 -noreset" \
make -C /code/rase-db/spneumoniae_sparc # xvfb-run is necessary for plotting using ETE3

#    iii) make and copy plots
xvfb-run --server-args="-screen 0 1024x768x24 -noreset" \
make -C /code/rase-db/spneumoniae_sparc/plots
cp /code/rase-db/spneumoniae_sparc/plots/*.pdf /results/



#################################
# 3) Run the prediction pipeline
#

#    i) symlink the created database files
cd /code/rase-predict/database
ln -s /code/rase-db/spneumoniae_sparc/_output/spneumoniae_sparc.k18.tar.gz
ln -s /code/rase-db/spneumoniae_sparc/_output/spneumoniae_sparc.k18.tsv

#    ii) symlink nanopore reads
cd /code/rase-predict/reads/
for x in /data/*.fq; do
    ln -s "$x"
done

#    iii) run the prediction pipeline (in parallel)
make -C /code/rase-predict # full pipeline
##make -C /code/rase-predict test # test pipeline (the smallest experiment only)

#    iv) copy plots
cp /code/rase-predict/plots/*.pdf /results/

