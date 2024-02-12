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

  TEST_VV_OP( 2,  vdivu.vv, 0x0000000000000003, 0x0000000000000014, 0x0000000000000006 );
  TEST_VV_OP( 3,  vdivu.vv, 0x0000000000000000, 0x0000000000000014, 0xfffffffffffffffa );
  TEST_VV_OP( 4,  vdivu.vv, 0x2aaaaaaaaaaaaaa7, 0xffffffffffffffec, 0x0000000000000006 );
  TEST_VV_OP( 5,  vdivu.vv, 0x0000000000000000, 0xffffffffffffffec, 0xfffffffffffffffa );

  TEST_VV_OP( 6,  vdivu.vv, 0x8000000000000001, 0x8000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 7,  vdivu.vv, 0x0000000000000000, 0x8000000000000001, 0xffffffffffffffff );

  TEST_VV_OP( 8,  vdivu.vv, 0x8000000000000000, 0x8000000000000000, 0x0000000000000001 );
  TEST_VV_OP( 9,  vdivu.vv, 0x0000000000000000, 0x8000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 10, vdivu.vv, 0x0000000000000000, 0x8000000000000000, 0xfffffffffffe1dc0 );

  TEST_VV_OP( 11, vdivu.vv, 0x0fffffffffffffff, 0x0fffffffffffffff, 0x0000000000000001 );
  TEST_VV_OP( 12, vdivu.vv, 0x0000000000000000, 0x0fffffffffffffff, 0xffffffffffffffff );

  TEST_VV_OP( 13, vdivu.vv, -1, 0x0000000000000014, 0x0000000000000000 ); #  20 / 0 = ERROR (Should be defined to specific result)
  TEST_VV_OP( 14, vdivu.vv, -1, 0xffffffffffffffec, 0x0000000000000000 ); # -20 / 0 = ERROR (Should be defined to specific result)
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 15, vdivu.vx, 0x0000000000000003, 0x0000000000000014, 0x0000000000000006 );
  TEST_VX_OP( 16, vdivu.vx, 0x0000000000000000, 0x0000000000000014, 0xfffffffffffffffa );
  TEST_VX_OP( 17, vdivu.vx, 0x2aaaaaaaaaaaaaa7, 0xffffffffffffffec, 0x0000000000000006 );
  TEST_VX_OP( 18, vdivu.vx, 0x0000000000000000, 0xffffffffffffffec, 0xfffffffffffffffa );

  TEST_VX_OP( 19, vdivu.vx, 0x8000000000000001, 0x8000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 20, vdivu.vx, 0x0000000000000000, 0x8000000000000001, 0xffffffffffffffff );

  TEST_VX_OP( 21, vdivu.vx, 0x8000000000000000, 0x8000000000000000, 0x0000000000000001 );
  TEST_VX_OP( 22, vdivu.vx, 0x0000000000000000, 0x8000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 23, vdivu.vx, 0x0000000000000000, 0x8000000000000000, 0xfffffffffffe1dc0 );

  TEST_VX_OP( 24, vdivu.vx, 0x0fffffffffffffff, 0x0fffffffffffffff, 0x0000000000000001 );
  TEST_VX_OP( 25, vdivu.vx, 0x0000000000000000, 0x0fffffffffffffff, 0xffffffffffffffff );

  TEST_VX_OP( 26, vdivu.vx, -1, 0x0000000000000014, 0x0000000000000000 ); #  20 / 0 = ERROR (Should be defined to specific result)
  TEST_VX_OP( 27, vdivu.vx, -1, 0xffffffffffffffec, 0x0000000000000000 ); # -20 / 0 = ERROR (Should be defined to specific result)
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
