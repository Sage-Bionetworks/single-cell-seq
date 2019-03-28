#!/usr/bin/env cwl-runner
# Author: Andrew lamb

cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement

inputs:

  p1_fastq_ids: string[]
  p2_fastq_ids: string[]
  index_dir: Directory
  sample_name: string
  synapse_config: File
  reference_genome: string?
  protocol: string?

outputs:

- id: reads_file 
  type: File
  outputSource: 
  - baseqdrops/reads_file

- id: umi_file 
  type: File
  outputSource: 
  - baseqdrops/umi_file


steps:

- id: download_p1_fastqs
  run: https://raw.githubusercontent.com/Sage-Bionetworks/synapse-client-cwl-tools/master/synapse-get-tool.cwl
  scatter: synapseid
  in:
    synapseid: p1_fastq_ids
    synapse_config: synapse_config
  out:
  - filepath
  
- id: unzip_p1_fastqs
  run: steps/unzip_file_conditionally.cwl
  scatter: zipped_file
  in:
    zipped_file: download_p1_fastqs/filepath
  out: 
  - unziped_file
  
- id: cat_p1_fastqs
  run: steps/cat.cwl
  in:
    files: unzip_p1_fastqs/unziped_file
  out: 
  - file

- id: download_p2_fastqs
  run: https://raw.githubusercontent.com/Sage-Bionetworks/synapse-client-cwl-tools/master/synapse-get-tool.cwl
  scatter: synapseid
  in:
    synapseid: p2_fastq_ids
    synapse_config: synapse_config
  out:
  - filepath
  
- id: unzip_p2_fastqs
  run: steps/unzip_file_conditionally.cwl
  scatter: zipped_file
  in:
    zipped_file: download_p2_fastqs/filepath
  out: 
  - unziped_file
  
- id: cat_p2_fastqs
  run: steps/cat.cwl
  in:
    files: unzip_p2_fastqs/unziped_file
  out: 
  - file

- id: baseqdrops
  run: steps/baseqdrops.cwl
  in:
    index_dir: index_dir
    sample_name: sample_name
    fastq1: cat_p1_fastqs/file
    fastq2: cat_p2_fastqs/file
    reference_genome: reference_genome
    protocol: protocol
  out: 
  - reads_file
  - umi_file

