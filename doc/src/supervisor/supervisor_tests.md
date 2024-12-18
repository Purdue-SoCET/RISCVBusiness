# RISC-V Supervisor Extension Hardware and Software Tests

## Hardware Tests

### 1. TLB (Direct Mapped)
  - Compulsary TLB Miss
  - TLB Hit
  - TLB Eviction
  - Mismatch ASID miss
  - Invalidate TLB entry
  - Invalid TLB entry miss
  - User/Supervisor read permissions
  - User/Supervisor write permissions
  - User/Supervisor execute permissions
  - User/Supervisor other permissions
  - Machine mode no operation
<br></br>

### 2. TLB (2-Way Set Associative, only used in this test)
  - Compulsary TLB Miss (empty set)
  - Half-full set, TLB Hit
  - Half-full set, TLB miss
  - Full set, TLB hit
  - Full set, TLB eviction (conflict miss)
  - Mismatch ASID miss
  - Invalidate TLB entry
  - Invalid TLB entry miss
  - User/Supervisor read permissions
  - User/Supervisor write permissions
  - User/Supervisor execute permissions
  - User/Supervisor other permissions
  - Machine mode no operation
<br></br>

### 3. Page Walker
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

### 4. TLB + Page Walker
  - TLB miss, walk to get page
  - TLB miss, walk to get megapage
  - TLB miss, walk to get gigapage (RV64 only)
  - TLB miss, walk to get terapage (RV64 only)
  - TLB miss, walk to get petapage (RV64 only)
  - TLB hit on all page types, no walk
  - TLB miss, page walk fault (page not allocated)
  - TLB miss, page walk fault (bad permissions)
<br></br>

### 5. TLB + VIPT L1$ + Page Walker
  - Cache miss, TLB miss, walk to get page, handle cache miss
  - Cache miss, TLB hit, handle cache miss
  - Cache hit, TLB hit, no walk
  - Invalidate TLB entry, Cache hit, TLB miss, walk to get page, cache hit
  - Invalidate TLB entry, change page mapping, Cache hit, TLB miss, walk to get page, cache miss
<br></br>

### 6. I$/ITLB + D$/DTLB + Page Walker
  - Compulsary misses, Data walk, instruction walk, data memory access, instruction memory access
  - I/D $ misses, no page walk, data memory access, instruction memory access
  - Full hits, no page walk, no memory access 
<br></br>