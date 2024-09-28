# See LICENSE for license details.

#*****************************************************************************
# vrgather_vx.S
#-----------------------------------------------------------------------------
#
# Test vrgather.vx instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 13, e8, m1
  la x1, ldat1
  li x2, 20
	la x3, sdat
  vle8.v v0, (x1)
  vrgather.vx v2, v0, x2
	vse8.v v2, (x3)
	lw x4, 0(x3)
	lw x5, 4(x3)
	lw x6, 8(x3)
	lw x7, 12(x3)

  TEST_CASE(1, x10, 13, NOP)
	TEST_CASE(2, x4, 0x0, NOP)
	TEST_CASE(3, x5, 0x0, NOP)
	TEST_CASE(4, x6, 0x0, NOP)
	TEST_CASE(5, x7, 0x55555500, NOP)

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

