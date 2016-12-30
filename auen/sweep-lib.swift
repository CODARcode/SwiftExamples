
// SWEEP-LIB.SWIFT

// Run with:
// $ swift-t sweep-lib.swift --auen_home=$PWD [--NE=<NE>]

import io;
import python;
import sys;

printf("SWEEP-LIB.SWIFT");

auen_home = argv("auen_home");

NE = parseInt(argv("NE", "600"));

foreach N1 in [100,500,1000,1500,2000,2500,3000]
{
printf("Python result: %s",
python_persist(
"import auen_ff",
"""
auen_ff.run_one(%i, %i, "%s")
"""
% (N1, NE, auen_home)));
}
