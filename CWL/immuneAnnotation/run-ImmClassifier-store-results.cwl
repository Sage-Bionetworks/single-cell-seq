label: run-ImmClassifier-store-results
id:  run-ImmClassifier-store-results
class: Workflow
cwlVersion: v1.0


inputs:
  input-file:
    type: string
  output-name:
    type: string
  synapse_config:
    type: File
  output-id:
    type: string
  prob_unknown:
    type: double
  tableid:
    type: String

outputs:
  []

steps:
  get-input:

  run-imm-classifier:
    run: https://raw.githubusercontent.com/sgosline/ImmClassifier/master/cwl/run-immclassifier.cwl?token=AAODEOR2YUQDSI7S4EBQGCC5BMBBQ
    in:
      synapse_config: synapse_config
      input-file: input-file
      output-id:output=id
      prob-unknown: prob_unknown
      output-name: output-name
    out:
      [preds]
  reshape-results:
    run: steps/reshape-immClass.cwl
    in:
      file-to-shape: run-imm-classifier/preds
    out:
      [tidied-df]
  store-to-table:
    run: steps/store-to-table.cwl
    in:
      file-to-store: reshape-results/tidied-df
      table-id: tableid
    out:
      []
