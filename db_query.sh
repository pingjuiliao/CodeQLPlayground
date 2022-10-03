#!/bin/sh
DB=$1
shift;
echo "Querying: $@"
rm output
codeql database analyze ${DB} --format=sarif-latest --output=output --rerun $@
