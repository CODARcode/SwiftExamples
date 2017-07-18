
/*
   B.SWIFT
*/

import io;
import launch;
import string;

program = "../apps/noop.x";

foreach i in [0:3]
{
  label = int2string(i);
  string arguments[] = [ "-v", "-l", label, "-d", "1" ];
  p = 2;
  printf("swift: launching: %s (%s) on %i processes", program, label, p);
  exit_code = @par=p launch(program, arguments);
  printf("swift: received exit code: %d", exit_code);
  if (exit_code != 0)
  {
    printf("swift: The launched application (%s) did not succeed.",
           label);
  }
}
