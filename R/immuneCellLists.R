#'
#'evaluate subsets of gene expression markers
#'
#'

#' getGeneList grabs the gene list from teh synapse table
#' @export 
getGeneList <- function(method='cibersort'){
  geneListTable <- 'syn12211688'
  require(synapser,quietly=T)
  require(dplyr)
  if(is.null(PythonEmbedInR::pyGet("syn.username")))
    synapser::synLogin()

  
  tab <- synTableQuery(paste('select * from',geneListTable))$asDataFrame()%>%dplyr::select(Gene=`Gene Name`,Cell=`Cell Type`,Source,Operator)
  
  ##first make into a list of lists
  tab.list<-lapply(split(tab,tab$Source),function(x) lapply(split(x,x$Cell),function(y) y$Gene))
  
  if(method%in%(unique(tab$Source)))
    tab.list<-tab.list[[method]]
  
  return(tab.list)
  
}

#'get list of clusters, annotate by 
plotGeneListByCluster <-function(gene.annotations,samples,cell.annotations){
  require(pheatmap)
  require(dplyr)
  #reduce table to gene set
  red.tab<-subset(samples,Gene%in%rownames(gene.annotations))
  
  #hope this works
  rownames(red.tab)<-red.tab$Gene
  
  red.tab<-dplyr::select(red.tab,-Gene)
  
  #remove zero variance rows/columns
  zv<-which(apply(red.tab,1,var)==0)
  if(length(zv)>0)
    red.tab<-red.tab[-zv,]
  
  zv<-which(apply(red.tab,2,var)==0)
  if(length(zv)>0)
    red.tab<-red.tab[,-zv]
  
  #plot
  pheatmap(log10(1+red.tab),
    annotation_row = gene.annotations,
    clustering_distance_rows='correlation',
    clustering_distance_cols='correlation',
    clustering_method='ward.D2')
  
}
