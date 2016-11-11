
# RUN-AUEN

# Run with:
# $ export PYTHONPATH=$PWD
# $ python run-auen.py <N1> <NE> <OUTPUT>

import sys

import auen_ff

if len(sys.argv) != 4:
    print("Requires three arguments: <NI> <NE> <OUTPUT>")
    sys.exit(1)

N1 = int(sys.argv[1])
NE = int(sys.argv[2])
output = sys.argv[3]
    
auen_ff.run_one(N1, NE, output)
