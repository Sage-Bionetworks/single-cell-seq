##add new dataset to table
csv<-read.csv('~/Downloads/cell markers - schelker et al - Sheet1.csv',sep=',')

require(synapser)
synLogin()

##create table from markers
require(tidyverse)
#first gather header into a single column
tab<-csv%>%gather(key="Operator",value="Gene",c(2:4))

full.tab<-tab%>%separate("Gene",c('g1','g2','g3','g4','g5','g6','g7','g8','g9'),sep=', ',remove=F,extra="merge")%>%gather(key="go",value="geneName",c(4:12))%>%subset(!is.na(geneName))%>%dplyr::select(`Cell Type`='Cell.type',Operator,`Gene Name`=geneName)

full.tab$Source=rep('SchelkerEtAl',nrow(full.tab))

#then separate out by comma

gene.marker.tab<-'syn12211688'

schema<-synapser::synGet(gene.marker.tab)
tab<-Table(schema,full.tab)
table<-synStore(tab)

