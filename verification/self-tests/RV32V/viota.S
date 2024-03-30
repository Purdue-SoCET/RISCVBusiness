# See LICENSE for license details.

#*****************************************************************************
# viota.S
#-----------------------------------------------------------------------------
#
# Test viota instruction 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  // load v0: mask 
  vsetvli x10, x0, e8, m8 // all 128 bits 
  la x1, v0_load
  vlm.v v0, 0(x1)

  // load v1: use in parallel prefix sum
  li x1, 16
  vsetvli x10, x1, e8
  la x1, v1_load
  vle8.v v1, 0(x1)

  // load v2: destination 
  la x1, v2_load
  vle8.v v2, 0(x1)


  vsetivli x0, 8, e8
  viota.m v2, v1, v0.t

  la x1, 16
  vsetvli x10, x1, e8
  la x2, sdat
  vse8.v v2, 0(x2)

  
  lw x3, 0(x2)
  TEST_CASE(1, x3, 0xAA01AA00, NOP)


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
    .word 0xFFFFFFFF // 
    .word 0xFFFFFFFF
    .word 0xFFFFFFFF
    .word 0xFFFFFFFF

    v0_load:
    .word 0xFFFFFFC5 // 0b1100 0101
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
