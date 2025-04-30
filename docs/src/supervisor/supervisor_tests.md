# RISC-V Supervisor Extension Hardware and Software Tests

## Hardware Tests

### 1. TLB (Direct Mapped)
  - Address translation off (M-mode and S-mode Bare Addressing)
  - Compulsory TLB Miss
  - TLB Hit
  - TLB Eviction
  - Mismatch ASID miss
  - Invalidate TLB entries, by VA & ASID
  - Invalidate TLB entries, by VA
  - Invalidate TLB entries, by ASID
  - Invalidate TLB entries, all entries
  - Address translation off (again)
<br></br>

### 2. TLB (2-Way Set Associative, only used in this test)
  - Address translation off (M-mode and S-mode Bare Addressing)
  - Compulsory TLB Miss (empty set)
  - Half-full set, TLB Hit
  - Half-full set, TLB miss
  - Full set, TLB hit
  - Full set, TLB eviction (conflict miss)
  - Mismatch ASID miss
  - Invalidate TLB entries, by VA & ASID
  - Invalidate TLB entries, by VA
  - Invalidate TLB entries, by ASID
  - Invalidate TLB entries, all entries
  - Address translation off (again)
<br></br>

### 3. Page Permission Checking
All:
  - Fault    -> Invalid page
  - Fault    -> Not readable, but writeable
  - Fault    -> Reserved bits are set
  - Fault    -> Level == 0 and no RWX bits are set
  - Fault    -> U = 1, in S-Mode, and mstatus.sum = 0
  - Fault    -> U = 0, in U-Mode
  - No Fault -> Level != 0, sv32 = 0, should NEVER EVER happen in RV32
  - Fault    -> Level != 0, sv32 = 1, pte_sv32.ppn[9:0] != 0
  - No Fault -> U = 1, in S-Mode, and mstatus.sum = 1
  - No Fault -> U = 1, in U-Mode
  - No Fault -> Level != 0, sv32 = 1, pte_sv32.ppn[9:0] == 0
Loads:
  - Fault    -> R = 0, W = 0, X = 0, mstatus.mxr = 0
  - Fault    -> R = 0, W = 0, X = 0, mstatus.mxr = 1
  - Fault    -> R = 0, W = 0, X = 1, mstatus.mxr = 0
  - No Fault -> R = 0, W = 0, X = 1, mstatus.mxr = 1
  - Fault    -> R = 0, W = 1, X = 0, mstatus.mxr = 0
  - Fault    -> R = 0, W = 1, X = 0, mstatus.mxr = 1
  - Fault    -> R = 0, W = 1, X = 1, mstatus.mxr = 0
  - Fault    -> R = 0, W = 1, X = 1, mstatus.mxr = 1
  - No Fault -> R = 1, W = 0, X = 0
  - No Fault -> R = 1, W = 0, X = 1
  - No Fault -> R = 1, W = 1, X = 0
  - No Fault -> R = 1, W = 1, X = 1
Stores:
  - Fault    -> R = 0, W = 0, X = 0
  - Fault    -> R = 0, W = 0, X = 1
  - Fault    -> R = 0, W = 1, X = 0
  - Fault    -> R = 0, W = 1, X = 1
  - Fault    -> R = 1, W = 0, X = 0
  - Fault    -> R = 1, W = 0, X = 1
  - No Fault -> R = 1, W = 1, X = 0
  - No Fault -> R = 1, W = 1, X = 1
Instructions:
  - Fault    -> R = 0, W = 0, X = 0
  - No Fault -> R = 0, W = 0, X = 1
  - Fault    -> R = 0, W = 1, X = 0
  - Fault    -> R = 0, W = 1, X = 1
  - Fault    -> R = 1, W = 0, X = 0
  - No Fault -> R = 1, W = 0, X = 1
  - Fault    -> R = 1, W = 1, X = 0
  - No Fault -> R = 1, W = 1, X = 1
<br></br>

### 4. Page Walker
  - Walk to get page
  - Walk to get megapage
  - Walk to get gigapage (RV64 only)
  - Walk to get terapage (RV64 only)
  - Walk to get petapage (RV64 only)
  - Page walk fault, mid-level page not allocated
  - Page walk fault, final-lebel page not allocated
  - Page walk fault, improper read permissions
  - Page walk fault, improper write permissions
  - Page walk fault, improper execute permissions
  - Page walk fault, improper dirty permissions
  - Page walk fault, improper access permissions
  - Page walk fault, improper valid permissions
<br></br>

### 5. TLB + Page Walker
  - TLB miss, walk to get page
  - TLB miss, walk to get megapage
  - TLB miss, walk to get gigapage (RV64 only)
  - TLB miss, walk to get terapage (RV64 only)
  - TLB miss, walk to get petapage (RV64 only)
  - TLB hit on all page types, no walk
  - TLB miss, page walk fault (page not allocated)
  - TLB miss, page walk fault (bad permissions)
<br></br>

### 6. TLB + VIPT L1$ + Page Walker
  - Cache miss, TLB miss, walk to get page, handle cache miss
  - Cache miss, TLB hit, handle cache miss
  - Cache hit, TLB hit, no walk
  - Invalidate TLB entry, Cache hit, TLB miss, walk to get page, cache hit
  - Invalidate TLB entry, change page mapping, Cache hit, TLB miss, walk to get page, cache miss
<br></br>

### 7. I$/ITLB + D$/DTLB + Page Walker
  - Compulsory misses, Data walk, instruction walk, data memory access, instruction memory access
  - I/D $ misses, no page walk, data memory access, instruction memory access
  - Full hits, no page walk, no memory access 
<br></br>