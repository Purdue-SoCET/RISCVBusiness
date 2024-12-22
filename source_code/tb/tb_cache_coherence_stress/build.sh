#!/bin/bash

set -e

fusesoc --cores-root ../../. --cores-root . run --setup --build --build-root out --target sim socet:tb:cache_coherence_stress
echo "Built testbench!"
./out/socet_tb_cache_coherence_stress_0.1.0/sim-verilator/Vcache_stress_wrapper $1
echo "Ran testbench!"
diff goldensim.dump memsim.dump
