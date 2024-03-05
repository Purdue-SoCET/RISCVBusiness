#!/bin/bash

set -e

fusesoc --cores-root ../../. --cores-root . run --setup --build --build-root out --target sim socet:tb:cache_coherence_stress
echo "Built testbench!"
./out/sim-verilator/Vcache_stress_wrapper
echo "Ran testbench!"
