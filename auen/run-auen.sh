#!/bin/bash
set -eu

# RUN-AUEN
# Shell wrapper for AUEN to set up PATH, PYTHONPATH, etc.

echo run-auen $*

PYTHON=/usr/bin/python
unset LD_LIBRARY_PATH PYTHONPATH

$PYTHON ./run-auen.py $*
