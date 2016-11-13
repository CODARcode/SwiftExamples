
# AUEN Workflow

## Initial goal: Basic parameter sweep over AUEN on Beagle

This demo runs a parameter sweep over AUEN/Theano, with parameter _NE_=100,500,1000,1500,2000,2500,3000

*Quick start:* To run on the Beagle compute nodes,

1. Configure Keras (see below)
2. Get the bulk data (see below)
3. Type:

```
$ git clone https://github.com/jmjwozniak/codar.git
$ cd auen
$ ./run-swift.sh
```

## Configuring Keras

Keras will try to use TensorFlow by default.  This does not work yet on Beagle, so we create a configuration file to switch it to Theano.  

Create file `/lustre/beagle2/$USER/.keras/keras.json` with contents:
```
{
    "image_dim_ordering": "tf", 
    "epsilon": 1e-07, 
    "floatx": "float32", 
    "backend": "theano"
}
```

(Normally `keras.json` would be in `$HOME`, but this needs to be in `/lustre`.  Our scripts will reset `$HOME` to this directory so this works.)

## Bulk data

* `data/` is the bulk data directory.  Bulk data files are not in GitHub.  A copy of Fangfang's data is on Beagle at `~wozniak/Public/data/auen1`.  Create a directory here called `data/` and copy the CSV files into it.

## File list

See file headers for additional notes.

### Entry points

* `run-many.py`: Initial Python sequential parameter sweep over `run_one()`
* `run-auen.sh`: Shell wrapper for `run-auen.py`, setting system paths, etc.  Forwards command line to `run-auen.py`.  Example usage: `./run-auen.sh 2500 600 stdout`
* `run-auen.py`: Python main program to accept command line arguments for `auen_ff.py:run_one()`.
* `run-swift.sh`: Shell wrapper to launch a Swift-based parallel job, limited to 1 hour.  The details about how this calls Swift are:
 * `swift-t`: The Swift/T workflow tool
 * `-m cray`: Launch a Cray APRUN job
 * `-n $PROCS`: Run _PROCS_-1 AUENs at a time (one process for Swift)
 * `run-many.swift`: The Swift parameter sweep (see below)
 * `--auen_home=$PWD`: Set a home location so AUEN can find its data
 * The output will go into the reported `TURBINE_OUTPUT` directory, a numbered  directory under `$PWD`

### Supporting files

* `auen_ff.py`: Original application file from Fangfang, but modified to be a library.  The new key function is `run_one()`.  This function takes about 13 minutes on Beagle with Theano.
* `run-many.swift`: Parallel Swift script to perform parameter sweep concurrently, similar to `run-many.py`.  Example usage: `swift-t -n PROCS run-many.swift`.  

## Software

* To run Swift/T on the login node, use `/soft/swift-t/login/2016-11/stc/bin/swift-t ...`
 * Always run this under `nice`.

* To run Swift/T on the compute node, use `/lustre/beagle2/wozniak/Public/sfw/swift-t/py2Lr/stc/bin/swift-t -m cray ...`
 * This installation is hard-wired to use our reservation

## Caveats

* You must clone this on `/lustre` if you want to run on the compute nodes
* If you get a Python stack dump, there is something wrong with your Python configuration.  Email the output to Wozniak.

## Further reading

* [The Swift/T Guide](http://swift-lang.github.io/swift-t/guide.html)
