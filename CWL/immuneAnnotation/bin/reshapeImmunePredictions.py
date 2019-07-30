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
    newdf.to_csv()

def main():
    parser = OptionParser()
    parser.add_option("-f", "--file", dest="filename",
                  help="write report to FILE", metavar="FILE")
    parser.add_option("-m", "--modelUsed",
                   dest="model", default=['immClassifier','garnett'],
                  help="don't print status messages to stdout")
    parser.add_option('-t','--tumorType',
                      dest='tumorType',default='none')
    parser.add_option('-r','--trainingFile',help='SynID of file used in training')

    (options, args) = parser.parse_args()



main()
