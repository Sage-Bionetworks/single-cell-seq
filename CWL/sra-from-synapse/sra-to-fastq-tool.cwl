class: CommandLineTool
cwlVersion: v1.0
label: sra-to-fastq-tool
id: sra-to-fastq-tool

baseCommand: /opt/sratoolkit.2.9.6-1-ubuntu64/bin/fastq-dump

arguments: ["--split-files","--gzip"]
requirements:
  DockerRequirement:
    dockerPull: pegi3s/sratoolkit
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.output)
        writable: true

inputs:
  sra-id:
    type: string
    inputBinding:
      position: 1
  output:
    type: Directory

outputs:
  fastq-file:
    type: File[]
    outputBinding:
      glob: "*.gz"
