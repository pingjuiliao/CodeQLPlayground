#!/bin/sh
if [ -d "$1" ]; then
  codeql database create $1 -l=cpp -c=make
else
  codeql database create $1 -l=cpp -c=make --overwrite
fi
