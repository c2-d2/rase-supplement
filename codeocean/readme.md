# RASE - Resistance-Associated Sequence Elements

This Code Ocean capsule contains data and code for the manuscript [Lineage
calling can identify antibiotic resistant clones within
minutes](https://www.biorxiv.org/content/early/2018/08/29/403204).

For more information, see [RASE on Github](https://github.com/c2-d2/rase).

### Citation

> Břinda K, Callendrello A, Cowley L, Charalampous T, Lee R S, MacFadden D R,
> Kucherov G, O'Grady J, Baym M, Hanage W P. **Lineage calling can identify
> antibiotic resistant clones within minutes.** bioRxiv 403204, 2018.
> doi:[10.1101/403204](https://doi.org/10.1101/403204)

## Abstract

Surveillance of circulating drug resistant bacteria is essential for healthcare
providers to deliver effective empiric antibiotic therapy.  However, the
results of surveillance may not be available on a timescale that is optimal for
guiding patient treatment. Here we present a method for inferring
characteristics of an unknown bacterial sample by identifying the presence of
sequence variation across the genome that is linked to a phenotype of interest,
in this case drug resistance. We demonstrate an implementation of this
principle using sequence k-mer content, matched to a database of known genomes.
We show this technique can be applied to data from an Oxford Nanopore device in
real time and is capable of identifying the presence of a known resistant
strain in 5 minutes, even from a complex metagenomic sample. This flexible
approach has wide application to pathogen surveillance and may be used to
greatly accelerate diagnoses of resistant infections.

[![Overview of the RASE
method](rase.png)](https://github.com/c2-d2/rase/blob/master/figures/Figure_1.pdf)


## Code

The Code directory (`/code`) contains the [rase-db](http://github.com/c2-d2/rase-db)
and [rase-predict](http://github.com/c2-d2/rase-predict) repositories. All
input data were removed from the repositories and can be found in `/data`.

## Data

The Data directory (`/data`) contains all input files for constructing the default
RASE DB for S.pneumoniae, and the sequencing reads published with the paper.
For the metagenomic experiments, only the filtered datasets (i.e., after
removing the remaining human reads in silico) were made publicly available.

* **isolates** - draft assemblies of isolates S.pneumoniae that were [published
  previously](https://www.nature.com/articles/sdata201558)
* **metadata** - metadata for these isolates ([table from
  2013](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3725542/bin/NIHMS474991-supplement-2.xlsx),
  [table from 2015](https://www.nature.com/articles/sdata201558/tables/1), and
  the [phylogeny](https://datadryad.org/resource/doi:10.5061/dryad.t55gq/1)).
* **reads** - [nanopore sequencing reads](https://zenodo.org/record/1405173)
  from the isolates and metagenomes in the paper

## Running the Code Ocean pipeline

The [run.sh](run.sh) script contains all the required steps. It first symlinks
all data files in the code directories, then it construct the RASE DB, and
finally predicts resistance from the provided FQ files.

## Results

The Results directory (`/results`) is structured in the following way:

* **db** - the constructed RASE DB
* **db-plots** - plots for the database (e.g., plots illustrating MICs)
* **prediction-bencharks** - timing data for individual steps of the pipeline
* **prediction-snapshots** - rank plots for selected moments of individual
  experiments
* **prediction-tables** - prediction as a function of time (tsv tables)
* **prediction-timelines** - prediction as a function of time (plots)

## License

[MIT](LICENSE).


## Contact

[Karel Břinda](https://scholar.harvard.edu/brinda) (kbrinda@hsph.harvard.edu)

