#!/bin/bash
set -eu

if [[ ${#} != 1 ]]
then
  echo "Requires 1 argument!"
  exit 1
fi

LOG=$1

grep "RESULT:" $LOG | awk '{ print $2 " " $10 }' | sort -n
