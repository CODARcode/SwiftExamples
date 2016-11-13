#!/bin/sh

THIS=$( dirname $0 )
qsub -j oe -l advres=brettin.3663 -A CI-MCB000175 $THIS/run-auen-submit.sh
