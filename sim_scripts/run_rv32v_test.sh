#!/bin/bash

set -e
set -x

python3 run_tests_verilator.py -a RV32V -t selfasm --clean $1
vcd2wlf waveform.vcd waveform.wlf
vsim -view waveform.wlf -do vsim_scripts/stage4_pipeline.do
