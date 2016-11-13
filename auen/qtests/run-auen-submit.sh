#!/bin/bash
set -eu

# RUN-AUEN
# Shell wrapper for AUEN to set up PATH, PYTHONPATH, etc.

echo PWD $PWD
cd $PBS_O_WORKDIR
echo PWD $PWD

# PYTHON=/usr/bin/python
PYTHON=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/bin/python

export LD_LIBRARY_PATH=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/lib:/opt/gcc/4.9.2/snos/lib64

# Override HOME to use the Keras rc file in /lustre
export HOME=/lustre/beagle2/$USER
echo HOME $HOME

# printenv

source /opt/modules/3.2.6.7/init/bash
module load PrgEnv-gnu

aprun -n 1 $PYTHON /lustre/beagle2/wozniak/proj/codar/auen/run-auen.py 500 500 stdout $PWD
