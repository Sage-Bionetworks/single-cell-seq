'''
stores csv or tsv file to synapse
'''

import synapseclient

import pandas as pd
from optparse import OptionParser

# Get synapse ID of files based on path and parent in manifest
# @export
# @requires synapserf
getIdsFromPathParent<-function(path.parent.df){
  require(synapser)

  synid<-apply(path.parent.df,1,function(x){
   print(x[['parent']])
   children<-synapser::synGetChildren(x[['parent']])$asList()
    #print(children)
    for(c in children)
      if(c$name==x[['path']])
        return(c$id)})

  path.parent.df$used=synid
  return(select(path.parent.df,c(path,used)))
}



# creates a new table unless one already exists
# reqires synapser
# @export
def saveToTable(tidied_df,tablename,parentId):

  ##first see if there is a table with an existing name
  children<-synapser::synGetChildren(parentId)$asList()
  id<-NULL
  for(c in children):
    if(c$name==tablename):
      id<-c$id
  if(is.null(id)){
      print('No table found, creating new one')
    synapser::synStore(synapser::synBuildTable(tablename,parentId,tidied.df))
  }else{
    saveResultsToExistingTable(tidied.df,id)
  }
}


# @requires synapser
# @export
def saveResultsToExistingTable(tidied.df,tableid):

    print(tableid + 'already exists with that name, adding')
  #first get table schema
  orig.tab<-synGet(tableid)

  #then get column names
  cur.cols<-sapply(as.list(synGetTableColumns(orig.tab)),function(x) x$name)

  #how are they different?
    missing.cols<-setdiff(cur.cols,names(tidied.df))
#    print(paste("DF missing:",paste(missing.cols,collapse=',')))
 # print('orig table')
 # print(dim(tidied.df))
  #then add in values
  for(a in missing.cols){
    tidied.df<-data.frame(tidied.df,rep(NA,nrow(tidied.df)))
    colnames(tidied.df)[ncol(tidied.df)]<-a
  }

    other.cols<-setdiff(names(tidied.df),cur.cols)
 #   print(paste("Syn table missing:",paste(other.cols,collapse=',')))
  for(a in other.cols){
    if(is.numeric(tidied.df[,o]))
      orig.tab$addColumn(synapser::Column(name=o,columnType="DOUBLE"))
    else{
      orig.tab$addColumn(synapser::Column(name=o,type="STRING",maximumSize=100))
    }
  }
 # print('final table')
                                        # print(dim(tidied.df))
  #  print(orig.tab)
  #  print(head(as.data.frame(tidied.df)))
  #store to synapse
  stab<-synapser::Table(orig.tab$properties$id,as.data.frame(tidied.df))
  #print(stab)
  synapser::synStore(stab)
}



def main():
    parser = OptionParser()
    parser.add_option("-f", "--file", dest="filename",
                  help="write report to FILE", metavar="FILE")
    parser.add_option("-p", "--parentId",
                   dest="parentId", help="don't print status messages to stdout")
    parser.add_option("-n", "--tableName", dest='name',help='')
    parser.add_option("-t", '--tableId',dest='tid',help='Table ID if table already exists')




main()
