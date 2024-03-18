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
  vle32.v v1, (x1)
  nop
  vdivu.vx v3, v1, x2
  nop
	vse32.v v3, (x3)
	nop
	lw x4, 0(x3)
	lw x5, 4(x3)
	lw x6, 8(x3)
	lw x7, 12(x3)
  TEST_CASE(1, x10, 4, NOP)
	TEST_CASE(2, x4, 1, NOP)
	TEST_CASE(3, x5, 0, NOP)
	TEST_CASE(4, x6, 173, NOP)
	TEST_CASE(5, x7, 0x5B05AFE, NOP)

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

RVTEST_DATA_END
