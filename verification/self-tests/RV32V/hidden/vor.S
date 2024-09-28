# See LICENSE for license details.

#*****************************************************************************
# vor.S
#-----------------------------------------------------------------------------
#
# Test vor instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2, vor.vv, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_VV_OP( 3, vor.vv, 0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_VV_OP( 4, vor.vv, 0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );
  TEST_VV_OP( 5, vor.vv, 0xf0fff0ff, 0xf00ff00f, 0xf0f0f0f0 );

  #-------------------------------------------------------------
  # VX tests
  #-------------------------------------------------------------

  TEST_VX_OP( 6, vor.vx, 0xff0fff0f, 0xff00ff00, 0x0f0f0f0f );
  TEST_VX_OP( 7, vor.vx, 0xfff0fff0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_VX_OP( 8, vor.vx, 0x0fff0fff, 0x00ff00ff, 0x0f0f0f0f );
  TEST_VX_OP( 9, vor.vx, 0xf0fff0ff, 0xf00ff00f, 0xf0f0f0f0 );	

  #-------------------------------------------------------------
  # VI tests
  #-------------------------------------------------------------

  TEST_VI_OP( 10, vor.vi, 0xff00ff00, 0xff00ff00, 0x0 );
  TEST_VI_OP( 11, vor.vi, 0xff00ff0f, 0xff00ff00, 0xf );
  TEST_VI_OP( 12, vor.vi, 0x0ff00fff, 0x0ff00fff, 0x0 );
  TEST_VI_OP( 13, vor.vi, 0x0ff00fff, 0x0ff00fff, 0xf );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
