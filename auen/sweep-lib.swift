
// SWEEP-LIB.SWIFT

// Run with:
// $ swift-t sweep-lib.swift --auen_home=$PWD

import io;
import python;
import sys;

printf("SWEEP-LIB.SWIFT");

string auen_home = argv("auen_home");
// string auen = auen_home+"/run-auen.sh";

// auen_ff(int N1, int NE, string auen_home)
// {
//   auen N1 NE "stdout" auen_home;
// }

// // Fixed value for now
// NE = 600;

// foreach N1 in [100,500,1000,1500,2000,2500,3000]
// {
//   auen_ff(N1, NE, auen_home);
// }

foreach N1 in [100,500,1000,1500,2000,2500,3000] 
{
printf("Python result: %s", 
python_persist(
"import auen_ff",
"""
auen_ff.run_one(%i, 600, "%s")
"""
% (N1, auen_home)));
}
