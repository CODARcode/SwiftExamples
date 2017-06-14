
CC = mpicc

all: a.x b.x c.x

a.x: rw.o
	mpicc -o $(@) $(<)

b.x c.x: a.x
	@ cp -v $(<) $(@)
