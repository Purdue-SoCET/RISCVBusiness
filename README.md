# RISCVBusiness
Design documents and project information for the RISC-V Business project can be found here:

[RISCV-Business Documentation](https://purdue-socet.github.io/RISCVBusiness/)

**Current User-Level ISA Spec :** Version 20250508

**Current Privileged ISA Spec :** Version 20250508

# Getting Started
## Dependencies
- [Verilator](https://verilator.org/guide/latest/) for RTL simulation
- [FuseSoC](https://github.com/olofk/fusesoc) for building
- [RISC-V GCC Toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain) for compiling tests

## FuseSoC
This project uses the [Fusesoc](https://github.com/olofk/fusesoc) build system.  Use the following commands to get started:

```bash
# install project dependencies &
# setup git pre-commit hook
./setup.sh

# For ease of use, use the makefile to run FuseSoC tests
make # shows all build targets available

# configure the RISC-V core
# (modify the Makefile to use a different YAML file than example.yml)
make config 

make verilate # build with Verilator
```

> Note: The fusesoc dependencies 'bus-components' and 'digital-lib' are only needed for full chip tapeouts. Simulation standalone with the `generic_bus_if` bus do not require these. If this gives trouble, you can safely skip the `fusesoc library add` steps of `setup.sh`, and comment out the dependencies from the core file.

Now you can run simulations/tests:
```bash
# setup riscv-tests
./setup-riscv-tests.sh
# Run ISA tests
run_tests.py

# Run specify binary on Verliator core simulation
./rvb_out/sim-verilator/Vtop_core meminit.bin
```

Refer to the LICENSE file for licensing information.
