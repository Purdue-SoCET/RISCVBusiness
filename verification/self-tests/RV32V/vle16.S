# See LICENSE for license details.

#*****************************************************************************
# vle16.S
#-----------------------------------------------------------------------------
#
# Test vle16 and vse16 instructions
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 8, e16, m1
	la x1, ldat
	la x2, sdat
  vle16.v v1, (x1)
	NOP
	vse16.v v1, (x2)
	NOP
	lw x3, 0(x2)
	lw x4, 4(x2)
	lw x5, 8(x2)
	lw x6, 12(x2)
  TEST_CASE(1, x10, 8, NOP)
	TEST_CASE(2, x3, 0xff, NOP)
	TEST_CASE(3, x4, 0xfe, NOP)
	TEST_CASE(4, x5, 0xfd, NOP)
	TEST_CASE(5, x6, 0xfc, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat:
	.word 0x000000ff
	.word 0x000000fe
	.word 0x000000fd
	.word 0x000000fc
	.word 0x000000fb
	.word 0x000000fa

	sdat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006

RVTEST_DATA_END
