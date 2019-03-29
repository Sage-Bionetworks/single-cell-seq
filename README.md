# single-cell-seq
The goal of this repository is to maintain a set of tools that facilitate various aspects of single cell RNA-seq, both locally and remotely. Currently this package relies on the `synapser` package and assumes that the work you are doing lives on [Synapse](http://www.synapse.org), so it's best to have a [Synapse account](http://www.synapse.org/register). 

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

## Workflows
We are building out workflows using the Common Workflow Language (CWL). These tools are stored [here](CWL/) and are fall into numerous categories.

### Alignment/Processing Tools
We are currently building workflows to enable alignment of single-cell sequencing that can be found in the workflows directory. 
* Baseq

### Quality control tools
TBD

### Immune Cell Annotation Work
TBD

