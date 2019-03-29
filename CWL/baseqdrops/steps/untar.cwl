#!/usr/bin/env cwl-runner
#
# Authors: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool

baseCommand: 
- tar
- xvzf

inputs:

- id: tar_file
  type: File
  inputBinding:
    position: 1
        
outputs:

- id: dir
  type: Directory
  outputBinding: 
    glob: "*"

