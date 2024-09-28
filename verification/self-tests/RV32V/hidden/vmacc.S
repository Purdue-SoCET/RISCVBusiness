# See LICENSE for license details.

#*****************************************************************************
# vmacc.S
#-----------------------------------------------------------------------------
#
# Test vmacc instructions.
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

  TEST_VV_OP_WITH_INIT( 2,  vmacc.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP_WITH_INIT( 3,  vmacc.vv, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP_WITH_INIT( 4,  vmacc.vv, 0x000000fffee00051, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VV_OP_WITH_INIT( 5,  vmacc.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP_WITH_INIT( 6,  vmacc.vv, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VV_OP_WITH_INIT( 7,  vmacc.vv, 0xffffffffffff0000, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VV_OP_WITH_INIT( 8,  vmacc.vv, 0x0000000040000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VV_OP_WITH_INIT( 9,  vmacc.vv, 0xe000000000000001, 0xf000000000000001, 0xf000000000000001 );
  TEST_VV_OP_WITH_INIT( 10, vmacc.vv, 0xf000000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VV_OP_WITH_INIT( 11, vmacc.vv, 0x00003fff80000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VV_OP_WITH_INIT( 12, vmacc.vv, 0xefffffffffff8001, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VV_OP_WITH_INIT( 13, vmacc.vv, 0xe000000000000001, 0x0fffffffffffffff, 0x0fffffffffffffff );

  TEST_VV_OP_WITH_INIT( 14, vmacc.vv, 0x3fffffff00000001, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VV_OP_WITH_INIT( 15, vmacc.vv, 0x1000000000000000, 0xf000000000000000, 0x000000007fffffff );
  TEST_VV_OP_WITH_INIT( 16, vmacc.vv, 0x0000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP_RV( 17, vmacc.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP_RV( 18, vmacc.vx, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP_RV( 19, vmacc.vx, 0x000000fffee00051, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VX_OP_RV( 20, vmacc.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP_RV( 21, vmacc.vx, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VX_OP_RV( 22, vmacc.vx, 0xffffffffffff0000, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VX_OP_RV( 23, vmacc.vx, 0x0000000040000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VX_OP_RV( 24, vmacc.vx, 0xe000000000000001, 0xf000000000000001, 0xf000000000000001 );
  TEST_VX_OP_RV( 25, vmacc.vx, 0xf000000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VX_OP_RV( 26, vmacc.vx, 0x00003fff80000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VX_OP_RV( 27, vmacc.vx, 0xefffffffffff8001, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VX_OP_RV( 28, vmacc.vx, 0xe000000000000001, 0x0fffffffffffffff, 0x0fffffffffffffff );
  
  TEST_VX_OP_RV( 29, vmacc.vx, 0x3fffffff00000001, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VX_OP_RV( 30, vmacc.vx, 0x1000000000000000, 0xf000000000000000, 0x000000007fffffff );
  TEST_VX_OP_RV( 31, vmacc.vx, 0x0000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
