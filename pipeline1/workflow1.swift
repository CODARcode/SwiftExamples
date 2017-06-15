
import assert;
import io;
import launch;
import stats;
import string;

a_x = "apps/a.x";
b_x = "apps/b.x";

int procs[] = [4, 2];
string cmd[] = [ a_x, b_x ];
string argv[] = [ "f1.data f2.data", "f2.data f3.data" ];
@par=sum_integer(procs) launch_multi(procs, cmd, argv);
