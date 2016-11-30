#!/bin/sh
set -e

cd $( dirname $0 )

./qsub-test.sh pandas-lib
