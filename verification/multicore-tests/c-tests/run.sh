#!/bin/bash

set -e

./build_all.py
cp $1.bin meminit.bin
../../../rvb_out/sim-verilator/Vtop_core
