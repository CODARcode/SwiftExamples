#!/bin/sh
set -eu
set -x

# On the login node, this produces
# ImportError: Missing required dependencies ['numpy']
# NOT ANYMORE- Nov. 30

. settings.cfg

PYTHON=$PYTHON_HOME/bin/python

export LD_LIBRARY_PATH=$PYTHON_HOME/lib:$GCC492/snos/lib64
export PYTHONPATH=$PYTHON_HOME/lib/python2.7/site-packages

$PYTHON try-pandas.py
