
# MK-CONTOUR.PY

# The goal of this is to scan all the logs from the Swift runs
# and generate files for plotting by Octave's contour()

import sys

if len(sys.argv) < 2:
    print "usage: mk-contour inputs..."
    exit(1)

NEs = {}
N1s = {}
V   = {}
T   = {}

for file_input in sys.argv[1:]:
    with open(file_input, "r") as fp:
        for line in fp:
            if "RESULT:" not in line: continue
            tokens = line.split(" ")
            N1       = int(  tokens[1])
            NE       = int(  tokens[2])
            val_loss = float(tokens[7])
            time     = int(  tokens[9])
            NEs[NE] = 0
            N1s[N1] = 0
            V[(N1,NE)] = val_loss

NE_list = NEs.keys()
NE_list.sort()
N1_list = N1s.keys()
N1_list.sort()

with open("coords_x.dat", "w") as fp:
    for N1 in N1_list:
        fp.write("%i\n"%N1)
with open("coords_y.dat", "w") as fp:
    for NE in NE_list:
        fp.write("%i\n"%NE)
with open("vl.dat", "w") as fp:
    for NE in NE_list:
        for N1 in N1_list:
            if (N1,NE) in V: v = V[(N1,NE)]
            else:            v = 0
            fp.write("%f " % v)
        fp.write("\n")
with open("tm.dat", "w") as fp:
    for NE in NE_list:
        for N1 in N1_list:
            if (N1,NE) in T: t = T[(N1,NE)]
            else:            t = 0
            fp.write("%f " % t)
        fp.write("\n")
