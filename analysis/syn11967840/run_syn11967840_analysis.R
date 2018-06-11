#run R md template

##try to use general Rmd template to 

#first format file

#
#synapse file
require(synapser)
require(tidyverse)
require(singleCellSeq)
synapser::synLogin()

#define variables for RMd
syn_file<-'syn11967840'
annotation_file <-'syn11967839'
analysis_dir<-"syn12494570"

#define matrix
samp.tab<-read.table(synapser::synGet(syn_file)$path,header=T,as.is=TRUE,sep='\t')%>%dplyr::select(-c(Gene.ID_1,Gene.ID_2))%>%dplyr::rename(Gene="Gene.Symbol") 

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
at<-read.table(synGet('syn11967839')$path,sep='\t',header=T)%>%dplyr::select(Cell,CellType="CELL_TYPE_TSNE",Time,Sample)
rownames(at)<-at$Cell
at<-at%>%dplyr::select(-Cell)

#then knit file
library(rmarkdown)

#params=list(samp.mat=samp.mat,cell.annotations=at)
rmd<-system.file('processing_clustering_vis.Rmd',package='singleCellSeq')
kf<-rmarkdown::render(rmd,html_document(),params=list(samp.mat=samp.mat,cell.annotations=at))

#
synapser::synStore(File(kf,parentId=analysis_dir),executed=paste("https://raw.githubusercontent.com/Sage-Bionetworks/single-cell-seq/master/analysis/",syn_file,"/processing_clustering_vis.Rmd",sep=''),used=syn_file)

