#!/bin/bash

set -e
set -x

vsim -view waveform.wlf -do sim_scripts/stage4_pipeline.do
