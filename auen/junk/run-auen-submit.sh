#!/bin/bash
set -eu

# RUN-AUEN
# Shell wrapper for AUEN to set up PATH, PYTHONPATH, etc.

set -x

echo PWD $PWD
cd $PBS_O_WORKDIR
echo PWD $PWD
echo run-auen $*

# PYTHON=/usr/bin/python
PYTHON=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/bin/python

export LD_LIBRARY_PATH=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/lib

# unset LD_LIBRARY_PATH PYTHONPATH

export HOME=/lustre/beagle2/$USER
echo HOME $HOME

# printenv

source /opt/modules/3.2.6.7/init/bash
module load PrgEnv-gnu

aprun -n 1 $PYTHON /lustre/beagle2/wozniak/proj/codar/auen/run-auen.py ARGS()
# aprun -n 1 $PYTHON /lustre/beagle2/wozniak/proj/codar/auen/try_pandas.py $*
# aprun $PYTHON -V
