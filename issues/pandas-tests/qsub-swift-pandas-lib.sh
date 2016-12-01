#!/bin/bash

# Canonicalize PWD
cd $( dirname $0 )
cd $( /bin/pwd )

. settings.cfg

export LD_LIBRARY_PATH=$GCC492/snos/lib64:$PYTHON_HOME/lib

export TURBINE_OUTPUT_ROOT=$PWD
export TURBINE_OUTPUT_FORMAT=lib-%Q
export WALLTIME=00:05:00
export TURBINE_DIRECTIVE='#PBS -l advres=brettin.3672'

PROCS=2
export PPN=$PROCS
set -x
$SWIFT -m cray -p \
       -n $PROCS \
       -e LD_LIBRARY_PATH=$LD_LIBRARY_PATH \
       -e HOME=/lustre/beagle2/$USER \
       pandas-lib.swift \
       --pt_home=$PWD
