#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Usage: $0 <folder> <arch> <march>"
  exit 1
fi

FOLDER="$1"
ARCH="$2"
MARCH="$3"
FOLDER=$(cd "$FOLDER"; pwd)

for file in "$FOLDER"/*.S; do
  if [ -f "$file" ]; then
    python3 run_tests_verilator.py --clean --arch "$ARCH" --march "$MARCH" "$file"
  else
    echo "No .S files found in $FOLDER"
    break
  fi
done
