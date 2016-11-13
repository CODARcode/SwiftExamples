#!/bin/sh
qsub -j oe -l advres=brettin.3663 -A CI-MCB000175 $PWD/run-auen-submit.sh
