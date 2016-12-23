
// SWEEP-CMD.SWIFT

// Run with:
// $ swift-t sweep-cmd.swift --auen_home=$PWD

import sys;

string auen_home = argv("auen_home");
string auen = auen_home+"/run-auen.sh";

app auen_ff(int N1, int NE, string auen_home)
{
  auen N1 NE "stdout" auen_home;
}

// Fixed value for now
NE = 600;

foreach N1 in [100,500,1000,1500,2000,2500,3000]
{
  auen_ff(N1, NE, auen_home);
}
