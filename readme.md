# RASE supplement

This repository contains supplementary information to the manuscript
[Lineage calling can identify antibiotic resistant clones within minutes](https://www.biorxiv.org/content/early/2018/08/29/403204).


## Structure

* **rase-pipeline-results**: Results of the RASE pipeline for all experiments
  from the paper (SP01-SP12). The `prediction`, `plots`, and `benchmarks`
  subdirectories contain prediction time tables, the resulting plots (rank
  plots for `t=1m, 5m, last m` and timeline plot for each experiment), and
  Snakemake benchmarks (time and memory used for individual steps of the
  pipeline).
* **tables**: Tables and supplementary tables from the paper.
* **lab-notebooks**: Lab notebooks for sequencing isolates (SP01-SP06) and
  additional MIC testing

Other directories will appear in the next days.


## Other data

Sequencing reads are available from http://doi.org/10.5281/zenodo.1405173.


## Related repositories

* [RASE-DB](http://github.com/c2-d2/rase-db). Code for constructing RASE
  databases and the released databases.
* [RASE-predict](http://github.com/c2-d2/rase-predict). RASE prediction
  pipeline.
* [ProPhyle](http://prophyle.github.io). A highly accurate and resource-frugal
  DNA sequence classifier used by RASE.
* [Prophex](http://github.com/prophyle/prophex). A k-mer index based on the
  Burrows-Wheeler Transform, used by ProPhyle.


## Citing RASE

Karel Brinda, Alanna Callendrello, Lauren Cowley, Themoula Charalampous, Robyn
S Lee, Derek R MacFadden, Gregory Kucherov, Justin O'Grady, Michael Baym,
William P Hanage. **Lineage calling can identify antibiotic resistant clones
within minutes.** bioRxiv, 2018.
doi:[10.1101/403204](https://doi.org/10.1101/403204)


## License

[MIT](LICENSE).


## Contact

Karel Brinda \<kbrinda@hsph.harvard.edu\>

