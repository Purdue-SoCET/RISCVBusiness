# See LICENSE for license details.

#*****************************************************************************
# vfsqrt, vfrsqrt
#-----------------------------------------------------------------------------
#
# Test vfsqrt, vfrsqrt7 instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vfsqrt.v Tests
  #-------------------------------------------------------------

  TEST_FP_1OPERAND_OP(     2,  vfsqrt.v,      1,  1.7724538498928541,    3.14159265 );
  TEST_FP_1OPERAND_OP(     3,  vfsqrt.v,      0,                 100,         10000 );
  TEST_FP_1OPERAND_OP(     4,  vfsqrt.v,      1,           13.076696,           171 );

  #-------------------------------------------------------------
  # vfrsqrt7.v Tests
  #-------------------------------------------------------------

  TEST_FP_HEX_1OPERAND_OP( 5,  vfrsqrt7.v,    0,          0x5f080000,    0x00718abc );
  TEST_FP_HEX_1OPERAND_OP( 6,  vfrsqrt7.v,    0,          0x1f820000,    0x7f765432 );
  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
