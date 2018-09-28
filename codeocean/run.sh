#! /usr/bin/env bash

set -e
set -o pipefail



########################################
# 1) Add execution flags to all scripts
#
find /code -name '*.py' -or -name '*.sh' -or -name '*.R' | xargs chmod +x



################################
# 2) Construct the main RASE DB
#

#    i) symlink the db isolates (otherwise they would be downloaded from the internet)

(
    cd /code/rase-db/spneumoniae_sparc/isolates
    for x in /data/isolates/*.fa; do
        ln -s "$x"
    done
    touch .complete
)

#    ii) symlink metadata (they are already in /code, but symlinks allow to modify them via /data)
(
    cd /code/rase-db/spneumoniae_sparc/published
    for x in /data/metadata/*; do
        ln -sf "$x"
    done
)

#    iii) run database construction
xvfb-run --server-args="-screen 0 1024x768x24 -noreset" \
make -C /code/rase-db/spneumoniae_sparc # xvfb-run is necessary for plotting using ETE3

#    iv) make and copy plots and db
xvfb-run --server-args="-screen 0 1024x768x24 -noreset" \
make -C /code/rase-db/spneumoniae_sparc/plots
mkdir -p /results/db /results/db-plots
cp /code/rase-db/spneumoniae_sparc/_output/spneumoniae_sparc.k18.tar.gz /results/db/
cp /code/rase-db/spneumoniae_sparc/_output/spneumoniae_sparc.k18.tsv /results/db/
cp /code/rase-db/spneumoniae_sparc/plots/*.pdf /results/db-plots/



#################################
# 3) Run the prediction pipeline
#

#    i) symlink the created database files
cd /code/rase-predict/database
ln -s /results/db/spneumoniae_sparc.k18.tar.gz
ln -s /results/db/spneumoniae_sparc.k18.tsv

#    ii) symlink nanopore reads
cd /code/rase-predict/reads/
for x in /data/reads/*.fq; do
    ln -s "$x"
done

#    iii) run the prediction pipeline (in parallel)
make -C /code/rase-predict # full pipeline
##make -C /code/rase-predict test # test pipeline (the smallest experiment only)

#    iv) copy plots and prediction outputs
mkdir -p /results/prediction-timelines /results/prediction-snapshots /results/prediction-tables /results/prediction-benchmarks
cp /code/rase-predict/plots/*timeline.pdf /results/prediction-timelines/
cp /code/rase-predict/plots/*snapshots*.pdf /results/prediction-snapshots/
cp /code/rase-predict/prediction/*.tsv /results/prediction-tables/
cp /code/rase-predict/benchmarks/*.log /results/prediction-benchmarks/

