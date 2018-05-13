#' annotate scRNA-seq matrix by cluster
#' 
#' 


#' dataMatrixToCluster.tsne is a function to cluster a data matrix
#' by t-SNE and return an annotated list of cells
dataMatrixToCluster.tsne <-function(df, cols.to.exclude){
  require(tsne) 
  res<-tsne(df[,-cols.to.exclude])
  return(res)
}


#' dataMatrixToCluster.pca is a function to cluster a data matrix
#' by t-SNE and return an annotated list of cells
dataMatrixToCluster.pca <-function(df, cols.to.exclude){
  res<-prcomp(df[,cols.to.exclude])
    return(res)
}

cellClustersToSynapse <-function(){
  
}
