# Simple parameter sweep: Swift/Python

Simple Swift-Python code to run parameter sweeps via calls to Python functions

Usage: ./run-??? --settings=$PWD/settings.json

Set `PYTHONPATH` to contain the
[CANDLE Database](http://github.com/ECP-CANDLE/Database) `py` directory and
pysolr (see the CANDLE Database README).

Files:
- **run-local**: runs **workflow.swift** on local machine
- **run-beagle**: runs **workflow.swift** on Beagle at UChicago

- **workflow.swift**: calls **sweep.py** to retrieve sweep parameters from **settings.json**, then run each set, then compute stats
- **settings.json**: sweep parameters. Parameters must be labeled "1", "2", "3", "4", ... (dumb I know)
- **sweep.py**: code to configure parameters, evaluate a set of parameters, and compute stats at end of run
