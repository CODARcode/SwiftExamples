
# make-package.tcl
# Creates pkgIndex.tcl

set name     pandaspy
set version  0.0
set leaf_so  libtclpandaspy.so

puts [ ::pkg::create -name $name -version $version \
           -load $leaf_so ]
