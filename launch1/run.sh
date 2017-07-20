#!/bin/sh
set -eu

# RUN
# Runs the demo workflow.swift

usage()
{
  echo "usage: ./run.sh PROCS"
}

if [ ${#} != 1 ]
then
  usage
  exit 1
fi

PROCS=$1

# USER: Set this to the correct location:
LAUNCH=$HOME/proj/mpix_launch_swift/src

MACHINE=${MACHINE:-}

THIS=$( dirname $0 )

WORKFLOW="workflow"
stc -p -u -I $LAUNCH -r $LAUNCH $THIS/$WORKFLOW.swift
turbine -n $PROCS $MACHINE $THIS/$WORKFLOW.tic

echo "SUCCESS!"
