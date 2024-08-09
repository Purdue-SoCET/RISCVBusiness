#!/bin/bash

set -e

make verilate -C ../../..
./run.sh $1
