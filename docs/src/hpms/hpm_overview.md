# HPM (Hardware Performance Monitor) Overview

## Introduction

This document describes the Hardware Performance Monitor (HPM) implementation in RISCVBusiness. The project implements the RISC‑V Privileged Spec (v1.13) counter set: `mcycle`, `minstret`, and `hpmcounter3` through `hpmcounter31`. The HPMs provide standard CSR access for post‑silicon performance characterization, regression tests, and lightweight telemetry for debug and security analysis.

## Background

HPM counters are a standardized set of machine-level CSRs that count cycles, instruction retirements, and a vendor‑defined set of events. The specification defines the CSRs and privilege controls (`mcounteren`, `mcountinhibit`) but leaves event selection to the implementation. In RISCVBusiness we map a set of common microarchitectural events (cache/TLB misses and hits, stalls, bus activity, etc.) to `hpmcounter3..31` to provide actionable observability after tapeout.

## HPM Counters and Mapping

- `mcycle` (cnt 0): wall-clock cycle counter (64-bit)
- `minstret` (cnt 2): retired instruction counter (64-bit)
- `hpmcounter3`..`hpmcounter31` (cnt 3..31): vendor event counters (64-bit each)

RISCVBusiness event mapping (default):
- `hpmcounter3`: I$ miss (counts discrete I-cache misses)
- `hpmcounter4`: D$ miss (counts discrete D-cache misses)
- `hpmcounter5`: I$ hit
- `hpmcounter6`: D$ hit
- `hpmcounter7`: iTLB miss
- `hpmcounter8`: dTLB miss
- `hpmcounter9`: iTLB hit
- `hpmcounter10`: dTLB hit
- `hpmcounter11`: page walker miss/fault
- `hpmcounter12`: page walk count
- `hpmcounter13`: fetch stall cycles
- `hpmcounter14`: execute stall cycles
- `hpmcounter15`: mem stage stall cycles
- `hpmcounter16`: D$ snoop total
- `hpmcounter17`: D$ snoop hits
- `hpmcounter18`: D$ snoop misses
- `hpmcounter19`: branch mispredicts
- `hpmcounter20`: branch predictions (conditional)
- `hpmcounter21`: bus busy cycles
- `hpmcounter22`..`hpmcounter31`: reserved for future expansion

Note: Event assignments are an implementation choice. The CSR interface is standard so software that reads the counters is portable, but the meaning of each `hpmcounterN` is documented here.

## Falling-edge Detector for Miss Events

Cache and TLB miss signals remain asserted for multiple cycles while the miss is being resolved (page walk, refill). Counting the raw signal would over-count (one miss producing many cycles of high level). RISCVBusiness therefore uses a falling‑edge detector to produce a single pulse when a miss completes:

- A one-cycle delayed register samples the miss signal (`miss_q`).
- The falling edge is detected as `miss_q & ~miss_now` and generates a single-cycle pulse fed into the `hpm_inc[]` array.

This approach yields one count per miss event (discrete miss counting).

## Privilege, Sampling, and Atomicity

- `mcounteren`: machine-only CSR that gates S/U reads of each counter. If a corresponding bit is clear, S/U read attempts trap to M-mode.
- `mcountinhibit`: machine-only CSR used to pause/resume counters (per-bit). Use it to atomically sample multiple counters: pause all required counters, read values, then resume.

## Post-silicon Use Cases

- Performance characterization (miss rates, stall breakdowns) for real workloads
- Testing and firmware validation during bring-up
- Workload profiling for performance tuning and compiler validation

## Status

Core HPM CSR logic and a default event mapping are implemented in `priv_csr.sv` and `priv_block.sv`. A verification test harness (`verification/hpm_tests/hpm.c`) exists to sample and print aligned counter values for demo and CI use.

## Future Work

- Expand `hpmcounter22..31` mappings to include predictors, branch queues, etc.
- Write software for selective instantiation of hpmcounters, reducing area and ower for unused events
- Capture waveform examples and integrate HPM screenshots into the documentation.

## Demo Checklist

- Configure `mcounteren` appropriately (M-mode) so the demo environment can read the counters from S-mode if intended.
- Use `mcountinhibit` to pause counters for atomic snapshots: pause → read all counters → resume.
- Show aligned output from `verification/hpm_tests/hpm.c` so audiences can easily compare samples.


## Contributors

- Matthew Du (du347@purdue.edu)
- William Cunningham (wrcunnin@purdue.edu)