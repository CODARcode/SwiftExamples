#!/bin/sh
set -eu

# RUN
# Runs the demos a.swift, b.swift

usage()
{
  echo "usage: WORKFLOW PROCS"
  echo "       where WORKFLOW is a or b"
}

if [ ${#} != 2 ]
then
  usage
  exit 1
fi

WORKFLOW=$1
PROCS=$2

# USER: Set this to the correct location:
LAUNCH=$HOME/proj/mpix_launch_swift/src

MACHINE=${MACHINE:-}

THIS=$( dirname $0 )

stc -p -u -I $LAUNCH -r $LAUNCH $WORKFLOW.swift
turbine -n $PROCS $MACHINE $WORKFLOW.tic

echo "SUCCESS!"
