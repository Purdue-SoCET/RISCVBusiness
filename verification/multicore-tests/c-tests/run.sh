#!/bin/bash

set -e

ccache -C
./build_all.py $1.c
../../../rvb_out/socet_riscv_RISCVBusiness_0.1.1/sim-verilator/Vtop_core $1.bin
