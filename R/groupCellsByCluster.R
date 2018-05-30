#' annotate scRNA-seq matrix by cluster
#' 
#' 


#' dataMatrixToCluster.tsne is a function to cluster a data matrix
#' by t-SNE and return an annotated list of cells
#' @export
dataMatrixToCluster.tsne <-function(df, cols.to.exclude=c()){
  require(tsne) 
  if(length(cols.to.exclude)>0)
    df<-df[,-cols.to.exclude]
  res<-tsne(df,max_iter=100)
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

cellClustersToSynapse <-function(){
  
}

#' runs dbscan to determine clusters
#' @export 
dbScanPrep <-function(data,MIN.CLUSTER.SIZE=2,EPS=0.005){
  require(dbscan)
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
