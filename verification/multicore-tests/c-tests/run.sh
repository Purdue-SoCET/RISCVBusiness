#!/bin/bash

set -e

./build_all.py $1.c
../../../rvb_out/sim-verilator/Vtop_core $1.bin
