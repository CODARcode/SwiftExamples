"""
Python implementation of a simple cross product parameter sweep, for use with
run-sweep.swift. Functions are imported and called by swift.
"""
import sys
import random
from collections import defaultdict
import json, os


def evaluateOne(*arg):
    """Run a single experiment with the specified args."""
    #print "I was called with", len(arg), "arguments:", arg
    return random.random()


def loadSettings(settingsFilename):
    """Load JSON settings file that defines parameter search space.

    The file must have the following format:
        { 'parameters' : {'1' : numList1, '2': numList2, ...} }
    """
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
        print("Settings file (%s) does not contain key: %s"
              % (settingsFilename, str(e)))
        sys.exit(1)
    return params


def expand(Vs, fr, to, soFar):
    """Recursive function for computing cross product.

    Result is a list of ',' delimited strings of numbers, each of which
    is one element of the cross product.

    Params:
    Vs -- dictionary mapping consecutive integers (starting at 1) to lists
          of numbers, cross product is computed across all the lists
    fr -- index of current list being expanded
    to -- max index in Vs
    soFar -- result of previous list expansions
    """
    soFarNew = []
    for s in soFar:
        for v in Vs[fr]:
             if s == '':
                 soFarNew += [str(v)]
             else:
                 soFarNew += [s + ',' + str(v)]
    if fr == to:
        return soFarNew
    else:
        return expand(Vs, fr+1, to, soFarNew)


def determineParameters(settingsFilename):
    """Compute cross product of params file and convert to string.

    Format of the result is a ':' delimited string with elements that are
    comma delimited.
    """
    params = loadSettings(settingsFilename)
    values = {}
    for i in range(1, len(params)+1):
        try:
            As = params[str(i)]
        except:
            print('Did not find parameter %i in settings file' % i)
            sys.exit(1)
        values[i] = As
    results = expand(values, 1, len(params), [''])
    result = ':'.join(results)
    return result
        

def extractVals(A):
    """Convert a swift repr of an associative array to a Python dictionary.
    
    The format of swift repr is a flat space delimited list alternating
    between key and value.
    """
    B = dict()
    A1 = A.split()
    for n, val in zip(A1[0::2], A1[1::2]):
        B[n] = float(val)
    return B


def computeStats(swiftArrayAsString):
    """Compute stats of a swift associative array.

    Params:
    swiftArrayAsString -- swift repr of a swift associative array
    """
    A = extractVals(swiftArrayAsString)
    vals = A.values()
    print('%d values, with min=%f, max=%f, avg=%f\n'
          % (len(vals), min(vals), max(vals), sum(vals)/float(len(vals))))
    return 'ok'
