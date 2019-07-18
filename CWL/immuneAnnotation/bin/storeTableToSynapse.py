'''
stores csv or tsv file to synapse
'''

import synapseclient
syn = synapseclient.Synapse()
from synapseclient import Schema, Column, Table

import pandas as pd
from optparse import OptionParser

# Get synapse ID of files based on path and parent in manifest
# @export
# @requires synapserf
getIdsFromPathParent=function(path.parent.df){
  require(synapser)

  synid=apply(path.parent.df,1,function(x){
   print(x[['parent']])
   children=synapser::synGetChildren(x[['parent']])$asList()
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
  children=synapseclient.getChildren(parentId)
  id=NULL
  for(c in children):
    if(c.name==tablename):
      id=c.id
  if(is.null(id)):
      print('No table found, creating new one')
   syn.store(tablename,parentId,tidied_df))
  else:
    saveResultsToExistingTable(tidied_df,id)



# @requires synapser
# @export
def saveResultsToExistingTable(tidiedDf,tableid):

    print(tableid + 'already exists with that name, adding')
  #first get table schema
  origTab=syn.get(tableid)

  #then get column names
  curCols=[c.name for c in syn.getTableColumns(origTab)]

  #how are they different?
  missingCols=[m for m in curCols if m not in tidiedDf.keys()]

  for(a in missingCols):
    tidiedDf=pd.dataFrame(tidiedDf,rep(NA,tidiedDf.shape[0])))
    colnames(tidiedDf)[ncol(tidiedDf)]=a

    otherCols=[c for c in tidiedDf.keys() if c not in curCols]
 #   print(paste("Syn table missing:",paste(other.cols,collapse=',')))
  for(a in otherCols):
    if(is.numeric(tidied.df[,o])):
      origTab.addColumn(Column(name=o,columnType="DOUBLE"))
    else:
      origTab.addColumn(Column(name=o,type="STRING",maximumSize=100))
                                        # print(dim(tidied.df))
  #  print(orig.tab)
  #  print(head(as.data.frame(tidied.df)))
  #store to synapse
  stab=Table(origTab.properties['id'],tidiedDf)
  #print(stab)
  syn.store(stab)




def main():
    parser = OptionParser()
    parser.add_option("-f", "--file", dest="filename",
                  help="write report to FILE", metavar="FILE")
    parser.add_option("-p", "--parentId",
                   dest="parentId", help="don't print status messages to stdout")
    parser.add_option("-n", "--tableName", dest='name',help='')
    parser.add_option("-t", '--tableId',dest='tid',help='Table ID if table already exists')

    (options, args) = parser.parse_args()
    tab= tab=pd.read_csv(options.filename)


main()
