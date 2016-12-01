#!/bin/sh
set -eu

# PYTHON.SH
# Intended to run Python on a compute node (from Swift)

PYTHON=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/bin/python

export LD_LIBRARY_PATH=/opt/gcc/4.9.2/snos/lib64:/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/lib

set -x
$PYTHON $*
