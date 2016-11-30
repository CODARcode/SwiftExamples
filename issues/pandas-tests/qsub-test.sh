#!/bin/sh
set -eu

# Canonicalize PWD
cd $( /bin/pwd )

TEST=$1

m4 $TEST.pbs.m4 > $TEST.pbs
qsub $TEST.pbs
