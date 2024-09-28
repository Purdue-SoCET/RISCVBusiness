# See LICENSE for license details.

#*****************************************************************************
# vredor.S
#-----------------------------------------------------------------------------
#
# Test vredor instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET



  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2, vredor.vs, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_VV_OP( 3, vredor.vs, 0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_VV_OP( 4, vredor.vs, 0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );
  TEST_VV_OP( 5, vredor.vs, 0xf0fff0ff, 0xf00ff00f, 0xf0f0f0f0 );	


	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
