
/**
   EMEWS workflow.swift
*/

import assert;
import io;
import location;
import python;
import string;
import sys;

import EQPy;

string auen_home = argv("auen_home");

N = 10;

/** The objective function */
(string result)
task(string params, string auen_home)
{
result = python_persist(
"import auen_ff",
"""
auen_ff.run_one(%s, "%s")
"""
% (params, auen_home));
}

location GA = locationFromRank(0);

(void v)
handshake(string settings_filename)
{
  message = EQPy_get(GA) =>
    v = EQPy_put(GA, settings_filename);
  assert(message == "Settings", "Error in handshake.");
}

(void v)
loop(int N)
{
  for (boolean b = true;
       b;
       b=c)
  {
    message = EQPy_get(GA);
    // printf("swift: message: %s", message);
    boolean c;
    if (message == "FINAL")
    {
      printf("Swift: FINAL") =>
        v = make_void() =>
        c = false;
      finals = EQPy_get(GA);
      printf("Swift: finals: %s", finals);
    }
    else
    {
      string params[] = split(message, ";");
      string results[];
      foreach p,i in params
      {
        results[i] = task(p, auen_home);
      }
      result = join(results, ";");
      printf("swift: result: %s", result);
      EQPy_put(GA, result) => c = true;
    }
  }

}

settings_filename = argv("settings");

EQPy_init_package(GA, "algorithm") =>
  handshake(settings_filename) =>
  loop(N) =>
  EQPy_stop(GA);
