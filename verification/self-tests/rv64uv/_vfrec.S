# See LICENSE for license details.

#*****************************************************************************
# vfrec
#-----------------------------------------------------------------------------
#
# Test vfrec instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vfrec7.v Tests
  #-------------------------------------------------------------

  TEST_FP_HEX_1OPERAND_OP( 2,  vfrec7.v,    0,          0x7e900000,    0x00718abc );
  TEST_FP_HEX_1OPERAND_OP( 3,  vfrec7.v,    0,          0x00214000,    0x7f765432 );
  
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
