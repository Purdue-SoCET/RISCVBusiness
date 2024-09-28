# See LICENSE for license details.

#*****************************************************************************
# vfirst.S
#-----------------------------------------------------------------------------
#
# Test vfirst instruction 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
  // simple test case 
  vsetvli x10, x0, e8, m8; // set vl to 128
  la x1, ldat
  la x2, v0_load
  vlm.v v1, 0(x1)
  vlm.v v0, 0(x2)

  
  vsetivli x0, 4, e32
  vfirst.m x3, v1, v0.t  // return -1 if none found 
  TEST_CASE(1, x3, -1, NOP) 


  vsetivli x0, 7, e8
  vfirst.m x3, v1, v0.t 
  TEST_CASE(2, x3, 4, NOP)

  vsetvli x10, x0, e8, m8
  la x2, v0_load2
  vlm.v v0, 0(x2)
  vfirst.m x3, v1, v0.t
  TEST_CASE(3, x3, 112, NOP)




  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

  ldat: 
  .word 0X5C // 0b0101 1100
  .word 0XFFFFFFFF
  .word 0XFFFFFFFF
  .word 0X30000


	sdat:
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF
	.word 0xDEADBEEF


    v0_load:
    .word 0x13; // 0b0001 0011
    .word 0x0
    .word 0x0
    .word 0xFFFFFFFF

    v0_load2: 
    .word 0x03; // 0b0000 0011
    .word 0x0
    .word 0x0
    .word 0xFFFFFFFF



RVTEST_DATA_END
