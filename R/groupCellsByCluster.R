#' annotate scRNA-seq matrix by cluster
#' 
#' @export
doCluster<-function(method,clust.sres){

  plots=switch(method,
    "PCA"=  Seurat::PCAPlot(clust.sres),
    "t-SNE" =   Seurat::TSNEPlot(clust.sres),
    "UMAP" =  Seurat::DimPlot(clust.sres,reduction.use='umap'))

    plots
}

#' dataMatrixToCluster.tsne is a function to cluster a data matrix
#' by t-SNE and return an annotated list of cells
#' @export
dataMatrixToCluster.tsne <-function(df, cols.to.exclude=c()){
  require(Rtsne,quietly=T) 
  if(length(cols.to.exclude)>0)
    df<-df[,-cols.to.exclude]
  res<-Rtsne(t(df),max_iter=100,perplexity = 20, min_cost = 0.0000001)$Y
  colnames(res)<-c('Dim1','Dim2')
  rownames(res)<-colnames(df)
  return(res)
}


#' dataMatrixToCluster.pca is a function to cluster a data matrix
#' by t-SNE and return an annotated list of cells
#' @param df
#' @param cols.to.exclude
#' @export
dataMatrixToCluster.pca <-function(df, cols.to.exclude=c()){
  if(length(cols.to.exclude)>0)
    df<-df[,-cols.to.exclude]
  pc<-prcomp(df,scale.=TRUE)
  res<-data.frame(pc$rotation[,1:2])
  rownames(res)<-colnames(df)
    return(res)
}


#' dataMatrixToCluster.seurat is a function to cluster a data matrix
#' by seurat and return an annotated list of cells
#' @param df
#' @param cols.to.exclude
#' @export
dataMatrixToCluster.seurat<-function(df,cols.to.exclude=c(),method='all'){
  library(Seurat)
  res<-CreateSeuratObject(df)
  res<-NormalizeData(object = res, normalization.method = "LogNormalize",scale.factor = 10000)
  res<-FindVariableGenes(res,do.plot=FALSE)
  res<-ScaleData(res)
#  if(method%in%c('all','PCA','UMAP')
  res<-RunPCA(res,do.print=FALSE)
  if(method%in%c('all','t-SNE','UMAP'))
    res<-RunTSNE(res)
  
  res
    
}

#' runs dbscan to determine clusters
#' @export 
dbScanPrep <-function(data,MIN.CLUSTER.SIZE=2,EPS=0.005){
  require(dbscan,quietly=T)
  #code from jeff
 # x <- data[["X"]] 
#  y <- data[["Y"]] 
  xy <- data
  I <- 1:nrow(xy) 
 # FIRST.INDEX <- 1 
  clust <- rep(0, nrow(xy)) 
  #I <- data[["Cluster"]] == 1 
  #FIRST.INDEX <- max(data[["Cluster"]]) + 1 
  #clust <- data[["Cluster"]] 
  db.results <- dbscan(xy[I,], EPS, minPts=MIN.CLUSTER.SIZE) 
  #clust[I] <- db.results$cluster + FIRST.INDEX
  cres<-db.results$cluster
  names(cres)<-rownames(xy)
  cres
}
