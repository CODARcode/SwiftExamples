
/*
   C.SWIFT
*/

import io;
import launch;

program = "../apps/noop.x";

string arguments[] = [ "-v", "-d", "3" ];
string envs[] = [ "swift:timeout=1" ];
p = 2;
printf("swift: launching: %s on %i processes", program, p);
exit_code = @par=p launch_envs(program, arguments, envs);
printf("swift: received exit code: %d", exit_code);
if (exit_code != 0)
{
  printf("swift: The launched application did not succeed.");
}
