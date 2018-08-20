#runMarkdown

#' runMarkdown is a function to prouduce rMd analysis files
#' @export
runMarkdown<-function(samp.mat,cell.annotations,syn_file,analysis_dir){
  #then knit file
  library(rmarkdown)
  
  #params=list(samp.mat=samp.mat,cell.annotations=at)
  rmd<-system.file('processing_clustering_vis.Rmd',package='singleCellSeq')
  
  kf<-rmarkdown::render(rmd,rmarkdown::html_document(),output_file=paste(getwd(),'/processing_cluster_vis.html',sep=''),params=list(samp.mat=samp.mat,gene.list='mcpcounter'))
  
  syn$store(synapse$File(kf,parentId=analysis_dir),executed=paste("https://raw.githubusercontent.com/Sage-Bionetworks/single-cell-seq/master/analysis/",syn_file,"/run_",syn_file,"_analysis.R",sep=''),used=syn_file)
  
  ##then try to detach seurat and plo the other file
  
  rmd<-system.file('heatmap_vis.Rmd',package='singleCellSeq')
  kf<-rmarkdown::render(rmd,rmarkdown::html_document(),output_file=paste(getwd(),'/heatmap_vis.html',sep=''),params=list(samp.mat=samp.mat,cell.annotations=cell.annotations))
  
  syn$store(synapse$File(kf,parentId=analysis_dir),executed=paste("https://raw.githubusercontent.com/Sage-Bionetworks/single-cell-seq/master/analysis/",syn_file,"/run_",syn_file,"_analysis.R",sep=''),used=syn_file)
  
}
#' launchApp is a function to prouducea shiny app for a dataste
#' @export
launchApp<-function(sample.mat,cell.annotations){
  
}
