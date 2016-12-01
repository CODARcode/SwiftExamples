#!/bin/bash

# Canonicalize PWD
cd $( dirname $0 )
cd $( /bin/pwd )

. settings.cfg

export TURBINE_OUTPUT_ROOT=$PWD
export TURBINE_OUTPUT_FORMAT=prog-%Q
export WALLTIME=00:05:00
export TURBINE_DIRECTIVE='#PBS -l advres=brettin.3672'
PROCS=2
export PPN=2
set -x
$SWIFT -m cray -p \
       -n $PROCS \
       pandas-prog.swift \
       --pt_home=$PWD
