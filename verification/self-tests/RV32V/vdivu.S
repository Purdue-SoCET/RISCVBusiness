# See LICENSE for license details.

#*****************************************************************************
# vdivu.S
#-----------------------------------------------------------------------------
#
# Test vdivu instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 4, e32, m1
  la x1, ldat1
  li x2, 45
	la x3, sdat
	addi x4, x3, 0x10
  vle32.v v1, (x1)
  vdivu.vx v3, v1, x2
	vdivu.vx v4, v1, x0
	vse32.v v3, (x3)
	vse32.v v4, (x4)
	lw x5, 0(x3)
	lw x6, 4(x3)
	lw x7, 8(x3)
	lw x8, 12(x3)
	lw x9, 16(x3)
	lw x11, 20(x3)
  TEST_CASE(1, x10, 4, NOP)
	TEST_CASE(2, x5, 1, NOP)
	TEST_CASE(3, x6, 0, NOP)
	TEST_CASE(4, x7, 173, NOP)
	TEST_CASE(5, x8, 0x5B05AFE, NOP)
	TEST_CASE(6, x9, 0x7fffffff, NOP) # unsigned divide-by-zero
	TEST_CASE(7, x11, 0x7fffffff, NOP) # unsigned divide-by-zero

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat1:
	.word 45
	.word 13
	.word 7802
	.word -303

	sdat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006
	.word 0x00000007
	.word 0x00000008

RVTEST_DATA_END
