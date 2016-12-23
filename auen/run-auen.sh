#!/bin/bash
set -eu

# RUN-AUEN
# Shell wrapper for AUEN on the compute nodes
# Sets up PATH, PYTHONPATH, LD_LIBRARY_PATH, etc.

set -x

echo RUN-AUEN $*
echo PWD $PWD
echo DATE $( date "+%m/%d/%Y %I:%M%p" )

AUEN_HOME=$4

# PYTHON=/usr/bin/python
PYTHON=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/bin/python

# Override HOME to use the Keras rc file in /lustre
export HOME=/lustre/beagle2/$USER

# source /opt/modules/3.2.6.7/init/bash
# module load PrgEnv-gnu

export LD_LIBRARY_PATH=/opt/gcc/4.9.2/snos/lib64:/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/lib

$PYTHON $AUEN_HOME/run-auen.py $*
