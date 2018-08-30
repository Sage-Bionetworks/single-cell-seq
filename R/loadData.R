# This is going to be a large function that loads/processes datasets

#' @param df is a data frame
#' @export 
getSeuratObject<-function(df){
  require(Seurat)
  require(singleCellSeq)
  clust.sres <-dataMatrixToCluster.seurat(df)
  
  clust.sres<-FindClusters(clust.sres)
  
  clust.sres<-RunUMAP(clust.sres)
  clust.sres
}

#'
#'@export
loadChung<-function(){
  require(singleCellSeq)
  library(reticulate)
  require(tidyverse)
  synapse <- import("synapseclient")
  syn <- synapse$Synapse()
  syn$login()
  
  #define variables for RMd
  syn_file<-'syn11967840'
  annotation_file <-'syn11967839'
  analysis_dir<-"syn12494570"
  
  #define matrix
  samp.tab<-read.table(syn$get(syn_file)$path,header=T,as.is=TRUE,sep='\t')%>%dplyr::select(-c(Gene.ID_1,Gene.ID_2))%>%dplyr::rename(Gene="Gene.Symbol") 
  
  require(org.Hs.eg.db)
  all.gn<-unique(unlist(as.list(org.Hs.egSYMBOL)))
  samp.tab <- samp.tab%>%filter(Gene%in%all.gn)
  allz<-which(apply(samp.tab%>%dplyr::select(-Gene),1,function(x) all(x==0)))
  if(length(allz)>0)
    samp.tab<-samp.tab[-allz,]
  
  #need to remove the gene column
  samp.mat<-samp.tab%>%dplyr::select(-Gene)
  
  rownames(samp.mat) <- make.names(samp.tab$Gene,unique=TRUE)
  
  #define any cell specific annotations
  at<-read.table(syn$get('syn11967839')$path,sep='\t',header=T)%>%dplyr::select(Cell,CellType="CELL_TYPE_TSNE",Time,Sample)
  rownames(at)<-at$Cell
  at<-at%>%dplyr::select(-Cell)
  
  return(list(data=samp.mat,annote=at,seurat=getSeuratObject(samp.mat)))
  
}

#'
#'@export
loadSims<-function(){
  
  
}

#'
#'@export
loadChang<-function(){
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
  
  return(list(data=samp.mat,annote=cell.annotations,seurat=getSeuratObject(samp.mat)))
}
