import random, sys

if (len(sys.argv) < 3):
	print('requires arg1=param and arg2=filename')
	sys.exit(1)

parameterString = sys.argv[1]
filename        = sys.argv[2]

r = random.random()

with open(filename, 'w') as the_file:
    the_file.write(repr(r))

