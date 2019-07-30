label: run-ImmClassifier-store-results
id:  run-ImmClassifier-store-results
class: Workflow
cwlVersion: v1.0

inputs:
  synapse-config:
    type: File
  input-file:
    type: string
  output-name:
    type: string
  output-id:
    type: string
  prob_unknown:
    type: double
  tableparentid:
    type: string[]
  tablename:
    type: string[]
  model:
    type: string
  tumor-type:
    type: string
  training-file:
    type: string
  dataset-name:
    type: string

outputs:
  tidied-df:
    type: File
    outputSource: reshape-results/reshaped-data

requirements:
  - class: SubworkflowFeatureRequirement

steps:
  run-imm-classifier:
    run: /Users/sgosline/Code/ImmClassifier/cwl/imm-class-workflow.cwl
    in:
      input-file: input-file
      synapse_config: synapse-config
      prob_unknown: prob_unknown
      output-name: output-name
      output-id: output-id
    out:
      [preds]
  reshape-results:
    run: steps/reshape-immClass.cwl
    in:
      file: run-imm-classifier/preds
      model: model
      tumorType: tumor-type
      trainingFile: training-file
      datasetName: dataset-name
    out:
      [reshaped-data]
  store-to-table:
    run: https://raw.githubusercontent.com/Sage-Bionetworks/rare-disease-workflows/master/synapse-table-store/synapse-table-store-tool.cwl
    in:
      synapse_config: synapse-config
      file: reshape-results/reshaped-data
      tableparentid: tableparentid
      tablename: tablename
    out:
      []
