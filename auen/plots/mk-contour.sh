#!/bin/bash
set -eu

# MK-CONTOUR.SH

# The entry point for the contour plots
# Run this from the plots directory

THIS=$( dirname $0 )

PYTHON=/soft/swift-t/deps/Python-2.7.10/bin/python

echo "Extracting data..."
$PYTHON mk-contour.py $*
echo "Plotting..."
octave -q -f mk_contour.m
echo "Done."
