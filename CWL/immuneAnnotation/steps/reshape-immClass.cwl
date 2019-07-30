id: reshape-immClass
label: reshape-immClass
cwlVersion: v1.0
class: CommandLineTool
baseCommand: Rscript

requirements:
   - class: DockerRequirement
     dockerPull: nfosi/synapse-table-store

arguments:
  - /usr/local/bin/synapse-table-store.R

inputs:
  synapse_config:
   type: File
  file:
    type: File
    inputBinding:
      position: 1
      prefix: --file
