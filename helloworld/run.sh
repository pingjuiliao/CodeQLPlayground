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
FORMAT=sarif-latest
QUERY=query.ql
codeql database analyze ${DB} --format=${FORMAT} --output=output ${QUERY}
