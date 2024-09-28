# See LICENSE for license details.

#*****************************************************************************
# vsegmem_e16.S
#-----------------------------------------------------------------------------
#
# Test vector segmented memory operations 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
  
  //** Test unit segment load/stores ***//
    vsetivli x10, 4, e16, m1

    la x1, vindx_load
    vle8.v v0, 0(x1)

    la x1, ldat
    vluxseg3ei8.v v1, (x1), v0
    
    la x2, sdat
    vsuxseg3ei8.v v1, (x2), v0


addi x1, x1, -2
addi x2, x2, -2

// segment1 checking: 
addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 1
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail

addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 2
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail

addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 3
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail



// segment2 checking: 
addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 5
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail

addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 6
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail

addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 7
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail



// segment3 checking: 
addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 9
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail

addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 10
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail

addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 11
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail



// segment4 checking: 
addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 13
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail

addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 14
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail

addi x1, x1, 2
addi x2, x2, 2
li TESTNUM, 15
lh x3, 0(x1)
lh x4, 0(x2)
bne x3, x4, fail




   
  

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA
vindx_load:
  .byte 0
  .byte 6
  .byte 12
  .byte 18

  ldat: 
// segment1
.half 0x11
.half 0x12
.half 0x13

// segment2
.half 0x21
.half 0x22
.half 0x23

// segment3
.half 0x31
.half 0x32
.half 0x33

// segment4
.half 0x41
.half 0x42
.half 0x43


sdat:
// segment1
.half 0x0
.half 0x0
.half 0x0

// segment2
.half 0x0
.half 0x0
.half 0x0

// segment3
.half 0x0
.half 0x0
.half 0x0

// segment4
.half 0x0
.half 0x0
.half 0x0


RVTEST_DATA_END
