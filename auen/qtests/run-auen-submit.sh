#!/bin/bash
set -eu

# RUN-AUEN
# PBS submit script for AUEN: sets up PATH, PYTHONPATH, etc.
# Invoke submit-run.sh to launch this

#PBS -j oe

cd $PBS_O_WORKDIR
echo PWD=$PWD

PYTHON_HOME=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst

# PYTHON=/usr/bin/python
PYTHON=$PYTHON_HOME/bin/python

TF=$PYTHON_HOME/lib/python2.7/site-packages/tensorflow/python

export LD_LIBRARY_PATH=$PYTHON_HOME/lib:/opt/gcc/4.9.2/snos/lib64:$TF
export PYTHONPATH=$TF

# Override HOME to use the Keras rc file in /lustre
export HOME=/lustre/beagle2/$USER
echo HOME=$HOME

# printenv

. /opt/modules/default/init/bash
# source /opt/modules/3.2.6.7/init/bash
module load PrgEnv-gnu

aprun -n 1 $PYTHON $PWD/../run-auen.py 500 500 stdout $PWD
