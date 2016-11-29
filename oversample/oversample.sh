#!/bin/bash
set -eu

# OVERSAMPLE.SH
# Simple shell wrapper for oversample call

OUTPUT=$1
shift
PARAMS=$*

export pyInst=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst
export LD_LIBRARY_PATH=$pyInst/lib:$LD_LIBRARY_PATH
export PATH=$pyInst/bin:$PATH
export PYTHONPATH=$pyInst/lib/python2.7:$pyInst/lib/python2.7/site-packages

OVERSAMPLE_TEST=/lustre/beagle2/lpBuild/CANDLE/lorenzo/oversample-test.py

# Override HOME to find Keras rc file
export HOME=/lustre/beagle2/$USER

{
  which python
  echo PYTHONPATH: $PYTHONPATH
  python -u $OVERSAMPLE_TEST $PARAMS
} 2>&1 > $OUTPUT
