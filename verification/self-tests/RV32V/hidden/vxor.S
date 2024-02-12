# See LICENSE for license details.

#*****************************************************************************
# xor.S
#-----------------------------------------------------------------------------
#
# Test xor instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2, vxor.vv, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_VV_OP( 3, vxor.vv, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_VV_OP( 4, vxor.vv, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
  TEST_VV_OP( 5, vxor.vv, 0x00ff00ff, 0xf00ff00f, 0xf0f0f0f0 );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VX_OP( 6, vxor.vx, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_VX_OP( 7, vxor.vx, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_VX_OP( 8, vxor.vx, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
  TEST_VX_OP( 9, vxor.vx, 0x00ff00ff, 0xf00ff00f, 0xf0f0f0f0 );

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VI_OP( 10, vxor.vi, 0xff00ff00, 0xff00ff00, 0x0 );
  TEST_VI_OP( 11, vxor.vi, 0xff00ff0f, 0xff00ff00, 0xf );
  TEST_VI_OP( 12, vxor.vi, 0x0ff00fff, 0x0ff00fff, 0x0 );
  TEST_VI_OP( 13, vxor.vi, 0x0ff00ff0, 0x0ff00fff, 0xf );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
