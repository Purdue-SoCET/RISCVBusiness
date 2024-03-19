# See LICENSE for license details.

#*****************************************************************************
# vstart.S
#-----------------------------------------------------------------------------
#
# Test masking off elements using write to vstart
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 6, e32, m2
	li x11, 3
	li x12, 2
	la x1, ldat
	la x2, sdat
  vle32.v v1, (x1)
	csrrw x11, vstart, x11
	vmul.vx v1, v1, x12
	csrrw x11, vstart, x12
	vse32.v v1, (x2)
	nop
	lw x3, 0(x2)
	lw x4, 4(x2)
	lw x5, 8(x2)
	lw x6, 12(x2)
	lw x7, 16(x2)
	lw x8, 20(x2)
  TEST_CASE(1, x10, 6, NOP)
	TEST_CASE(2, x3, 0x1, NOP)
	TEST_CASE(3, x4, 0x2, NOP)
	TEST_CASE(4, x5, 30, NOP)
	TEST_CASE(5, x6, 80, NOP)
	TEST_CASE(6, x7, 100, NOP)
	TEST_CASE(7, x8, 120, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat:
	.word 10
	.word 20
	.word 30
	.word 40
	.word 50
	.word 60

	sdat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006

RVTEST_DATA_END
