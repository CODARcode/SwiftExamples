#!/bin/bash
set -eu

export TURBINE_OUTPUT_ROOT=$PWD
export TURBINE_OUTPUT_FORMAT=out-%Q
export WALLTIME=01:00:00

PATH=/lustre/beagle2/wozniak/Public/sfw/swift-t/py2Lr/stc/bin:$PATH

PROCS=3
swift-t -m cray -n $PROCS run-many.swift --auen_home=$PWD
