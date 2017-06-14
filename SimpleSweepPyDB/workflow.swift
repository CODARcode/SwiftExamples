
// WORKFLOW.SWIFT

import files;
import io;
import math;
import python;
import string;
import sys;

float results[string];

(string v)
setup()
{
  script = getenv("SWIFT_T_PROGRAM");
  t = float2int(clock()) %% 1000;
  workflow_id = "%s-%03i" % (script, t);
  printf("workflow_id: %s", workflow_id);
  v = python_persist("import sweep",
                     "sweep.setup(\"%s\")" % workflow_id);
}

setup() =>
  settingsFilename = argv("settings");

// Obtain list of parameter combinations
// Settings file should have form:
//   { 'parameters' : {'1' : numList1, '2': numList2, ...} }
// where each numList is a list of integers or floats.

// determineParameters then returns a string with the cross-product of all combinations of numbers from each list.
// E.g., if there are three parameters:
//    'n1a,n2a,n3a:n1a,n2b,n3a:...'

parametersString = python_persist("import sweep", sprintf("sweep.determineParameters(\"%s\")", settingsFilename));
// We split that string to get a list of comma-separated parameter combinations
parameters = split(parametersString, ":");

// Run experiments in parallel, passing each a different parameter set
foreach param in parameters
{
    resultString = python_persist("import sweep", sprintf("repr(sweep.evaluateOne(%s))", param));
    results[param] = string2float(resultString);
}

// Call Python to compute stats of this array of results
python("import sweep", sprintf("sweep.computeStats(\"%s\")", repr(results)));
