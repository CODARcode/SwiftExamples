#/bin/sh
set -eu

# Canonicalize PWD
cd $( dirname $0 )
cd $( /bin/pwd )

. settings.cfg

export TCLLIBPATH=$PWD
export LD_LIBRARY_PATH=$PWD:$PYTHON_HOME/lib:/opt/gcc/4.9.2/snos/lib64
export TCLSH
echo TCLSH: $TCLSH

./qsub-test.sh pandas-tcl
