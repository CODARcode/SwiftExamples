#!/bin/bash
set -eu

export TURBINE_OUTPUT_ROOT=$PWD
export TURBINE_OUTPUT_FORMAT=out-%Q
export WALLTIME=01:00:00

PATH=/lustre/beagle2/wozniak/Public/sfw/swift-t/py2Lr/stc/bin:$PATH

export LD_LIBRARY_PATH=/opt/gcc/4.9.2/snos/lib64:/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/lib

PROCS=3
swift-t -m cray -n $PROCS run-many.swift --auen_home=$PWD
