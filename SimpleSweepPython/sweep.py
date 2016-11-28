import sys
import random
from collections import defaultdict
import json, os

def evaluateOne(*arg):
    #print "I was called with", len(arg), "arguments:", arg
    return random.random()

def loadSettings(settingsFilename):
    print("Reading settings: %s" % settingsFilename)
    try:
        with open(settingsFilename) as fp:
            settings = json.load(fp)
    except IOError as e:
        print("Could not open: %s" % settingsFilename)
        print("PWD is: '%s'" % os.getcwd())
        sys.exit(1)
    try:
        params = settings['parameters']
    except KeyError as e:
        print("Settings file (%s) does not contain key: %s" % (settingsFilename, str(e)))
        sys.exit(1)
    return(params)

def expand(Vs, fr, to, soFar):
    soFarNew = []
    for s in soFar:
        for v in Vs[fr]:
             if s == '':
                 soFarNew += [str(v)]
             else:
                 soFarNew += [s+','+str(v)]
    if fr==to:
        return(soFarNew)
    else:
        return expand(Vs, fr+1, to, soFarNew)

def determineParameters(settingsFilename):
    params = loadSettings(settingsFilename)
    values = {}
    for i in range(1, len(params)+1):
        try:
             As = params[str(i)]
        except:
             print('Did not find parameter %i in settings file'%i)
             sys.exit(1)
        values[i] = As
    results = expand(values, 1, len(params), [''])
    result = ':'.join(results)
    return result
        
def extractVals(A):
    B = defaultdict(dict)
    A1 = A.split()
    for n, val in zip(A1[0::2], A1[1::2]):
        B[n] = float(val)
    return(B)

def computeStats(swiftArrayAsString):
    A = extractVals(swiftArrayAsString)
    vals = []
    for a in A:
        vals += [A[a]]
    print('%d values, with min=%f, max=%f, avg=%f\n'%(len(vals),min(vals),max(vals),sum(vals)/float(len(vals))))
    return('ok')
