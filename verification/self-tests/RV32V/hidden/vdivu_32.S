# See LICENSE for license details.

#*****************************************************************************
# vdivu.S
#-----------------------------------------------------------------------------
#
# Test vdivu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vdivu.vv, 0x00000003, 0x00000014, 0x00000006 );
  TEST_VV_OP( 3,  vdivu.vv, 0x00000000, 0x00000014, 0xfffffffa );
  TEST_VV_OP( 4,  vdivu.vv, 0x2aaaaaa7, 0xffffffec, 0x00000006 );
  TEST_VV_OP( 5,  vdivu.vv, 0x00000000, 0xffffffec, 0xfffffffa );

  TEST_VV_OP( 6,  vdivu.vv, 0x00000001, 0x00000001, 0x00000001 );
  TEST_VV_OP( 7,  vdivu.vv, 0x00000000, 0x00000001, 0xffffffff );

  TEST_VV_OP( 8,  vdivu.vv, 0x00000000, 0x00000000, 0x00000001 );
  TEST_VV_OP( 9,  vdivu.vv, 0x00000000, 0x00000000, 0xffffffff );
  TEST_VV_OP( 10, vdivu.vv, 0x00000000, 0x00000000, 0xfffe1dc0 );

  TEST_VV_OP( 11, vdivu.vv, 0xffffffff, 0xffffffff, 0x00000001 );
  TEST_VV_OP( 12, vdivu.vv, 0x00000001, 0xffffffff, 0xffffffff );

  TEST_VV_OP( 13, vdivu.vv, -1, 0x00000014, 0x00000000 ); #  20 / 0 = ERROR (Should be defined to specific result)
  TEST_VV_OP( 14, vdivu.vv, -1, 0xffffffec, 0x00000000 ); # -20 / 0 = ERROR (Should be defined to specific result)
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 15, vdivu.vx, 0x00000003, 0x00000014, 0x00000006 );
  TEST_VX_OP( 16, vdivu.vx, 0x00000000, 0x00000014, 0xfffffffa );
  TEST_VX_OP( 17, vdivu.vx, 0x2aaaaaa7, 0xffffffec, 0x00000006 );
  TEST_VX_OP( 18, vdivu.vx, 0x00000000, 0xffffffec, 0xfffffffa );

  TEST_VX_OP( 19, vdivu.vx, 0x00000001, 0x00000001, 0x00000001 );
  TEST_VX_OP( 20, vdivu.vx, 0x00000000, 0x00000001, 0xffffffff );

  TEST_VX_OP( 21, vdivu.vx, 0x00000000, 0x00000000, 0x00000001 );
  TEST_VX_OP( 22, vdivu.vx, 0x00000000, 0x00000000, 0xffffffff );
  TEST_VX_OP( 23, vdivu.vx, 0x00000000, 0x00000000, 0xfffe1dc0 );

  TEST_VX_OP( 24, vdivu.vx, 0xffffffff, 0xffffffff, 0x00000001 );
  TEST_VX_OP( 25, vdivu.vx, 0x00000001, 0xffffffff, 0xffffffff );

  TEST_VX_OP( 26, vdivu.vx, -1, 0x00000014, 0x00000000 ); #  20 / 0 = ERROR (Should be defined to specific result)
  TEST_VX_OP( 27, vdivu.vx, -1, 0xffffffec, 0x00000000 ); # -20 / 0 = ERROR (Should be defined to specific result)
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
