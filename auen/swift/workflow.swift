
/**
   EMEWS workflow.swift
*/

import assert;
import files;
import io;
import location;
import string;
import sys;

import EQPy;

N = 10;

app (file f)
auen(string p1, string p2)
{
  "./run-auen.sh" p1 p2 f;
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
        string ns[] = split(p, ",");
        file result_file<"result-%i-%i.txt"%(ns[0], ns[1])>
          = auen(ns[0], ns[1]);
        results[i] = read(result_file);
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
