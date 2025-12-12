# Multicore

A multicore design is a type of multiprocessing in which multiple cores are
used to run programs in parallel. This is sometimes referred to as chip
multiprocessing (CMP). Multicore designs generally offer greater performance at
the cost of power and area.

## Current architecture plan for the Dual-core processor with MESI Coherence
![Plan](../fig/mc_arch_idea.png)
## Cache coherence

Incoherency can arise when programs acting on shared memory execute on a system
using private caches which do not synchronize with each other. An example of
this is shown below. Total program order in the example below is used to
sequentialize operations occuring in parallel. Both processors are running the
same program which loads a global variable, adds 100 to it, and then stores it
back to memory. Initially, processor 2 has the value at `0(sp)` in its cache.
Processor 1 loads in `0(sp)` into its cache and the `a0` register. It then adds
100 to `a0` which brings its value to 200. Finally, it stores the value back to
the same address of `0(sp)`. However, this causes an incoherence in the caches
of processors 1 and 2 because the value in processor 2's cache is still 100.
Processor 2 then loads the value of 100 from its cache into its `a0` register.
It then adds 100 to it, and again stores it back to memory.

![Cache Incoherence](../fig/cache_incoherence.png)

An example of coherent system running the same program is shown below. The
runtime state is mostly the same until total program order 3 in which processor
1 stores 200 to `0(sp)`. When this happens, this also updates the value in
processor 2's cache to 200. Then, when it loads the value from memory in total
program order 4, it loads the updated value of 200 to its `a0` register. Then,
when it adds 100 to it and stores it, it stores the correct value of 300.

![Cache Coherence](../fig/cache_coherence.png)

## Cache Modifications

To enable coherency and atomics, a reservation set register, a duplicate SRAM tag array, 
and a coherency interface were added to each L1 cache. Each cache is connected to an atomicity 
unit that handles bus transactions. This is intended to reduce the complexity of 
the cache and allows other cache designs to be used with few coherency-related modifications.

The coherency interface grants read-only access to the duplicate SRAM array to the bus.
This allows the bus to compare tags when snooping without interrupting the cache. The bus
only gains access to the cache's SRAM data array if a snoop hit occurs, causing the cache
FSM to enter a snooping state. The signals provided by the coherency interface, bus_ctrl_if,
are available in the source_code/include/bus_ctrl_if.

Currently, the duplicate SRAM array contains both the data and the tags. This duplicate
data is not used, so the extra SRAM cells used to store them will need to be removed.
Additionally, the seperate_caches.sv file in the source_code/caches/ directory can be
modified to use a cache without coherency for the Icache. At present, both the Dcache and
Icache use the same L1 module.

## Atomics

Atomic instructions can be used to provide memory ordering and ensure that
a read-modify-write operation occurs as a single instruction. Memory ordering
restrictions can be used to ensure whether or not certain instructions can be
observed to have taken place by the time the atomic instruction executes. The
table below briefly covers the semantics behind each ordering. Furthermore,
a store-acquire or load-release operation would be semantically meaningless due
to how data dependencies could be observed. It does not matter if a store is
done with acquire semantics because stores in atomic contexts are used for
ordering with respect to a previous load-acquire. Similarly, a load-release is
nonsensical because it is not useful to have execution continue based off of
future loads/stores.

A simple mental model which can be used to understand these orderings is how
they would be used in a mutex. For example, when acquiring a mutex, we want all
previous state to have completed so that the critical path relies on the most
up to date information. When releasing the mutex, we want anyone who depends on
the data behind the mutex to have the most up to date data from the execution
of the critical path.

| Memory Ordering          | Description                                                                                                                                                                        |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Relaxed                  | No ordering with respect to any other loads occurs.                                                                                                                                |
| Acquire (acq)            | Ensures that no following memory operations can be observed to have happened before this operation.                                                                                |
| Release (rel)            | Ensures that all previous memory operations must be observed to have happened before this operation.                                                                               |
| Acquire-Release (acqrel) | Ensures that all previous memory operations must be observed, and no following memory operations can be observed to have happened before this operation (sequentially consistent). |

It should be noted that these orderings are mostly relevant for out-of-order
cores or for cores with out of order load-store queues. The current core is an
in-order pipeline with no load-store queue therefore there is no support needed
for these orderings.

### Hardware atomics

Hardware atomics are planned to be implemented through a `LRX`, `SC_AND_OP`
microop execution sequence. The `LRX` microinstruction will be used to perform
a load-reserved with an exclusive bit set which would block any other
transactions on that cache line. The `SC_AND_OP` microinstruction would use the
results from the free ALU to be used as the store value the memory stage. As
with all `SC`'s, this clears the reservation set on that cache line.

