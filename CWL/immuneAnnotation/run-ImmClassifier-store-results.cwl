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
  tableparentid:
    type: string
  tablename:
    type: string

outputs:
  tidied-df:
    valueFrom: reshape-results/tidied-df

steps:
  run-imm-classifier:
    run: https://raw.githubusercontent.com/sgosline/ImmClassifier/master/cwl/run-immclassifier.cwl?token=AAODEOTUM2OMGTVXEATVLBS5IBX5U
    in:
      synapse_config: synapse_config
      input-file: input-file
      output-id: output-id
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
    run: https://raw.githubusercontent.com/Sage-Bionetworks/rare-disease-workflows/master/synapse-table-store/synapse-table-store-tool.cwl
    in:
      file: reshape-results/tidied-df
      tableparentid: tableparentid
      tablename: tablename
    out:
      []
