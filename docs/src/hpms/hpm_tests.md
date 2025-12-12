
# HPM (Hardware Performance Monitor) Tests

## Overview

This document provides hardware and software tests for the HPM implementation in RISCVBusiness. Tests focus on correctness of event counting, privilege gating (`mcounteren`), atomic sampling (`mcountinhibit`), and accuracy of the falling-edge miss detector for cache/TLB events.

## Hardware Tests

### 1. Basic CSR Read/Write
	- Read `mcycle` and `minstret` from M-mode: should succeed and evolve over time.
	- Attempt to read `hpmcounter3`..`hpmcounter31` from M-mode: should succeed.

### 2. Privilege Gating (`mcounteren`)
	- M-mode: clear `mcounteren` bits for cycles/instret/hpm3 and set `mcounteren`=0.
	- S-mode/U-mode: attempt reads of `cycle`, `instret`, and `hpmcounter3` → should trap when bit=0, succeed when bit=1.
	- Verify trap cause, software handler behavior, and that M-mode can choose to emulate or deny reads.

### 3. Atomic Sampling (`mcountinhibit`)
	- M-mode: set `mcountinhibit` for all counters; run a short workload; read counters; clear inhibit; run again.
	- Validate that counters did not change while inhibited.
	- Verify that reading counters while not inhibited may show transient differences between counters (race demonstration).

### 4. Falling-edge Miss Counting Accuracy
	- Synthetic miss workload: generate repeated single-line cache fills such that each miss lasts multiple cycles.
	- Expected: `hpmcounter3`/`hpmcounter4` increment exactly once per miss event (not per cycle of miss signal).
	- Inject long-latency misses and verify counts remain accurate (one per miss).

### 5. Hit/Miss Invariants
	- For a deterministic memory access pattern, verify `hits + misses = accesses` (e.g., I$ hits + I$ misses = I$ accesses) where applicable.
	- Run several workloads (warm cache, cold cache, random accesses) and check invariants within tolerance.

### 6. Page Walker & TLB Interaction
	- Trigger page walks (TLB misses causing walks). Verify `hpmcounter11` (page walker miss/fault) and `hpmcounter12` (page walk count) reflect expected activity.
	- Verify that a missed TLB causes a single increment on `hpmcounter7`/`hpmcounter8` (falling-edge) when the walk completes.

### 7. Stall Counters
	- Create workloads that cause fetch/decode/execute/mem stalls and verify `hpmcounter13..15` increment as expected.

### 8. D$ Snoop Counters
	- Verify `hpmcounter16..18` track snoop total/hits/misses.

### 9. Branch Counters
	- Run code with predictable branches to validate `hpmcounter19`/`hpmcounter20` (mispredict vs predictions).

### 10. Bus Busy
	- Saturate bus with continuous transfers and verify `hpmcounter21` counts bus-busy cycles.

## Software / Verification Tests

### A. HPM Test Harness
	- Use `verification/hpm_tests/hpm.c` as harness to sample, print, and align `mcycle`, `minstret`, and `hpmcounter3..31`.
	- Add variants that exercise `mcountinhibit` pause/read/resume sequences and validate values are consistent across samples.

### B. Privilege Delegation Tests
	- Validate `medeleg` and CSR delegation interplay with `mcounteren`: ensure S-mode traps are delegated correctly and handlers see expected state.

### C. Regression and CI Checks
	- Add automated checks that run small workloads and assert: (1) counters monotonically increase where expected, (2) hits+misses within expected ratio bands, (3) sampling with `mcountinhibit` yields reproducible results.

## Status

Initial harness exists (`verification/hpm_tests/hpm.c`) and basic M/S flows are validated. Falling-edge logic is implemented in `priv_block.sv`. Several TODO counters are currently placeholders; tests should mark their expectations accordingly until mappings are finalized.

## Future Work

- Expand test coverage for multi-core snoop scenarios and add power/energy proxies where possible.

## Contributors

- Matthew Du (du347@purdue.edu)
- William Cunningham (wrcunnin@purdue.edu)