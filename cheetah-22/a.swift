
/*
   A.SWIFT
*/

import io;
import launch;
import string;

foreach i in [0:3]
{
  program = "../apps/noop.x";
  string arguments[] = ["-v"];
  p = float2int(2 ** i);
  printf("swift: launching: %s on %i processes", program, p);
  exit_code = @par=p launch(program, arguments);
  printf("swift: received exit code: %d", exit_code);
  if (exit_code != 0)
  {
    printf("swift: The launched application did not succeed.");
  }
}
