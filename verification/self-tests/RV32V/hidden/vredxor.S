# See LICENSE for license details.

#*****************************************************************************
# vredxor.S
#-----------------------------------------------------------------------------
#
# Test vredxor instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET



  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2, vredxor.vs, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_VV_OP( 3, vredxor.vs, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_VV_OP( 4, vredxor.vs, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
  TEST_VV_OP( 5, vredxor.vs, 0x00ff00ff, 0xf00ff00f, 0xf0f0f0f0 );


	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
