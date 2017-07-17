
import launch;
import stats;

a_x = "../apps/a.x";
b_x = "../apps/b.x";
c_x = "../apps/c.x";

int procs[] = [4, 2, 3];
string cmd[] = [ a_x, b_x, c_x ];
string argv[][];
argv[0] = [ "f1.data f2.data" ];
argv[1] = [ "f2.data f3.data" ];
argv[2] = [ "f3.data f4.data" ];
string envs[][] = [];
@par=sum_integer(procs) launch_multi(procs, cmd, argv, envs);
