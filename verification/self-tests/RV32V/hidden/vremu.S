# See LICENSE for license details.

#*****************************************************************************
# vremu.S
#-----------------------------------------------------------------------------
#
# Test vremu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vremu.vv, 0x0000000000000002, 0x0000000000000014, 0x0000000000000006 ); #  20 %  6
  TEST_VV_OP( 3,  vremu.vv, 0x0000000000000014, 0x0000000000000014, 0xfffffffffffffffa ); #  20 % -6
  TEST_VV_OP( 4,  vremu.vv, 0x0000000000000002, 0xffffffffffffffec, 0x0000000000000006 ); # -20 %  6
  TEST_VV_OP( 5,  vremu.vv, 0xffffffffffffffec, 0xffffffffffffffec, 0xfffffffffffffffa ); # -20 % -6

  TEST_VV_OP( 6,  vremu.vv, 0x0000000000000000, 0x8000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 7,  vremu.vv, 0x8000000000000001, 0x8000000000000001, 0xffffffffffffffff );

  TEST_VV_OP( 8,  vremu.vv, 0x0000000000000000, 0x8000000000000000, 0x0000000000000001 );
  TEST_VV_OP( 9,  vremu.vv, 0x8000000000000000, 0x8000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 10, vremu.vv, 0x8000000000000000, 0x8000000000000000, 0xfffffffffffe1dc0 );

  TEST_VV_OP( 11, vremu.vv, 0x0000000000000014, 0x0000000000000014, 0x0000000000000000 ); #  20 % 0 = ERROR (Should be defined to specific result)
  TEST_VV_OP( 12, vremu.vv, 0xffffffffffffffec, 0xffffffffffffffec, 0x0000000000000000 ); # -20 % 0 = ERROR (Should be defined to specific result)
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 13, vremu.vx, 0x0000000000000002, 0x0000000000000014, 0x0000000000000006 ); #  20 %  6
  TEST_VX_OP( 14, vremu.vx, 0x0000000000000014, 0x0000000000000014, 0xfffffffffffffffa ); #  20 % -6
  TEST_VX_OP( 15, vremu.vx, 0x0000000000000002, 0xffffffffffffffec, 0x0000000000000006 ); # -20 %  6
  TEST_VX_OP( 16, vremu.vx, 0xffffffffffffffec, 0xffffffffffffffec, 0xfffffffffffffffa ); # -20 % -6

  TEST_VX_OP( 17, vremu.vx, 0x0000000000000000, 0x8000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 18, vremu.vx, 0x8000000000000001, 0x8000000000000001, 0xffffffffffffffff );

  TEST_VX_OP( 19, vremu.vx, 0x0000000000000000, 0x8000000000000000, 0x0000000000000001 );
  TEST_VX_OP( 20, vremu.vx, 0x8000000000000000, 0x8000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 21, vremu.vx, 0x8000000000000000, 0x8000000000000000, 0xfffffffffffe1dc0 );

  TEST_VX_OP( 22, vremu.vx, 0x0000000000000014, 0x0000000000000014, 0x0000000000000000 ); #  20 % 0 = ERROR (Should be defined to specific result)
  TEST_VX_OP( 23, vremu.vx, 0xffffffffffffffec, 0xffffffffffffffec, 0x0000000000000000 ); # -20 % 0 = ERROR (Should be defined to specific result)
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
