
/*
   WORKFLOW.SWIFT
*/

import io;
import launch;

program = "../apps/noop.x";

string arguments[] = [ "-v", "-d", "3" ];
p = 2;
printf("swift: launching: %s on %i processes", program, p);
exit_code = @par=p launch(program, arguments);
printf("swift: received exit code: %d", exit_code);
if (exit_code != EXIT_SUCCESS)
{
  printf("swift: The launched application did not succeed.");
}
