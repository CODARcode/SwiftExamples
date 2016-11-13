
# AUEN Workflow

## File list

See file headers for additional notes.

### Entry points

* `run-one-sweep.py`: Initial Python sequential parameter sweep over `run_one()`
* `run-auen.sh`: Shell wrapper for `run-auen.py`, setting system paths, etc.  Forwards command line to `run-auen.py`.  Example usage: `./run-auen.sh 2500 600 stdout`
* `run-auen.py`: Python main program to accept command line arguments for `auen_ff.py:run_one()`.  
* `run-auen.swift`: Parallel Swift script to perform parameter sweep concurrently, similar to `run-one-sweep.py`.  Example usage: `swift-t -n _PROCS_ run-one-sweep.swift`

### Supporting files

* `auen_ff.py`: Original application file from Fangfang, but modified to be a library.  The new key function is `run_one()`.
* `data/`: Bulk data directory.  Bulk data files are not in GitHub.
