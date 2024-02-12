# See LICuENSE for license details.

#*****************************************************************************
# vwmaccu.S
#-----------------------------------------------------------------------------
#
# Test vwmaccu instructions.
#  This test file regards the value in vd register as 0.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_W_VV_OP_WITH_INIT( 2,  vwmaccu.vv, 0x0000000000000000, 0x00000000, 0x00000000 );
  TEST_W_VV_OP_WITH_INIT( 3,  vwmaccu.vv, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VV_OP_WITH_INIT( 4,  vwmaccu.vv, 0x000000fffee00051, 0x000ffff7, 0x000ffff7 );

  TEST_W_VV_OP_WITH_INIT( 5,  vwmaccu.vv, 0x0000000000000000, 0x00000000, 0xffffffff );
  TEST_W_VV_OP_WITH_INIT( 6,  vwmaccu.vv, 0x00000000ffffffff, 0x00000001, 0xffffffff );
  TEST_W_VV_OP_WITH_INIT( 7,  vwmaccu.vv, 0x00000001ffff0000, 0x00000002, 0xffff8000 );

  TEST_W_VV_OP_WITH_INIT( 8,  vwmaccu.vv, 0xffff000040000000, 0xffff8000, 0xffff8000 );
  TEST_W_VV_OP_WITH_INIT( 9,  vwmaccu.vv, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VV_OP_WITH_INIT( 10, vwmaccu.vv, 0x0000000000000000, 0x00000001, 0x00000000 );

  TEST_W_VV_OP_WITH_INIT( 11, vwmaccu.vv, 0x00003fff80000000, 0x80000000, 0x00007fff );
  TEST_W_VV_OP_WITH_INIT( 12, vwmaccu.vv, 0x00007ffeffff8001, 0xffffffff, 0x00007fff );
  TEST_W_VV_OP_WITH_INIT( 13, vwmaccu.vv, 0xfffffffe00000001, 0xffffffff, 0xffffffff );

  TEST_W_VV_OP_WITH_INIT( 14, vwmaccu.vv, 0x3fffffff00000001, 0x7fffffff, 0x7fffffff );
  TEST_W_VV_OP_WITH_INIT( 15, vwmaccu.vv, 0x0000000000000000, 0x00000000, 0x7fffffff );
  TEST_W_VV_OP_WITH_INIT( 16, vwmaccu.vv, 0x0000000000000000, 0x00000000, 0x00000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VX_OP_RV( 17, vwmaccu.vx, 0x0000000000000000, 0x00000000, 0x00000000 );
  TEST_W_VX_OP_RV( 18, vwmaccu.vx, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VX_OP_RV( 19, vwmaccu.vx, 0x000000fffee00051, 0x000ffff7, 0x000ffff7 );

  TEST_W_VX_OP_RV( 20, vwmaccu.vx, 0x0000000000000000, 0x00000000, 0xffffffff );
  TEST_W_VX_OP_RV( 21, vwmaccu.vx, 0x00000000ffffffff, 0x00000001, 0xffffffff );
  TEST_W_VX_OP_RV( 22, vwmaccu.vx, 0x00000001ffff0000, 0x00000002, 0xffff8000 );

  TEST_W_VX_OP_RV( 23, vwmaccu.vx, 0xffff000040000000, 0xffff8000, 0xffff8000 );
  TEST_W_VX_OP_RV( 24, vwmaccu.vx, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VX_OP_RV( 25, vwmaccu.vx, 0x0000000000000000, 0x00000001, 0x00000000 );

  TEST_W_VX_OP_RV( 26, vwmaccu.vx, 0x00003fff80000000, 0x80000000, 0x00007fff );
  TEST_W_VX_OP_RV( 27, vwmaccu.vx, 0x00007ffeffff8001, 0xffffffff, 0x00007fff );
  TEST_W_VX_OP_RV( 28, vwmaccu.vx, 0xfffffffe00000001, 0xffffffff, 0xffffffff );

  TEST_W_VX_OP_RV( 29, vwmaccu.vx, 0x3fffffff00000001, 0x7fffffff, 0x7fffffff );
  TEST_W_VX_OP_RV( 30, vwmaccu.vx, 0x0000000000000000, 0x00000000, 0x7fffffff );
  TEST_W_VX_OP_RV( 31, vwmaccu.vx, 0x0000000000000000, 0x00000000, 0x00000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
