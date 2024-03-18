# See LICENSE for license details.

#*****************************************************************************
# vmv.S
#-----------------------------------------------------------------------------
#
# Test vmv.x.s and vmv.s.x instructions
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

	vsetivli x0, 0, e32
  li x1, 0xbeef1234
	li x2, 0xbb44aa55
	add x3, x0, x0
	add x4, x0, x0
	add x5, x0, x0
	vmv.s.x v3, x1
	
	vmv.x.s x3, v3
	vsetivli x0, 0, e16
	vmv.s.x v4, x2

	vmv.x.s x4, v4
	vsetivli x0, 0, e8
	vmv.x.s x5, v3

  TEST_CASE(1, x3, 0xbeef1234, NOP)
	TEST_CASE(2, x4, 0xffffaa55, NOP)
	TEST_CASE(3, x5, 0x00000034, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA


RVTEST_DATA_END
