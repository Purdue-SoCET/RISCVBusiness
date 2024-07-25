# See LICENSE for license details.

#*****************************************************************************
# vdiv.S
#-----------------------------------------------------------------------------
#
# Test vdiv instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 6, e32, m2
  la x1, ldat1
  la x2, ldat2
	la x3, sdat
  vle32.v v0, (x1)
  vle32.v v2, (x2)
  vdiv.vv v4, v0, v2
	vse32.v v4, (x3)
	lw x4, 0(x3)
	lw x5, 4(x3)
	lw x6, 8(x3)
	lw x7, 12(x3)
	lw x8, 16(x3)
	lw x9, 20(x3)
  TEST_CASE(1, x10, 6, NOP)
	TEST_CASE(2, x4, 3, NOP)
	TEST_CASE(3, x5, -11, NOP)
	TEST_CASE(4, x6, 60, NOP)
	TEST_CASE(5, x7, 0, NOP)
	TEST_CASE(6, x8, 0xffffffff, NOP) # divide-by-zero
	TEST_CASE(7, x9, 0x80000000, NOP) # divide overflow

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat1:
	.word 30
	.word -45
	.word 60
	.word 70
	.word 86
	.word 0x80000000
  ldat2:
  .word 10
  .word 4
  .word 1
  .word 71
  .word 0
  .word 0xffffffff

	sdat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006

RVTEST_DATA_END
