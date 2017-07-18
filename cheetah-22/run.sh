#!/bin/sh
set -eu

# A
# Runs the demo a.swift

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

stc -p -u -I $LAUNCH -r $LAUNCH a.swift
turbine -n $PROCS $MACHINE a.tic

echo "SUCCESS!"
