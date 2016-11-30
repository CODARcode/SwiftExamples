
TCL = /soft/swift-t/deps/tcl-8.6.5
TCLSH = $(TCL)/bin/tclsh
PYTHON = /lustre/beagle2/lpBuild/CANDLE/python/Python-2.7.12-inst
CFLAGS = -fPIC -I $(PYTHON)/include -I $(TCL)/include
LDFLAGS = \
	-L $(PWD) -l pandaspy \
	-L $(PYTHON)/lib -l python2.7

libpandaspy.so: pandas-lib.o
	gcc -shared -fPIC -o $(@) $(<)

pandas-lib.x: pandas-lib-main.o libpandaspy.so
	gcc -o $(@) $(<) $(LDFLAGS)

pandaspy_wrap.c: pandaspy.i pandas-lib.h
	swig $(<)
	sed -i s/Pandaspy_Init/Tclpandaspy_Init/ $(@)

libtclpandaspy.so: pandaspy_wrap.o libpandaspy.so
	gcc -shared -fPIC -o $(@) pandaspy_wrap.o \
		$(LDFLAGS) -L $(TCL)/lib -l tcl8.6

pkgIndex.tcl: make-package.tcl libtclpandaspy.so
	$(TCLSH) $(<) > $(@)

# libtclpandas.so: pandas-lib.o

clean:
	rm -fv *.x *.so *.o *_wrap.c
