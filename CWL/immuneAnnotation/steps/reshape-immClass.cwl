id: reshape-immClass
label: reshape-immClass
cwlVersion: v1.0
class: CommandLineTool
baseCommand: python

requirements:
   - class: DockerRequirement
     dockerPull: sgosline/

arguments:
  - /usr/local/bin/reshapeImmunePredictions.py

inputs:
  synapse_config:
   type: File
  file:
    type: File
    inputBinding:
      position: 1
      prefix: --file
