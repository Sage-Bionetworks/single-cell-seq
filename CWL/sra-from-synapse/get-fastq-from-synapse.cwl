class: Workflow
cwlVersion: v1.0
id: get-fastq-from-synapse
label: get-fastq-from-synapse


inputs:
  synapse_config:
    type: File
  synapse_id:
    type: string
  outputdir:
    type: Directory

outputs:
  fastq-file:
    type: File
    outputSource: get-fastq/fastq-file

steps:
  get-sra:
    run: https://raw.githubusercontent.com/Sage-Bionetworks/synapse-client-cwl-tools/master/synapse-get-tool.cwl
    in:
      synapse_config: synapse_config
      synapseid: synapse_id
    out:
      [filepath]
  get-fastq:
    run: sra-to-fastq-tool.cwl
    in:
      sra-id: get-sra/filepath
      output: outputdir
    out:
      [fastq-file]
