
import launch;
import stats;

a_x = "apps/a.x";
b_x = "apps/b.x";
c_x = "apps/c.x";

int procs[] = [4, 2, 3];
string cmd[] = [ a_x, b_x, c_x ];
string argv[] = [ "f1.data f2.data",
                  "f2.data f3.data",
                  "f3.data f4.data" ];
@par=sum_integer(procs) launch_multi(procs, cmd, argv);
