
// PANDAS-LIB.SWIFT

import io;
import python;

i = python(----
import os
print("PYTHON") 
print(os.getenv("LD_LIBRARY_PATH"))
print("importing pandas")           
import pandas
print("pandas: OK")
print("importing keras")            
import keras
print("keras: OK")
----,
"repr(0)"
);
printf("i: %s", i);
