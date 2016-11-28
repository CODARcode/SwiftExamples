# Simple parameter sweep: Swift/Python
Simple Swift-Python code to run parameter sweeps via calls to Python functions

Usage: run-swift.sh -settings=$PWD/settings.json

Files:
- **run-swift.sh**: sets up to run **run-sweep.swift** on Beagle at UChicago
- **run-sweep.swift**: calls **sweep.py** to retrieve sweep parameters from **settings.json**, then run each set, then compute stats
- **settings.json**: sweep parameters. Parameters must be labeled "1", "2", "3", "4", ... (dumb I know)
- **sweep.py**: code to configure parameters, evaluate a set of parameters, and compute stats at end of run

To do:
- Call a real machine learning code from the **evaluateOne** function in sweep.py, and a real evaluation function from **computeStats** (also in sweep.py)
- Work out what to do when outputs from the many ML code evaluations are too large to combine on one node
