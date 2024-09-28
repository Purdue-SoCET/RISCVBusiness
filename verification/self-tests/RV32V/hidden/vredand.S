# See LICENSE for license details.

#*****************************************************************************
# vredand.S
#-----------------------------------------------------------------------------
#
# Test vredand instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET



  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2, vredand.vs, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_VV_OP( 3, vredand.vs, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_VV_OP( 4, vredand.vs, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
  TEST_VV_OP( 5, vredand.vs, 0xf000f000, 0xf00ff00f, 0xf0f0f0f0 );	


	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
