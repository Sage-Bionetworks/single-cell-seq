#'
#'
#'test out clustering assignment of scRNA data



source("../../R/groupCellsByCluster.R")
source("../../R/immuneCellLists.R")


library(synapser)
synapser::synLogin()
samp.tab<-read.table(synGet('syn12045100')$path,header=T)%>%select(-c(gene_id,gene_type))%>%rename(Gene=gene_name)


#run two methods
res.t<-dataMatrixToCluster.tsne(samp.tab,c(1))
res.p<-dataMatrixToCluster(pca(samp.tab,c(1)))

#get gene and sample annotations
cell.annotations<-data.frame(
  Patient=sapply(colnames(samp.tab), function(x) unlist(strsplit(x,split='_'))[1]),
  Population=sapply(colnames(samp.tab),function(x) unlist(strsplit(x,split='_'))[2]),
  IsTumor=sapply(colnames(samp.tab),function(x) length(grep('LN',x))==0))

#TODO: reformat as data frame
gene.annotations <- getGeneLists('mcpcounter')

#plot annotations with heatmap

#store heatmaps
