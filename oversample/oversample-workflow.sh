#!/bin/bash
set -eu

#export PROJECT=CI-MCB000175
export PROJECT=CI-CCR000040
 
export TURBINE_OUTPUT_ROOT=$PWD
export TURBINE_OUTPUT_FORMAT=out-%Q
export WALLTIME=01:00:00

export PATH=/lustre/beagle1/wozniak/Public/sfw/swift-t/py2Lr/stc/bin:$PATH

export HOME=/lustre/beagle2/foster

PROCS=2
which swift-t
#swift-t -m cray -n $PROCS -t i:./pre.sh oversample.swift
