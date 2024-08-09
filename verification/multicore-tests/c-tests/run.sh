#!/bin/bash

set -e

./build_all.py
../../../rvb_out/sim-verilator/Vtop_core $1.bin
