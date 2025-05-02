# Caches UVM Testbench Setup Guide

### .bashrc
> Note that there may be some env variables listed here that are not required.
```
source ~/init_vlsi -p mitll90_Dec2019 -e all
export MGC_FDI_OA_VERSION=22.50
export SOCET_FILES="/home/ecegrid/a/socpub/Public"
# WAF Build System
export SFF_ADMIN=$SOCET_FILES/SoCFoundationFlow/admin
source $SFF_ADMIN/setup_env.bash
export SFF_SIM_ENV="incisive"
# RISCV Setup
export TOOLS=$SOCET_FILES/riscv_dev
export RISCV=$TOOLS/riscv_installs/RV_current
export PATH=$TOOLS/scripts\:$PATH
export PATH=$RISCV/bin\:$PATH
export PATH=/opt/gcc/5.3.0/bin\:$PATH
export LD_LIBRARY_PATH=$RISCV/lib\:/opt/gcc/5.3.0/lib64
export LIBRARY_PATH=/opt/gcc/5.3.0/lib64
export PYTHONPATH=$TOOLS/python_libs/lib64/python
export PERL5LIB=$TOOLS/perl_libs/installs/Verilog-Perl/lib/perl5
export PATH=$PATH\:$TOOLS/perl_libs/installs/Verilog-Perl/bin/
# Various system variables
export SOCROOT="$HOME/SoCET_Public"
export PATH=/package/eda/cadence/GENUS191/tools/bin:$PATH
export QUESTA_HOME=/package/eda/mg/questa10.6b/questasim
#load newer version of git
module load git
```

### Build/Run Params
Everything related to building and running the uvm testbench is handled by the run.py script. To view the parameters:
```bash
run.py -h
```
`Note:` you may need to change permissions of the run.py file:
```bash
chmod u+x run.py
```

## How to Debug DUT
The best way to use this UVM testbench for debugging is to utilize a combination of the `transcript` file and the waveforms.

First run the design with the desired test configuration in gui mode:
```
run.py -g --config l2 -s 12345
```
`Note`: when debugging it is helpful to have a static/non-random test for consistency.  This is why I have added the `-s 12345` flag here.  This is optional.

This command will invoke the QuestaSim Gui and will auto load the waveforms for the correct config.  Make sure to answer `no` to the `Are you sure you want to finish?` prompt.  You can now search through the `transcript` file for any errors (<kbd>Ctrl</kbd> + <kbd>f</kbd> for "error").  You can now view the error and know the time step where the error occurred on the waveform.

Let's walk through an example:
```bash
# 753000: uvm_test_top.ENV.MEM_ARB_SCORE [MEM_ARB_SCORE] Error: Data Mismatch
# UVM_INFO generic_bus_agent_comps/bus_scoreboard.svh(75) @ 753000: uvm_test_top.ENV.MEM_ARB_SCORE [MEM_ARB_SCORE] 
# Expected:
# --------------------------------------------
# Name       Type             Size  Value     
# --------------------------------------------
# pred_tx    cpu_transaction  -     @1297     
#   rw       integral         1     'h0       
#   addr     integral         32    'h2dc2bc5c
#   data     integral         32    'hced4bc5c
#   byte_en  integral         4     'h3       
# --------------------------------------------
# 
# Received:
# --------------------------------------------
# Name       Type             Size  Value     
# --------------------------------------------
# tx         cpu_transaction  -     @1289     
#   rw       integral         1     'h0       
#   addr     integral         32    'h2dc2bc5c
#   data     integral         32    'hced8d351
#   byte_en  integral         4     'h3       
# --------------------------------------------
#
```

We see that the first line gives an error message and the time step, in this case at time 753000 there was a mismatch in data from the memory arbiter (MEM_ARB_SCORE).  We also have the expected and actual values from the test.  Most of the fields of each transaction are straight forward to understand except for `rw`.  This value indicates if the transaction is a read or a write.  If `rw == 1`, it was a `write` request, `otherwise`, it was a `read`.  With this information the design engineering is armed with great information to begin reading through the waveforms to determine the cause of the issue.

## Design Notes:
- Need to drive byte_en to memory, at least full word (4'b1000)
- evicting the right data but wrong address

## Extension Ideas:
- Timing Agent
  - responsible for monitoring both buses like end2end and checking if the correct number of cycles for hits/misses