# See LICENSE for license details.

#*****************************************************************************
# vmsif.S
#-----------------------------------------------------------------------------
#
# Test vmsif instruction 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetvli x1, x0, e8, m8 // all 128 bits 

  vmsif.m v2, v1
  
  la x2, sdat
  vsm.v v2, 0(x2)

  lw x4, 12(x2)
  TEST_CASE(1, x4, 0xffffffff, NOP)


  la x2, v0_load
  vlm.v v0, 0(x2)

  la x2, v1_load
  vlm.v v1, 0(x2)

  vmsif.m v3, v1, v0.t

  la x2, sdat
  vsm.v v3, 0(x2)

  lw x4, 0(x2)
  TEST_CASE(2, x4, 0x7C3, NOP)
  

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

    v1_load:
    .word 0xFFFFFC3C // 
    .word 0xFFFFFFFF
    .word 0xFFFFFFFF
    .word 0xFFFFFFFF

    v0_load:
    .word 0xFFFFFFC3 // 0b1100 0011
    .word 0xFFFFFFFF
    .word 0xFFFFFFFF
    .word 0xFFFFFFFF

    v2_load:
    .word 0xAAAAAAAA
    .word 0xAAAAAAAA
    .word 0xAAAAAAAA
    .word 0xAAAAAAAA

    v0_load2: 
    .word 0x03; // 0b0000 0011
    .word 0x0
    .word 0x0
    .word 0xFFFFFFFF



RVTEST_DATA_END
