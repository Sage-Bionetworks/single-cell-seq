#'
#'
#'test out clustering assignment of scRNA data



source("../../R/groupCellsByCluster.R")
source("../../R/immuneCellLists.R")


library(synapser)
library(tidyverse)
synapser::synLogin()
samp.tab<-read.table(synGet('syn12045100')$path,header=T)%>%select(-c(gene_id,gene_type))%>%rename(Gene=`gene_name`)


#run two methods
#res.t<-dataMatrixToCluster.tsne(samp.tab,c(1))
res.p<-dataMatrixToCluster.pca(samp.tab,c(1))

#get gene and sample annotations
cell.annotations<-data.frame(
  Patient=sapply(colnames(samp.tab), function(x) unlist(strsplit(x,split='_'))[1]),
  IsPooled=sapply(colnames(samp.tab),function(x) unlist(strsplit(x,split='_'))[2]=="Pooled"),
  IsTumor=sapply(colnames(samp.tab),function(x) length(grep('LN',x))==0))

#TODO: reformat as data frame
g.list <- getGeneList('mcpcounter')

#plot annotations with heatmap

#store heatmaps
#g.list<-lapply(gene.annotations%>%split(.$Cell),function(x) x$Gene)
require(GSVA)
gmat<-samp.tab%>%select(-Gene)
rownames(gmat)<-make.names(samp.tab$Gene,unique=TRUE)
g.res<-gsva(as.matrix(gmat),g.list,method='ssgsea',rnaseq=TRUE)


