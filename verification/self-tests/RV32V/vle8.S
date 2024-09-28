# See LICENSE for license details.

#*****************************************************************************
# vle8.S
#-----------------------------------------------------------------------------
#
# Test vle8 and vse8 instructions
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 13, e8, m1
	la x1, ldat
	la x2, sdat
  vle8.v v1, (x1)
	vse8.v v1, (x2)
	lw x3, 0(x2)
	lw x4, 4(x2)
	lw x5, 8(x2)
	lw x6, 12(x2)
	TEST_CASE(1, x10, 13, NOP)
	TEST_CASE(2, x3, 0xfcfdfeff, NOP)
	TEST_CASE(3, x4, 0x0201fafb, NOP)
	TEST_CASE(4, x5, 0x06050403, NOP)
	TEST_CASE(5, x6, 0x4444441a, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat:
	.word 0xfcfdfeff
	.word 0x0201fafb
	.word 0x06050403
	.word 0x4d3c2b1a

	sdat:
	.word 0x11111111
	.word 0x22222222
	.word 0x33333333
	.word 0x44444444

RVTEST_DATA_END
