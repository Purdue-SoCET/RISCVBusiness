# See LICENSE for license details.

#*****************************************************************************
# vwmacc.S
#-----------------------------------------------------------------------------
#
# Test vwmacc instructions.
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

  TEST_W_VV_OP_WITH_INIT( 2,  vwmacc.vv, 0x0000000000000000, 0x00000000, 0x00000000 );
  TEST_W_VV_OP_WITH_INIT( 3,  vwmacc.vv, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VV_OP_WITH_INIT( 4,  vwmacc.vv, 0x000000fffee00051, 0x000ffff7, 0x000ffff7 );

  TEST_W_VV_OP_WITH_INIT( 5,  vwmacc.vv, 0x0000000000000000, 0x00000000, 0xffffffff );
  TEST_W_VV_OP_WITH_INIT( 6,  vwmacc.vv, 0xffffffffffffffff, 0x00000001, 0xffffffff );
  TEST_W_VV_OP_WITH_INIT( 7,  vwmacc.vv, 0xffffffffffff0000, 0x00000002, 0xffff8000 );

  TEST_W_VV_OP_WITH_INIT( 8,  vwmacc.vv, 0x0000000040000000, 0xffff8000, 0xffff8000 );
  TEST_W_VV_OP_WITH_INIT( 9,  vwmacc.vv, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VV_OP_WITH_INIT( 10, vwmacc.vv, 0x0000000000000000, 0x00000001, 0x00000000 );

  TEST_W_VV_OP_WITH_INIT( 11, vwmacc.vv, 0xffffc00080000000, 0x80000000, 0x00007fff );
  TEST_W_VV_OP_WITH_INIT( 12, vwmacc.vv, 0xffffffffffff8001, 0xffffffff, 0x00007fff );
  TEST_W_VV_OP_WITH_INIT( 13, vwmacc.vv, 0x0000000000000001, 0xffffffff, 0xffffffff );

  TEST_W_VV_OP_WITH_INIT( 14, vwmacc.vv, 0x3fffffff00000001, 0x7fffffff, 0x7fffffff );
  TEST_W_VV_OP_WITH_INIT( 15, vwmacc.vv, 0x0000000000000000, 0x00000000, 0x7fffffff );
  TEST_W_VV_OP_WITH_INIT( 16, vwmacc.vv, 0x0000000000000000, 0x00000000, 0x00000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VX_OP_RV( 17, vwmacc.vx, 0x0000000000000000, 0x00000000, 0x00000000 );
  TEST_W_VX_OP_RV( 18, vwmacc.vx, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VX_OP_RV( 19, vwmacc.vx, 0x000000fffee00051, 0x000ffff7, 0x000ffff7 );

  TEST_W_VX_OP_RV( 20, vwmacc.vx, 0x0000000000000000, 0x00000000, 0xffffffff );
  TEST_W_VX_OP_RV( 21, vwmacc.vx, 0xffffffffffffffff, 0x00000001, 0xffffffff );
  TEST_W_VX_OP_RV( 22, vwmacc.vx, 0xffffffffffff0000, 0x00000002, 0xffff8000 );

  TEST_W_VX_OP_RV( 23, vwmacc.vx, 0x0000000040000000, 0xffff8000, 0xffff8000 );
  TEST_W_VX_OP_RV( 24, vwmacc.vx, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VX_OP_RV( 25, vwmacc.vx, 0x0000000000000000, 0x00000001, 0x00000000 );

  TEST_W_VX_OP_RV( 26, vwmacc.vx, 0xffffc00080000000, 0x80000000, 0x00007fff );
  TEST_W_VX_OP_RV( 27, vwmacc.vx, 0xffffffffffff8001, 0xffffffff, 0x00007fff );
  TEST_W_VX_OP_RV( 28, vwmacc.vx, 0x0000000000000001, 0xffffffff, 0xffffffff );
  
  TEST_W_VX_OP_RV( 29, vwmacc.vx, 0x3fffffff00000001, 0x7fffffff, 0x7fffffff );
  TEST_W_VX_OP_RV( 30, vwmacc.vx, 0x0000000000000000, 0x00000000, 0x7fffffff );
  TEST_W_VX_OP_RV( 31, vwmacc.vx, 0x0000000000000000, 0x00000000, 0x00000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
