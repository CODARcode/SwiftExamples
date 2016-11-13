
# RUN-AUEN

# Run with:
# $ export PYTHONPATH=$PWD
# $ python run-auen.py <N1> <NE> <OUTPUT>

import sys

import auen_ff

if len(sys.argv) == 1:
    print("Requires three arguments: <NI> <NE> <OUTPUT>")
    sys.exit(1)

auen_home = "."
    
N1 = float(sys.argv[1])
NE = float(sys.argv[2])
output = sys.argv[3]
if len(sys.argv) == 5:
    auen_home = sys.argv[4]
    
auen_ff.run_one(N1, NE, output, auen_home)
