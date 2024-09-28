# See LICENSE for license details.

#*****************************************************************************
# vrgather_vv.S
#-----------------------------------------------------------------------------
#
# Test vrgather.vv instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 4, e32, m1
  la x1, ldat1
  la x2, ldat2
	la x3, sdat
  vle32.v v1, (x1)
  vle32.v v2, (x2)
	vle32.v v0, (x3)
  vrgather.vv v3, v2, v1
	vse32.v v3, (x3)
	lw x4, 0(x3)
	lw x5, 4(x3)
	lw x6, 8(x3)
	lw x7, 12(x3)

  TEST_CASE(1, x10, 4, NOP)
	TEST_CASE(2, x4, 0x0f0e0d0c, NOP)
	TEST_CASE(3, x5, 0x0b0a0908, NOP)
	TEST_CASE(4, x6, 0x0b0a0908, NOP)
	TEST_CASE(5, x7, 0x0, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat1:
	.word 3
	.word 2
	.word 2
	.word 6
	.word 10
	.word 0
  ldat2:
  .word 0x03020100
  .word 0x07060504
  .word 0x0b0a0908
  .word 0x0f0e0d0c
  .word 0x13121110
  .word 0x17161514

	sdat:
	.word 0x55555555
	.word 0x55555555
	.word 0x55555555
	.word 0x55555555
	.word 0x55555555
	.word 0x55555555

RVTEST_DATA_END

