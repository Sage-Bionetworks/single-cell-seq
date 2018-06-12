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
https://github.com/CRI-iAtlas/iatlas-tool-cibersort
https://github.com/CRI-iAtlas/irwg-tool-mitcr
https://github.com/CRI-iAtlas/iatlas-tool-epic
https://github.com/CRI-iAtlas/iatlas-tool-mcpcounter
https://github.com/CRI-iAtlas/iatlas-tool-demixt

### Alignment/Processing Tools
We will work to add tool to this over the summer.

### other
https://github.com/Sage-Bionetworks/fastq_mixer:
- uses fastq tools to sample from one or mix two or more fastq files to create a new one

https://github.com/Sage-Bionetworks/kallisto_cwl:
- cwltools for kallisto index, quant, and h5dump

https://github.com/Sage-Bionetworks/fastq_mixing_workflow_cwl:
- composition of the two above repos to go from fastqs to tpms

https://github.com/Sage-Bionetworks/synapse_python_client_cwl
- for using synapse python client to download and upload files
=======
This work is ongoing.

### Alignment/Processing Tools
This work is also ongoing!

