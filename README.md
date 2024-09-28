# RISCVBusiness
Design documents and project information for the RISC-V Business project can be found here:

[RISCV-Business Documentation](https://wiki.itap.purdue.edu/display/RISC/RISCV-Business)

**Current User-Level ISA Spec :** v2.1
**Current Privileged ISA Spec :** v1.12

# Getting Started

Getting started with RISCV Business consists of three steps: setting up the RISCV tool-chain, setting up the WAF build system, and finally interacting with the RISCV Business project itself. 

## Fusesoc
This project uses the [Fusesoc](http://fusesoc.net/) build system.  Use the following commands to get started...

```bash
# install project dependencies &
# setup git pre-commit hook
./setup.sh

# For ease of use, use the makefile to run FuseSoC tests
make # shows all build targets available

# configure the RISC-V core
make config 
# or python3 scripts/config_core.py <custom>.yml
#   if you want to use a config other than example.yml

# Build the core
make verilate # build default config with Verilator, or...
make xcelium # build default config with Xcelium, or...
make verilate.% # build '%' config with Verilator
# % configs: 's' for 3-stage scalar, 'v' for 4-stage vector
```

> Congrats! All dependencies are now set up. Based on the configuration used (the extensions it supports), you may need to modify the `"march"` string in `run_tests_config.json` which is used by the compiler.
>
> Now you can run simulations/tests:


```bash
# Run ISA tests
run_tests_verilator.py

# Run specify binary on Verliator core simulation
./rvb_out/sim-verilator/Vtop_core meminit.bin
```

## Generating RISC-V tool-chain

Refer to the following link for instructions on installing the RISC-V software tools:

[RISC-V Software Installation](https://riscv.org/software-tools/)

Execute the following commands to download the correct version of the RISC-V tools:

~~~
git clone https://github.com/riscv/riscv-tools.git
git checkout 4635ab67966c763a84f7217bc2c20b65dcabc7ec
git submodule update --init --recursive
~~~

Change the line to build the riscv-gnu-toolchain tools to:

~~~
build_project riscv-gnu-toolchain --prefix=$RISCV --with-xlen="$with_xlen" --with-arch=RV32IM
~~~

Then run after setting the environment variable "RISCV" to your install location:

~~~
./build.sh
~~~

## Setup and Run RISCV Business

First, clone the repository

~~~
git clone git@github.com:JakeStevens/RISCVBusiness.git
~~~

Once the directory is cloned, the configuration for a core must be generated before the project can be simulated/synthesized. This can be done using the example.yml configuration provided, or using a modification of that file.

~~~
./scripts/config_core.py example.yml
~~~

Run the following command to run the regression test on RISCV-Business.  All tests should pass:

~~~
./run_tests.py
~~~

Refer to the LICENSE file for licensing information.
