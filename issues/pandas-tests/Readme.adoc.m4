
////
This file should be filtered with m4 first (for includes)
Use ./mk-readme.sh
////

= Swift/T &amp; Python interface &amp; pandas

:toc:

== Settings

Key settings are in +settings.sh+:
----
m4_include(`settings.cfg')----

== Python executable

=== test-py-pandas.sh

[green]#WORKS#

Login:
----
./test-py-pandas.sh
----

* Uses +try-pandas.py+
+
----
m4_include(`try-pandas.py')----

== C-Python interface

[green]#WORKS#

Login:
----
make pandas-lib.x
./test-pandas-lib-x.sh
----

Uses:

+pandas-lib.c+:: A simple library that exposes function +try_python_pandas()+ that uses the +PyRun_String()+ to +import pandas+.

+pandas-lib-main.c+:: Simply calls +try_python_pandas()+ .

== Tcl-C-Python interface

Works- needed to make Tcl use 

Login:
----
make pkgIndex.tcl
./test-pandas-tcl.sh
----

Compute:
----
make pkgIndex.tcl


== Swift-Python interface

WORKS

This shows how to successfully import +pandas+ and +keras+ via Swift's Python library interface.

Compute:
----
make pkgIndex.tcl
./qsub-swift-pandas-lib.sh
----

Uses:
+pandas-lib.swift+
----
m4_include(`pandas-lib.swift')
----

////
Local Variables:
mode: doc;
End:
////
