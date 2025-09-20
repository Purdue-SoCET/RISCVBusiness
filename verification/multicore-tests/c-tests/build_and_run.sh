#!/bin/bash

set -e

ccache -C
make verilate -C ../../..
./run.sh $1
