#!/bin/bash
set -eu

# RUN-AUEN
# Shell wrapper for AUEN to set up PATH, PYTHONPATH, LD_LIBRARY_PATH, etc.

echo RUN-AUEN $*

echo PWD $PWD

# PYTHON=/usr/bin/python
PYTHON=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/bin/python

# Override HOME to use the Keras rc file in /lustre
export HOME=/lustre/beagle2/$USER

# source /opt/modules/3.2.6.7/init/bash
# module load PrgEnv-gnu

export LD_LIBRARY_PATH=/opt/gcc/4.9.2/snos/lib64:/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/lib

$PYTHON /lustre/beagle2/wozniak/proj/codar/auen/run-auen.py $*
