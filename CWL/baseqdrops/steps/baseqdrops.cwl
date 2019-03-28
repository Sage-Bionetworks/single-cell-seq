#!/usr/bin/env cwl-runner
# Author: Xindi Guo

cwlVersion: v1.0
class: CommandLineTool

doc: process fastq files from 10X, indrop and Drop-seq

baseCommand: run-pipe

arguments:
- --config
- config_drops.ini

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: config_drops.ini
        entry: |
          [Drops]
          samtools = samtools
          star = STAR
          whitelistDir = /usr/app/baseqDrops/whitelist
          cellranger_ref_hg38 = $(inputs.index_dir.path)

hints:
  DockerRequirement:
    dockerPull: guoxindi/baseqdrops

inputs:
- id: index_dir
  type: Directory
        
- id: sample_name # specimenID in annotation
  type: string
  inputBinding:
     prefix: --name
  
- id: fastq1
  type: File
  inputBinding:
    prefix: --fq1 

- id: fastq2
  type: File
  inputBinding:
    prefix: --fq2 

- id: reference_genome
  type: string
  default: "hg38"
  inputBinding:
    prefix: --genome
  
- id: protocol
  type: string
  default: "10X"
  inputBinding:
    prefix: --protocol  
  
outputs:

- id: umi_file
  type: File
  outputBinding: 
    glob: $(inputs.sample_name + "/Result.UMIs." + inputs.sample_name + ".txt")

- id: reads_file
  type: File
  outputBinding: 
    glob: $(inputs.sample_name + "/Result.Reads." + inputs.sample_name + ".txt")

- id: baseqdrops_dir
  type: Directory
  outputBinding: 
    glob: $(inputs.sample_name)
