## scRNA-seq Immune Annotation

This directory stores workflows that tie specific immune annotation tools to existing data and then stores the results in a [Synapse table](https://www.synapse.org/#!Synapse:syn19357073/tables/).These workflows will take data in a single format and run various immune annotation tools on them and harmonize the results. 

#### Tools available
Current tools supported. 
* ImmClassifer: this is currently supported
* Garnett: this is under development
* Moana: this has not been started yet.

#### Files compared

What datasets can be used to run these on? Currently waiting on annotations to be complete.


#### Results
We plan to save results in a [Synapse table](https://www.synapse.org/#!Synapse:syn19357073/tables/) to then carry out analysis on them. Questions we hope to ask include (but are not limited to):
* What immune types are showing up in which tumor types?
* What is the fraction of unannotated cells?
* Which methods agree the most?
...