Another interesting architecture is to attach an atomic unit to the bus,
however, this would likely be unnecessary for our small scale dual core system.
[Information on this architecture can be found
here](https://ieeexplore.ieee.org/document/9218661).

### Software emulated atomics

Because `LR`/`SC` are the basic building blocks of all atomic instructions,
a tight loop consisting of an `LR`, operation, and `SC` can be used to emulate
any AMO. An `LR` can be followed by a sequence of instructions to emulate the
effects of an AMO, which is then followed by an `SC` and a conditional jump
back to the `LR` can be used to retry the execution of an AMO until the `SC`
succeeds.

The core currently has support for the entire atomic instruction extension
through the use of the C routines in
`verification/asm-env/selfasm/c/amo_emu.c`. This file sets up an exception
handler for emulating atomic extension instructions in the case of illegal
instruction exceptions. The trap handler pushes all the registers to the stack,
decodes the instruction, executes it and updates the saved register on the
stack, then pops all the registers from the stack and returns. Support macros
for assembly usage are in `verification/asm-env/selfasm/amo_emu.h`. The
`WANT_AMO_EMU_SUPPORT` macro can be used to set up some support for the
C runtime including setting up the stack and exception handler. This allows for
trapping any encountered atomic instructions and emulating them using `LR`/`SC`
loops. This can be used as a stopgap until the hardware implementation of
atomics is completed.

## Heterogenous Multicore

A heterogeneous multicore system uses disparate core designs and features to
enable multiprocessing. This allows for greater task level parallelism without
the power and area overhead required by a homogeneous design. The current
RISCVBusiness framework supports heterogeneous core designs by allowing
per-core configuration of RISC-V extensions, caches, branch predictors, and
multipliers.

### Heterogeneous Multicore Build Framework
The heterogeneous multicore flow follows a 
YAML → Python parser → generated packages workflow.

#### Step 1: Edit the YAML Configuration
Each core is configured through the YAML configuration file
`core_configuration.yml`.
1. Set `num_harts` to the number of cores you want.
2. Define one `coreX_params` block per core (e.g., `core0_params`,
  `core1_params`, etc.).
3. Edit global and per-core configuration parameters for each hart.
   
- Per-core configurable settings include:
  - ISA extensions
  - Branch predictor
  - Cache hierarchy, size, and associativity
  - Multiplier implementation

- Global configurations include:
  - `num_harts`
  - `xlen`
  - Bus type and endianness
  - Cache block sizes
  - Supervisor and address translation settings
 
#### Step 2: Run the Python Configuration Parser
```make config``` parses the configuration file and auto generates 3 files for 
building the core using the `scripts/hetero_config_core.py` python parser:
 - `source_code/packages/core_configuration_pkg.sv`
    - Contains per-core configuration parameters.
    - Configurable modules are determined during compile time using generate blocks
      indexed by `CORE_CONFIG[HART_ID]` in the core_configuration_pkg.sv file.  
 - `source_code/include/component_selection_defines.vh`
    - Contains global configuration parameters shared across all cores.
 - `verification/c-firmware/custom_instruction_calls.h`
    - Contains firmware instruction macros.

To build the core with selected configurations using verilator, run ```make verilate```.


### Heterogeneous Multicore Verification
[riscv-tests](../../riscv-tests/), an open source RISC-V extension unit tests provided 
by RISC-V International is used to verify extension functionality. 

#### Running riscv-tests for multicore
To run extension unit tests with the multicore, run the following command after build. 

`./run_riscv_tests.py --environment pm --isa [extension] --num-harts [N]`.

In order to test multiple cores, the `--environment` flag must be set to `pm` 
for multicore and `--num-harts` flag must be set. 

For heterogeneous multicore, `run_tests.py` is not supported yet.

#### How it works
For pm environment, required extension information is written to fromhost address 
from the testbench. Each core compares required extension with its misa register 
and skips the test if it is missing the extension. 

Once the test completes, results are displayed to the terminal and shows the 
per core result if any one core skips or fails the unit test. 

Due to how riscv-tests are written for multiple cores to read and write to same 
address and compare its result to some fixed value, tests in C and A extensions will 
fail. Currently, C extension tests that fail for pm environment are disabled.

### Clock Gating
To improve power efficiency, the core includes a simple clock-gating module
implemented in  
`source_code/standard_core/core_clk_gating.sv`.  
This module gates the pipeline clock when the core executes a `wfi` instruction
and re-enables the clock when the core receives a software interrupt via MSIP.
As a result, software must be written such that at least one core remains awake
at all times to generate interrupts that can wake sleeping cores.

Since RISCVBusiness does not currently include a CLINT module, the testbench
must emulate inter-processor interrupts. This behavior is implemented in  
`verification/multicore-tests/c-tests/core_clk_gating_tb.c`, which uses a
software-based mechanism to model MSIP behavior. Specifically, writes by one
core to `MSIP_ADDR` are treated as software interrupts that wake other cores
from the `wfi` state.

### Running C-tests for Multicore
Core functionality can be tested with custom C tests. Current tests are written 
for homogeneous multicores.

To test homogeneous multicore scalability, a bootup file and 3 tests are written 
to support 1 to 8 cores. The 3 tests that can be ran with 8 cores are 
mergesort.c, matmul.c, and vector_add.c. 

#### C-test structure 
`verification/multicore-tests/c-tests/multicore_start.S` is the boot file 
for multicore C tests. In multicore_start.S file, after bss clear, each core is 
directed to its corresponding main function.

`verification/multicore-tests/c-tests/(test_name).c` file contains hartx_main 
functions for each core. After all cores finishes its test, `hartx_done` and `flag` 
variables needs be set to 1 for `tb_core.cc` testbench to check whether the test 
has passed. Once core 0 returns from the main function, `flag` and `hartx_done` 
variable values are loaded to each core's x28 register, which is checked 
for the test result. 

#### Running the test
To build and run the test, run `/.build_and_run.sh [testname]` in the 
verification/multicore-tests/c-tests directory.

To run the test without building the core, run `./run.sh [testname]`. `[testname]` 
should only include the test name and exclude `.c`.

### Future works
- Improve power management
    - Current clock gating implementation provides basic power management. Further
      power gating techniques can be implemented.
- Expand heterogeneity
    - Multiple pipeline stages, supervisor settings, and more extensions can be
      implemented as configurable features.
- AFT-dev integration and application
