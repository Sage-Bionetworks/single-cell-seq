# From raw data to immune annotation in single cell sequencing
The goal of this repository is to maintain a set of tools that facilitate various aspects of single cell RNA-seq, both locally and remotely. Currently this package relies on the `synapser` package and assumes that the work you are doing lives on [Synapse](http://www.synapse.org), so it's best to have a [Synapse account](http://www.synapse.org/register). This repository is a combined effort across the [CSBC/PS-ON scRNA-Seq working group](http://synapse.org/scrnaseq).

## Overview
Below is a depiction of the various tools being developed as part of this [working group](http://synapse.org/scrnaseq)
![Alt text](scRNA-seq-proc.png?raw=true "Workflows")

Together with the help of various institutions within the CSBC/PS-ON community we are building a suite of tools to carry out various aspects of single-cell sequencing, described below.

| Processing Step | Available Tool | Workflow | Description |
| ---- | ---- | --- | --- |
| Raw sequence to counts | [baseqdrops](https://github.com/beiseq/baseqDrops) | [CWL/baseqdrops](CWL/baseqdrops) | This is a Synapse-to-raw-count tool|
| Raw sequence to counts | [dropest]() | [CWL/dropest](CWL/dropest) | This is still under development |
| Remove dead cells | [scRNASeqWC](https://github.com/sgosline/scRNAseqQC) | [scRNAseqQC](https://github.com/sgosline/scRNAseqQC) | Currently under development|
| Immune prediction | [ImmClassifier]() | [CWL/immuneAnnotation](CWL/immuneAnnotation) | Here we have the tools required to run and store immune annotaiton results |
| Immune annotation benchmarking | [scRNASeqBenchmark](https://github.com/tabdelaal/scRNAseq_Benchmark) | [Xindi put your repo here]() | Here we have the tools required to run and store immune annotaiton results across multiple tools|

## Install
Installation of this package requires the `devtools` package.

```
install.packages("devtools")
devtools::install_github('Sage-Bionetworks/single-cell-seq')
```

If you do not already have the `synapser` package:
```
install.packages("synapser", repos=c("https://sage-bionetworks.github.io/ran", "http://cran.fhcrc.org"))
```
Now you are ready to go!
