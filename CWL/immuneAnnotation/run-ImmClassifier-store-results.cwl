label: run-ImmClassifier-store-results
id:  run-ImmClassifier-store-results
class: Workflow
cwlVersion: v1.0


inputs:
  file-id:
    type: String
  synapse_cofig:
    type: File
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
      input-file: file-id
      output-id:
      prob-unknown:
      output-name:
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
