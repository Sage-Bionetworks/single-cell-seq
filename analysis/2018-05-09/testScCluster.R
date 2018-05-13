#'
#'
#'test out clustering assignment of scRNA data


library(synapser)
synLogin()
source("../../R/groupCellsByCluster.R")

tab<-read.table(synGet('syn12045100')$path,header=T)

#run two methods
res.t<-dataMatrixToCluster.tsne(tab,c(1:3))
res.p<-dataMatrixToCluster(pca(tab,c(1:3)))

#save annotations

#annotate heatmap with clusters

#store heatmaps
