#!/bin/sh

DB=mydb
OUT_FILE=output

# codeql pack install codeql/cpp-queries
## must do this

# Create database
SRC_DIR=src
COMMAND=make # GNUMake
LANGUAGE=cpp
if [ ! -d "${DB}" ]; then
  codeql database create ${DB} -s ${SRC_DIR} -l=${LANGUAGE} -c=${COMMAND}
fi

# Analyze database
FORMAT=graphtext
QUERY=query.ql
codeql database analyze ${DB} --format=csv --output=output ${QUERY}
