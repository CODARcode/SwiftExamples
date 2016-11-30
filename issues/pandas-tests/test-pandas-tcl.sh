#/bin/sh
set -eu

cd $( dirname $0 )
. settings.cfg

export TCLLIBPATH=$PWD
export LD_LIBRARY_PATH=$PWD:$PYTHON_HOME/lib:$GCC492/snos/lib64
echo TCLSH: $TCLSH
$TCLSH test-pandas.tcl
