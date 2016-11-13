
# RUN-MANY

# Run with:
# $ export PYTHONPATH=$PWD
# $ python run-one-sweep.py

import auen_ff

for N1 in [100,500,1000,1500,2000,2500,3000]:
    auen_ff.run_one(N1)
    
