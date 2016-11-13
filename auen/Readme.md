
# AUEN Workflow

## File list

See file headers for additional notes.

### Entry points

* `run-many.py`: Initial Python sequential parameter sweep over `run_one()`
* `run-auen.sh`: Shell wrapper for `run-auen.py`, setting system paths, etc.  Forwards command line to `run-auen.py`.  Example usage: `./run-auen.sh 2500 600 stdout`
* `run-auen.py`: Python main program to accept command line arguments for `auen_ff.py:run_one()`.  
* `run-auen.swift`: Parallel Swift script to perform parameter sweep concurrently, similar to `run-many.py`.  Example usage: `swift-t -n PROCS run-many.swift`.  Runs _PROCS_-1 tasks at a time (one process is reserved for Swift).

### Supporting files

* `auen_ff.py`: Original application file from Fangfang, but modified to be a library.  The new key function is `run_one()`.
* `data/`: Bulk data directory.  Bulk data files are not in GitHub.

## Software

* To run Swift/T on the login node, use `/soft/swift-t/login/2016-11/stc/bin/swift-t ...`
** Always run this under `nice`.

* To run Swift/T on the compute node, use `/lustre/beagle2/wozniak/Public/sfw/swift-t/py2Lr/stc/bin/swift-t -m cray ...`
** This installation is hard-wired to use our reservation
