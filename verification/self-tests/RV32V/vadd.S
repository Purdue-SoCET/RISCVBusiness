# See LICENSE for license details.

#*****************************************************************************
# vadd.S
#-----------------------------------------------------------------------------
#
# Test vadd
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

  vsetivli x10, 4, e32
	la x1, ldat
	la x2, sdat
  vle32.v v1, (x1)
  vle32.v v2, 0(x1)
  
  vadd.vv v0, v2, v1

    vse32.v v0, (x2)
    NOP
    lw x3, 0(x2)
    lw x4, 4(x2)
    lw x5, 8(x2)
    lw x6, 12(x2)
    lw x7, 16(x2)
    lw x8, 20(x2)
    TEST_CASE(1, x10, 4, NOP)
    TEST_CASE(2, x3, 2, NOP)
    TEST_CASE(3, x4, 4, NOP)
    TEST_CASE(4, x5, 6, NOP)
    TEST_CASE(5, x6, 8, NOP)
    TEST_CASE(6, x7, 5, NOP)
    TEST_CASE(7, x8, 6, NOP)


  // test adding with a register
  
  li x15, 20
  vadd.vx v0, v1, x15 
  vse32.v v0, 0(x2)

    lw x3, 0(x2)
    lw x4, 4(x2)
    lw x5, 8(x2)
    lw x6, 12(x2)
    lw x7, 16(x2)
    lw x8, 20(x2)

    TEST_CASE(8, x3, 21, NOP)
    TEST_CASE(9, x4, 22, NOP)
    TEST_CASE(10, x5, 23, NOP)
    TEST_CASE(11, x6, 24, NOP)
    TEST_CASE(12, x7, 5, NOP)
    TEST_CASE(13, x8, 6, NOP)


// test adding with an immediate
  vadd.vi v0, v1, 10
  vse32.v v0, 0(x2)

    lw x3, 0(x2)
    lw x4, 4(x2)
    lw x5, 8(x2)
    lw x6, 12(x2)
    lw x7, 16(x2)
    lw x8, 20(x2)

    TEST_CASE(14, x3, 11, NOP)
    TEST_CASE(15, x4, 12, NOP)
    TEST_CASE(16, x5, 13, NOP)
    TEST_CASE(17, x6, 14, NOP)
    TEST_CASE(18, x7, 5, NOP)
    TEST_CASE(19, x8, 6, NOP)
    



  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

	ldat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006

	sdat:
	.word 0x00000001
	.word 0x00000002
	.word 0x00000003
	.word 0x00000004
	.word 0x00000005
	.word 0x00000006

RVTEST_DATA_END
