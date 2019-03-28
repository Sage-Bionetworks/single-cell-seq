#!/usr/bin/env cwl-runner
# Author: Andrew lamb

cwlVersion: v1.0
class: Workflow

inputs:

  idquery: string
  sample_query: string
  synapse_config: File
  index_id:
    type: string
    default: "syn18460306"
  reference_genome: string?
  protocol: string?

outputs:

- id: reads_file_array 
  type: File[]
  outputSource: 
  - baseqdrop_workflow/reads_file

- id: umi_file_array 
  type: File[]
  outputSource: 
  - baseqdrop_workflow/umi_file

requirements:
  - class: SubworkflowFeatureRequirement
  - class: ScatterFeatureRequirement

steps:

- id: get-fv
  run: https://raw.githubusercontent.com/Sage-Bionetworks/synapse-client-cwl-tools/master/synapse-query-tool.cwl
  in:
    synapse_config: synapse_config
    query: idquery
  out: 
  - query_result

- id: get-samples-from-fv
  run: steps/breakdown.cwl
  in:
     query_tsv: get-fv/query_result
  out:
  - names
  - mate1_id_arrays
  - mate2_id_arrays

- id: download_index
  run: https://raw.githubusercontent.com/Sage-Bionetworks/synapse-client-cwl-tools/master/synapse-get-tool.cwl
  in:
    synapseid: index_id
    synapse_config: synapse_config
  out: 
  - filepath  

- id: untar_index
  run: steps/untar.cwl
  in:
    tar_file: download_index/filepath
  out: 
  - dir

- id: baseqdrop_workflow
  run: baseqdrops_workflow.cwl
  in:
    p1_fastq_ids: get-samples-from-fv/mate1_id_arrays
    p2_fastq_ids: get-samples-from-fv/mate2_id_arrays
    index_dir: untar_index/dir
    sample_name: get-samples-from-fv/names
    synapse_config: synapse_config
    reference_genome: reference_genome
    protocol: protocol
  scatter:
  - sample_name
  - p1_fastq_ids
  - p2_fastq_ids
  scatterMethod: dotproduct 
  out:
  - umi_file
  - reads_file



#- id: get-clinical
#  run: https://raw.githubusercontent.com/Sage-Bionetworks/synapse-client-cwl-tools/master/synapse-query-tool.cwl
#  in:
#    synapse_config: synapse_config
#    query: sample_query
#  out:
#  - query_result
