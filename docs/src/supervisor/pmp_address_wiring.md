# PMP Address Wiring — Known Bug (pending TLB work)

> **Read this before enabling `address_translation`.** The PMP checker is
> correctly wired only on the physical-only (no-MMU) path. The translated path
> has a known bug that produces spurious access faults.

## Status

| Path | `ipaddr` / `dpaddr` source | Correct? |
|------|----------------------------|----------|
| `ADDRESS_TRANSLATION` undefined | `*_proc_gen_bus_if.addr` | Yes |
| `ADDRESS_TRANSLATION` defined | `*_bus_ctrl_if.daddr` | **No — see below** |

Builds with `ADDRESS_TRANSLATION` defined emit an elaboration `$warning` from
`source_code/caches/separate_caches.sv`.

## The bug

`separate_caches.sv` wires the PMP address inputs from the caches' **memory-side**
bus address:

```systemverilog
assign prv_pipe_if.ipaddr = icache_bus_ctrl_if.daddr;
assign prv_pipe_if.dpaddr = dcache_bus_ctrl_if.daddr;
```

`bus_ctrl_if.daddr` is not the address the hart is accessing. It takes several
different values across the cache FSM in `l1_cache.sv`:

| Where | Value |
|-------|-------|
| `:397` (HIT) | the processor address — the only case where it is correct |
| `:487`, `:520` (fill) | `read_addr`, the **line-aligned fill base** |
| `:584` (writeback) | `decoded_addr`, the **evicted victim line** |
| `:367` (idle default) | `32'hBAD1BAD1`, a poison canary |

So PMP simultaneously over-checks (line fills the core never architecturally
accessed) and mis-checks (evictions, which are not accesses at all). It also
sees the poison canary whenever the cache goes idle mid-access.

The last case is how this was originally found: a multi-cycle `lr.w` inside a
valid PMP RWX region raised a spurious instruction-access fault, because the
fetch stalled, the icache left `HIT`, and `0xBAD1BAD1` reached a live PMP
instruction check. The instruction check is ungated — `stage3_hazard_unit.sv:95`
hardwires `hazard_if.iren = 1'b1`, and `priv_block.sv:236` assigns
`prv_intern_if.xen = prv_pipe_if.iren` — so unlike the data check (gated by real
`ren`/`wen`), it evaluates whatever is on `ipaddr` every cycle.

## Why the physical-only path is fixed and this one is not

With translation disabled, `addr_trans_on` is tied low, so `phy_addr` in
`l1_cache.sv:185` reduces to `proc_gen_bus_if.addr`: VA == PA, and the
processor-side request address *is* the physical address PMP needs. The fix is a
direct rewire.

With translation enabled, the correct source is the post-translation physical
address — `phy_addr` itself — which is computed inside `l1_cache` and not
exposed as a port. Plumbing it out is possible but is not the right end state,
because it would put a PMP check on every access rather than caching the result.

## Intended resolution

Cache PMP permissions in the TLB entry at fill time:

1. **Cache the R/W/X triple**, not a pass/fail bit. Effective permission becomes
   `PTE perms AND PMP perms`, composing with the existing permission logic.
2. **Granularity precondition:** PMP granularity must be ≥ the base page size so
   a page cannot straddle a PMP region. Priv. spec §3.7.1 guarantees the
   alignment for both matching modes — "When G ≥ 1 and pmpcfg*i*.A[1] is clear,
   i.e. the mode is OFF or TOR, then bits pmpaddr*i*[G-1:0] read as all zeros" —
   so TOR edges are G-aligned too, not just NAPOT. AFTx07 already sets
   `pmp_minimum_granularity : "64K"`, 16× the 4 KB page.
3. **Superpages are the real caveat.** Sv32 megapages are 4 MB and span 64
   granules at G=64K, so they *can* straddle PMP regions. Either shatter them
   into base-page entries or tag the entry "PMP not cached" and fall back to a
   direct check. **Do not** take the most-restrictive permission across straddled
   regions — that denies accesses PMP actually permits, which is the same
   spurious-fault bug class this page exists to describe.
4. **Privilege mode:** PMP applies to M-mode only for locked entries, and M-mode
   with `MPRV=1`/`MPP=S/U` uses S/U translation while remaining M-mode. Cached
   bits need a mode tag or an explicitly S/U-only meaning.
5. **Software contract already exists** — no new burden. Priv. spec §3.7.2
   requires `SFENCE.VMA` with `rs1=x0, rs2=x0` after writing PMP CSRs precisely
   so implementations may cache these results.

Spec permission for the whole approach, §3.7.2: "The PMP settings for the
resulting physical address may be checked (and possibly cached) at any point
between the address translation and the explicit memory access."

## Note on `iren`

`hazard_if.iren = 1'b1` is **not** a bug to fix as part of this. Once `ipaddr`
carries the true fetch address, a permanently-live instruction check is correct
behavior — "is the PC in an executable region" is a valid question on every
cycle. The hardwired `xen` is only a problem while `ipaddr` carries garbage.
