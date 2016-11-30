
# qsub this to run on the compute nodes

#PBS -N PYTHON
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

export LD_LIBRARY_PATH=/lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst/lib:/opt/gcc/4.9.2/snos/lib64

aprun -n 1 -N 1 -cc none -d 1 ./pandas-lib.x
