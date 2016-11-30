
#include <stdio.h>
#include <stdlib.h>

#include <python2.7/Python.h>

#include "pandas-lib.h"

PyObject* main_dict  = NULL;
PyObject* local_dict = NULL;

static int python_error()
{
  printf("Error in Python API!\n\n");
  PyErr_Print();

  exit(EXIT_FAILURE);
}

static void execute(char* code)
{
  PyRun_String(code, Py_file_input, main_dict, local_dict);
  if (PyErr_Occurred()) python_error();
}

void
try_python_pandas()
{
  // Initialize
  Py_InitializeEx(1);
  PyObject* main_module  = PyImport_AddModule("__main__");
  if (main_module == NULL) python_error();
  main_dict = PyModule_GetDict(main_module);
  if (main_dict == NULL) python_error();
  local_dict = PyDict_New();
  if (local_dict == NULL) python_error();

  // Execute
  system("hostname");
  execute("print(\"python: hello\")");
  execute("import pandas as pd");
  execute("print(pd.__version__)");

  // Finalize
  Py_Finalize();
}
