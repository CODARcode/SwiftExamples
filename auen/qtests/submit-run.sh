#!/bin/bash
set -eu

# Canonicalize PWD
THIS=$( cd $( dirname $0 ) ; /bin/pwd )
cd $THIS
echo PWD=$PWD

PROJECT=${PROJECT:-}
if [[ ${PROJECT} == "" ]]
then
  echo "Error: You must set environment variable PROJECT"
  exit 1
fi

qsub -j oe -l advres=wozniak.3701 -A $PROJECT $THIS/run-auen-submit.sh
