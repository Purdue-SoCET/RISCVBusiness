#!/bin/bash

set -e
set -x

rm -f waveform.vcd waveform.wlf
python3 run_tests_verilator.py -a RV32V -t selfasm --clean $*
vcd2wlf waveform.vcd waveform.wlf
