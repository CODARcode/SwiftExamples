
# qsub this to run on the compute nodes

#PBS -N PYTHON
#PBS -A CI-MCB000175
#PBS -l walltime=01:05:00

#PBS -l mppwidth=1
#PBS -l mppnppn=1

# Merge stdout/stderr
#PBS -j oe
# Disable mail
#PBS -m n

#PBS -l advres=brettin.3663

# This simply does environment variable substition when m4 runs
define(`getenv', `esyscmd(printf -- "$`$1'")')

cd getenv(PWD)

aprun -n 1 -N 1 -cc none -d 1 ./test-py-pandas.sh
