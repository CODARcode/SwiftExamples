#!/bin/sh
set -eu

# RUN WORKFLOW
# Runs the demo workflow1.swift

if [ ${#} != 1 ]
then
  echo "Requires PROCS!"
  exit 1
fi

PROCS=$1

# USER: Set this to the correct location:
LAUNCH=$HOME/proj/mpix_launch_swift/src

MACHINE=${MACHINE:-}

THIS=$( dirname $0 )

# This does not work with OpenMPI, but
# if trying to fix this for OpenMPI, you may need this:
# (cf. https://groups.google.com/forum/#!topic/maker-devel/RnXzOWDSFk0)
# export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libmpi.so.20

stc -p -u -I $LAUNCH -r $LAUNCH workflow1.swift
turbine -n $PROCS $MACHINE workflow1.tic

echo "SUCCESS!"
