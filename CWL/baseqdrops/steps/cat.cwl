#!/usr/bin/env cwl-runner
# Author: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool

baseCommand: cat

inputs:

- id: files
  type: File[]
  inputBinding:
    position: 1

- id: file_name
  type: string
  default: "out.txt"
        
outputs:

- id: file
  type: stdout

stdout: $(inputs.file_name)

