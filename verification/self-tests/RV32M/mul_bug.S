#*****************************************************************************
# mul_bug.S
#-----------------------------------------------------------------------------
#
# The multiplier used to have a bug where if the first multiply was 0 * 0, then
# the core would hang due to bad logic. This test adds coverage against that bug.
# This does not affect mul{h, hsu, hu} because the saved operation on reset is
# MUL, so operand_diff would be high for those. This does not affect div or rem
# because divide by 0 is a caught error.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  TEST_RR_OP(1,  mul, 0x00000000, 0x00000000, 0x00000000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
