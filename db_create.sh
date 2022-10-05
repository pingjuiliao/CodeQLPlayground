#!/bin/sh
make clean
if [ -d "$1" ]; then
  codeql database create $1 -l=cpp -c=make --overwrite
else
  codeql database create $1 -l=cpp -c=make
fi
