# HPM (Hardware Performance Monitor) Overview

## Introduction

This document describes the Hardware Performance Monitor (HPM) implementation in RISCVBusiness. The project implements the RISC‑V Privileged Spec (v1.13) counter set: `cycle`, `instret`, and `hpmcounter3` through `hpmcounter31`. The HPMs provide standard CSR access for post‑silicon performance characterization, regression tests, and lightweight telemetry for debug and security analysis.

## Background

HPM counters are a standardized set of machine-level CSRs that count cycles, instruction retirements, and a vendor‑defined set of events. The specification defines the CSRs and privilege controls (`mcounteren`, `mcountinhibit`) but leaves event selection to the implementation. In RISCVBusiness we map a set of common microarchitectural events (cache/TLB misses and hits, stalls, bus activity, etc.) to `hpmcounter3..31` to provide actionable observability after tapeout.

## HPM Counters and Mapping

- `cycle` (idx 0): clock cycle counter (64-bit)
- `instret` (idx 2): retired instruction counter (64-bit)
- `hpmcounter3`..`hpmcounter31` (idx 3..31): vendor event counters (64-bit each)

RISCVBusiness event mapping (default):
- `hpmcounter3`: I$ miss (counts discrete I-cache misses)
- `hpmcounter4`: D$ miss (counts discrete D-cache misses)
- `hpmcounter5`: I$ hit
- `hpmcounter6`: D$ hit
- `hpmcounter7`: iTLB miss
- `hpmcounter8`: dTLB miss
- `hpmcounter9`: iTLB hit
- `hpmcounter10`: dTLB hit
- `hpmcounter11`: bus busy cycles
- `hpmcounter12`: branch mispredicts
- `hpmcounter13`: branch predictions
- `hpmcounter14`: fetch stall cycles
- `hpmcounter15`: execute stall cycles
- `hpmcounter16`: mem stage stall cycles
- `hpmcounter17`..`hpmcounter31`: reserved for future expansion

Note: Event assignments are an implementation choice. The CSR interface is standard so software that reads the counters is portable, but the meaning of each `hpmcounterN` is documented here.

## Falling-edge Detector for Miss Events

Cache and TLB miss signals remain asserted for multiple cycles while the miss is being resolved (due to bus requests and/or page walks). Counting the raw signal would over-count (one miss producing many cycles of high level). RISCVBusiness therefore uses a falling‑edge detector to produce a single pulse when a miss completes. This approach yields one count per miss event.

## Privilege, Sampling, and Atomicity

- `mcounteren`: M-Mode only CSR that gates S/U-mode reads of each counter. If a corresponding bit is clear, S/U-mode read attempts trap to M-mode.
- `scounteren`: M/S-mode CSR that gates U-mode reads of each counter. If a corresponding bit is clear, U-mode read attempts trap to M-mode.
- `mcountinhibit`: machine-only CSR used to pause/resume counters (per-bit). Use it to atomically sample multiple counters: pause all required counters, read values, then resume.

## Post-silicon Use Cases

- Performance characterization (miss rates, stall breakdowns) for real workloads
- Testing and firmware validation during bring-up
- Workload profiling for performance tuning and compiler validation

## Status

Core HPM CSR logic and a default event mapping are implemented in `priv_csr.sv` and `priv_block.sv`. The piping of HPM events can be found in `stage3_hazard_unit.sv` and `stage3_mem_stage.sv` A verification test harness (`verification/hpm_tests/hpm.c`) exists to sample and print aligned counter values for demo and CI use.

## Future Work

- Expand `hpmcounter17..31` mappings to include predictors, branch queues, etc.
- Write software for selective instantiation of hpmcounters, reducing area and ower for unused events
- Capture waveform examples and integrate HPM screenshots into the documentation.


## Contributors

- Matthew Du (du347@purdue.edu)
- William Cunningham (wrcunnin@purdue.edu)