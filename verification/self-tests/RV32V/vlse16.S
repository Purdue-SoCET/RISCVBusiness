# See LICENSE for license details.

#*****************************************************************************
# vle32.S
#-----------------------------------------------------------------------------
#
# Test vle32 and vse32 instructions
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 6, e16, m1
  li x15, 4
	la x1, ldat
	la x2, sdat
  vlse16.v v1, (x1), x15
	NOP
	vsse16.v v1, (x2), x15
	NOP
	lw x3, 0(x2)
	lw x4, 4(x2)
	lw x5, 8(x2)
	lw x6, 12(x2)
	lw x7, 16(x2)
	lw x8, 20(x2)
  TEST_CASE(1, x10, 6, NOP)
	TEST_CASE(2, x3, 0xff, NOP)
	TEST_CASE(3, x4, 0xfe, NOP)
	TEST_CASE(4, x5, 0xfd, NOP)
	TEST_CASE(5, x6, 0xfc, NOP)
	TEST_CASE(6, x7, 0xfb, NOP)
	TEST_CASE(7, x8, 0xfa, NOP)


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
