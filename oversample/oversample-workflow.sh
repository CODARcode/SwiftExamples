#!/bin/bash
set -eu

export PROJECT=CI-MCB000175

export PATH=/lustre/beagle2/wozniak/Public/sfw/swift-t/py2Lr/stc/bin:$PATH

swift-t -m cray -t i:./pre.sh oversample.swift

