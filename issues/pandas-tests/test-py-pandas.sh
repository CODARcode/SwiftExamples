#!/bin/sh

# On the login node, this produces
# ImportError: Missing required dependencies ['numpy']

set -eu
set -x

PYTHON_HOME=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst
PYTHON=$PYTHON_HOME/bin/python

GCC492=/opt/gcc/4.9.2/snos/lib64
export LD_LIBRARY_PATH=$PYTHON_HOME/lib:$GCC492
export PYTHONPATH=$PYTHON_HOME/lib/python2.7/site-packages

$PYTHON try-pandas.py
