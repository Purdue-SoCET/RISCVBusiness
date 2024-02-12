# See LICENSE for license details.

#*****************************************************************************
# vfclass.S
#-----------------------------------------------------------------------------
#
# Test vfclass instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vfclass.v Tests
  #-------------------------------------------------------------

  TEST_FP_HEX_1OPERAND_OP(  2,  vfclass.v,  0,  1 << 0, 0xff800000 );
  TEST_FP_HEX_1OPERAND_OP(  3,  vfclass.v,  0,  1 << 1, 0xbf800000 );
  TEST_FP_HEX_1OPERAND_OP(  4,  vfclass.v,  0,  1 << 2, 0x807fffff );
  TEST_FP_HEX_1OPERAND_OP(  5,  vfclass.v,  0,  1 << 3, 0x80000000 );
  TEST_FP_HEX_1OPERAND_OP(  6,  vfclass.v,  0,  1 << 4, 0x00000000 );
  TEST_FP_HEX_1OPERAND_OP(  7,  vfclass.v,  0,  1 << 5, 0x007fffff );
  TEST_FP_HEX_1OPERAND_OP(  8,  vfclass.v,  0,  1 << 6, 0x3f800000 );
  TEST_FP_HEX_1OPERAND_OP(  9,  vfclass.v,  0,  1 << 7, 0x7f800000 );
  TEST_FP_HEX_1OPERAND_OP( 10,  vfclass.v,  0,  1 << 8, 0x7f800001 );
  TEST_FP_HEX_1OPERAND_OP( 11,  vfclass.v,  0,  1 << 9, 0x7fc00000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
