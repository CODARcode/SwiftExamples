
include settings.cfg

CC = $(GCC492)/bin/gcc
CFLAGS = -fPIC -I $(PYTHON_HOME)/include -I $(TCL_HOME)/include
LDFLAGS = \
	-L $(PWD) -l pandaspy \
	-L $(PYTHON_HOME)/lib -l python2.7

swift-package: pkgIndex.tcl

libpandaspy.so: pandas-lib.o
	$(CC) -shared -fPIC -o $(@) $(<)

pandas-lib.x: pandas-lib-main.o libpandaspy.so
	$(CC) -o $(@) $(<) $(LDFLAGS)

pandaspy_wrap.c: pandaspy.i pandas-lib.h
	swig $(<)
	sed -i s/Pandaspy_Init/Tclpandaspy_Init/ $(@)

libtclpandaspy.so: pandaspy_wrap.o libpandaspy.so
	$(CC) -shared -fPIC -o $(@) pandaspy_wrap.o \
		$(LDFLAGS) \
		-L $(TCL_HOME)/lib -l tcl8.6

pkgIndex.tcl: make-package.tcl libtclpandaspy.so
	$(TCLSH) $(<) > $(@)
	sed -i "s/list load/list load -global/" $(@)

.DELETE_ON_ERROR:

clean:
	rm -fv *.x *.so *.o *_wrap.c
