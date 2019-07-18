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
def reshapeImmClassDf(df):



def main():
    parser = OptionParser()
    parser.add_option("-f", "--file", dest="filename",
                  help="write report to FILE", metavar="FILE")
    parser.add_option("-m", "--modelUsed",
                   dest="model", default=['immClassifier','garnett'],
                  help="don't print status messages to stdout")

    (options, args) = parser.parse_args()



main()
