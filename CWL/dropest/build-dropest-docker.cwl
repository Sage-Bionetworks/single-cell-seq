label: build-dropest-docker
id: build-dropest-docker
cwlVersion: v1.0
class: CommandLineTool

baseCommand: docker

arguments: [build,https://raw.githubusercontent.com/hms-dbmi/dropEst/master/dockers/centos7/Dockerfile]

inputs: []
outputs: []
