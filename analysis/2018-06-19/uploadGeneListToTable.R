##upload gene list to table
require(synapser)
synapser::synLogin()

marker.list=synapser::synGet('syn12556238')$path
library(readxl)
require(tidyverse)

markers.lyons<-readxl::read_excel(marker.list,sheet=2)%>%gather("Cell Type","Gene Name")
markers.wallet <-readxl::read_excel(marker.list,sheet=3)%>%gather("Cell Type","Gene Name")

full.tab<-rbind(data.frame(markers.lyons,Source='LyonsEtAl',check.names=F),
    data.frame(markers.wallet,Source='Wallet',check.names=F))%>%select("Gene Name","Cell Type","Source")
nas=which(is.na(full.tab$`Gene Name`))

if(length(nas)>0)
  full.tab<-full.tab[-nas,]

print(head(full.tab))



#here is the list where the genes need to go.
gene.marker.tab='syn12211688'
schema<-synapser::synGet(gene.marker.tab)
tab<-Table(schema,full.tab)
table<-synStore(tab)
