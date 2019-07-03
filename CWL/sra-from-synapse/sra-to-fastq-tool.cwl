class: CommandLineTool
cwlVersion: v1.0
label: sra-to-fastq-tool
id: sra-to-fastq-tool

baseCommand: /opt/sratoolkit.2.9.6-1-ubuntu64/bin/fastq-dump

requirements:
  DockerRequirement:
    dockerPull: pegi3s/sratoolkit
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.output)
        writable: true

inputs:
  sra-id:
    type: File
    inputBinding:
      position: 1
  output:
    type: Directory
    inputBinding:
      position: 2
      prefix: --outdir

outputs:
  fastq-file:
    type: File
