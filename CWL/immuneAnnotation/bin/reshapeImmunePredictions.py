'''
reshapeImmClass.py
takes a file and any metadata
'''

import pandas as pd
from optparse import OptionParser

'''
reshapeDf
takes a data frame from immclass and reshapes to immune annotation data model
'''
def reshapeImmClassDf(df,training,dn,tumorType='none'):
    tab=pd.read_csv(df,sep='\t')
    preds=[k.split(':')[1] for k in tab.auto]
    gens=tab.general
    newdf=pd.DataFrame(columns=['Dataset name','Cell identifier','Cell Prediction','Algorithm','Tumor Type','Training File'])
    newdf['Dataset name']=['']*len(preds)
    newdf['Algorithm']=['ImmClassifier']*len(preds)
    newdf['Training File']=[training]*len(preds)
    newdf['Cell Prediction']=preds
    newdf['Cell identifier']=gens.keys()
    newdf['Dataset name']=[dn]*len(preds)
    newdf['Tumor Type']=[tumorType]*len(preds)
    print(newdf)

def main():
    parser = OptionParser()
    parser.add_option("-f", "--file", dest="filename",
                  help="name of file to be used")
    parser.add_option("-m", "--modelUsed",
                   dest="model", default='immClassifier',
                  help="Name of model used. Implemented choices are: immClassifier, garnett")
    parser.add_option('-t','--tumorType',
                      dest='tumorType', default='none',help='type of disease')
    parser.add_option('-r','--trainingFile', dest='trainingFile',help='SynID of file used in training')
    parser.add_option('-n','--datasetName', dest='name',help='Name of dataset evaluated')
    (options, args) = parser.parse_args()


    if(options.model.lower()=='immclassifier'):
         reshapeImmClassDf(df=options.filename,training=options.trainingFile,dn=options.name,tumorType=options.tumorType)


if __name__=='__main__':
    main()
