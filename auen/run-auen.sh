#!/bin/bash
set -eu

# RUN-AUEN
# Shell wrapper for AUEN to set up PATH, PYTHONPATH, etc.

echo run-auen $*

# PYTHON=/usr/bin/python
PYTHON=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/bin/python

export LD_LIBRARY_PATH=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/lib

# unset LD_LIBRARY_PATH PYTHONPATH

export HOME=/lustre/beagle2/$USER
declare HOME


$PYTHON ./run-auen.py $*
