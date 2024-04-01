# See LICENSE for license details.

#*****************************************************************************
# vslide1up_e8.S
#-----------------------------------------------------------------------------
#
# Test vslide1up.vx instruction
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

	vsetivli x10, 3, e8
  la x1, ldat
	la x2, sdat
  li x3, 0xfeea
  vle8.v v1, (x1)
  nop
  vslide1up.vx v2, v1, x3
  nop
  vse8.v v2, (x2)

  lw x4, 0(x2)

  TEST_CASE(1, x10, 0x3, NOP)
	TEST_CASE(2, x4, 0x550100ea, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

  ldat:
  .word 0x03020100
  .word 0x07060504
  .word 0x0b0a0908
  .word 0x0f0e0d0c

  sdat:
  .word 0x55555555
  .word 0x55555555
  .word 0x55555555
  .word 0x55555555

RVTEST_DATA_END
