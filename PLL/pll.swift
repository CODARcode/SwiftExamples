
import assert;
import files;
import io;
import string;
import sys;

app sh(string arg)
{
  "sh" "-c" arg;
}

(int exit_code) system(string cmd)
"turbine" "1.0"
[
"""
set cmd_tokens <<cmd>>
if [ catch { exec {*}$cmd_tokens > /dev/stdout } e info ] {
  set L [ dict get $info -errorcode ]
  set b [ lindex $L 2]
} else {
  set b 0
}
set <<exit_code>> $b
"""
];

assert (argc() == 1, "Provide an input file!");

string cmd_list_file = argp(1);
string lines[] = file_lines(input(cmd_list_file));
foreach line in lines {
  // sh(line);
  int ec = system(line);
  printf("ec: %i (%s)", ec, line);
}
