#run R md template

##try to use general Rmd template to 

#first format file

#
#synapse file
require(dplyr)
require(tidyr)
require(singleCellSeq)

library(reticulate)
synapse <- import("synapseclient")
syn <- synapse$Synapse()
syn$login()

#define variables for RMd
syn_file<-'syn12045100'
analysis_dir<-"syn12118521"
analysis_file=paste(syn_file,'analysis.html',sep='_')

#define matrix
samp.tab<-read.table(syn$get(syn_file)$path,header=T,as.is=TRUE)%>%dplyr::select(-c(gene_id,gene_type))%>%dplyr::rename(Gene="gene_name") 



require(org.Hs.eg.db)
all.gn<-unique(unlist(as.list(org.Hs.egSYMBOL)))
samp.tab <- samp.tab%>%filter(Gene%in%all.gn)
allz<-which(apply(samp.tab%>%dplyr::select(-Gene),1,function(x) all(x==0)))
if(length(allz)>0)
  samp.tab<-samp.tab[-allz,]

#need to remove the gene column
samp.mat<-samp.tab%>%dplyr::select(-Gene)

print(dim(samp.mat))
rownames(samp.mat) <- make.names(samp.tab$Gene,unique=TRUE)

#define any cell specific annotations
cell.annotations<-data.frame(
  Patient=as.factor(sapply(colnames(samp.tab), function(x) gsub("LN","",unlist(strsplit(x,split='_'))[1]))),
  IsPooled=as.factor(sapply(colnames(samp.tab),function(x) unlist(strsplit(x,split='_'))[2]=="Pooled")),
  IsTumor=as.factor(sapply(colnames(samp.tab),function(x) length(grep('LN',x))==0)))[-1,]

runMarkdown(samp.mat,cell.annotations=cell.annotations,syn_file,analysis_dir)
