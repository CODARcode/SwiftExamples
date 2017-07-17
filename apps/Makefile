
CC = mpicc
CFLAGS = -Wall

all: a.x b.x c.x noop.x

noop.x: noop.o
	mpicc -o $(@) $(<)

a.x: rw.o
	mpicc -o $(@) $(<)

b.x c.x: a.x
	@ cp -v $(<) $(@)

clean:
	rm -fv *.x *.o
