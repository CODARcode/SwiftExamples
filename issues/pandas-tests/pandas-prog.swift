
// PANDAS-PROG.SWIFT

import io;
import sys;

PT_HOME = argv("pt_home");
python_prog = PT_HOME/"python.sh";

app (void v) p(string python_prog, string python_script)
{
  python_prog python_script ;
}

printf("swift: hello") =>
  p(python_prog, PT_HOME/"try-pandas.py") =>
  printf("swift: success");
