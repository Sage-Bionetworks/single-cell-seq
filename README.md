# single-cell-seq
The goal of this repository is to maintain a set of tools that facilitate various aspects of single cell RNA-seq, both locally and remotely. Currently this package relies on the `synapser` package and assumes that the work you are doing lives on [Synapse](http://www.synapse.org), so it's best to have a [Synapse account](http://www.synapse.org/register). 

### Install
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

### Immune Cell Annotation Work
Currently we are developing a suite of tools to facilitate immune cell annotation.

### Tumor Deconvolution Tools
This work is ongoing.

### Alignment/Processing Tools
This work is also ongoing!
