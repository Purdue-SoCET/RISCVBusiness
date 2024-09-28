# See LICENSE for license details.

#*****************************************************************************
# vand.S
#-----------------------------------------------------------------------------
#
# Test vand instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2, vand.vv, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_VV_OP( 3, vand.vv, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_VV_OP( 4, vand.vv, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
  TEST_VV_OP( 5, vand.vv, 0xf000f000, 0xf00ff00f, 0xf0f0f0f0 );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VX_OP( 6, vand.vx, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_VX_OP( 7, vand.vx, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_VX_OP( 8, vand.vx, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
  TEST_VX_OP( 9, vand.vx, 0xf000f000, 0xf00ff00f, 0xf0f0f0f0 );	

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VI_OP( 10, vand.vi, 0x00000000, 0xff00ff00, 0x0 );
  TEST_VI_OP( 11, vand.vi, 0x00000000, 0xff00ff00, 0xf );
  TEST_VI_OP( 12, vand.vi, 0x00000000, 0x0ff00fff, 0x0 );
  TEST_VI_OP( 13, vand.vi, 0x0000000f, 0x0ff00fff, 0xf );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
