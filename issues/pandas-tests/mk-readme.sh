#!/bin/sh

chmod u+w Readme.adoc
m4 -P Readme.adoc.m4 > Readme.adoc
chmod u-w Readme.adoc
