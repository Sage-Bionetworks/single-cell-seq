id: reshape-immClass
label: reshape-immClass
cwlVersion: v1.0
class: CommandLineTool
baseCommand: /usr/bin/python3

requirements:
   - class: DockerRequirement
     dockerPull: sgosline/reshape-immune-output

arguments:
  - /usr/local/bin/reshapeImmunePredictions.py

inputs:
  file:
    type: File
    inputBinding:
      position: 1
      prefix: --file
  model:
    type: string
    inputBinding:
      position: 2
      prefix: --modelUsed
  tumorType:
    type: string
    inputBinding:
      position: 3
      prefix: --tumorType
  trainingFile:
    type: string
    inputBinding:
      position: 4
      prefix: --trainingFile
  datasetName:
    type: string
    inputBinding:
      position: 5
      prefix: --datasetName

outputs:
  reshaped-data:
    type: stdout

stdout: reshaped-data.tsv
