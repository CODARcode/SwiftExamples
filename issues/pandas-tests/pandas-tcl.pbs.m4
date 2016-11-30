
#PBS -N TCL
#PBS -A CI-MCB000175
#PBS -l walltime=00:05:00

#PBS -l mppwidth=1
#PBS -l mppnppn=1

# Merge stdout/stderr
#PBS -j oe
# Disable mail
#PBS -m n

#PBS -l advres=brettin.3672

# This simply does environment variable substition when m4 runs
define(`getenv', `esyscmd(printf -- "$`$1'")')

cd getenv(PWD)
pwd

LD_LIBRARY_PATH=getenv(LD_LIBRARY_PATH)
TCLLIBPATH=getenv(TCLLIBPATH)

TCLSH=getenv(TCLSH)
echo TCLSH: $TCLSH

aprun -n 1 -N 1 -cc none -d 1 \
      -e TCLLIBPATH=$TCLLIBPATH \
      -e LD_LIBRARY_PATH=$LD_LIBRARY_PATH \
      $TCLSH test-pandas.tcl
