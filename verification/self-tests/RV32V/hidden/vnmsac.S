# See LICENSE for license details.

#*****************************************************************************
# vnmsac.S
#-----------------------------------------------------------------------------
#
# Test vnmsac instructions.
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

  TEST_VV_OP_WITH_INIT( 2,  vnmsac.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP_WITH_INIT( 3,  vnmsac.vv, 0xffffffffffffffff, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP_WITH_INIT( 4,  vnmsac.vv, 0xffffff00011fffaf, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VV_OP_WITH_INIT( 5,  vnmsac.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP_WITH_INIT( 6,  vnmsac.vv, 0x0000000000000001, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VV_OP_WITH_INIT( 7,  vnmsac.vv, 0x0000000000010000, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VV_OP_WITH_INIT( 8,  vnmsac.vv, 0xffffffffc0000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VV_OP_WITH_INIT( 9,  vnmsac.vv, 0x1fffffffffffffff, 0xf000000000000001, 0xf000000000000001 );
  TEST_VV_OP_WITH_INIT( 10, vnmsac.vv, 0x1000000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VV_OP_WITH_INIT( 11, vnmsac.vv, 0xffffc00080000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VV_OP_WITH_INIT( 12, vnmsac.vv, 0x1000000000007fff, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VV_OP_WITH_INIT( 13, vnmsac.vv, 0x1fffffffffffffff, 0x0fffffffffffffff, 0x0fffffffffffffff );

  TEST_VV_OP_WITH_INIT( 14, vnmsac.vv, 0xc0000000ffffffff, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VV_OP_WITH_INIT( 15, vnmsac.vv, 0xf000000000000000, 0xf000000000000000, 0x000000007fffffff );
  TEST_VV_OP_WITH_INIT( 16, vnmsac.vv, 0x0000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP_RV( 17, vnmsac.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP_RV( 18, vnmsac.vx, 0xffffffffffffffff, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP_RV( 19, vnmsac.vx, 0xffffff00011fffaf, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VX_OP_RV( 20, vnmsac.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP_RV( 21, vnmsac.vx, 0x0000000000000001, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VX_OP_RV( 22, vnmsac.vx, 0x0000000000010000, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VX_OP_RV( 23, vnmsac.vx, 0xffffffffc0000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VX_OP_RV( 24, vnmsac.vx, 0x1fffffffffffffff, 0xf000000000000001, 0xf000000000000001 );
  TEST_VX_OP_RV( 25, vnmsac.vx, 0x1000000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VX_OP_RV( 26, vnmsac.vx, 0xffffc00080000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VX_OP_RV( 27, vnmsac.vx, 0x1000000000007fff, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VX_OP_RV( 28, vnmsac.vx, 0x1fffffffffffffff, 0x0fffffffffffffff, 0x0fffffffffffffff );
  
  TEST_VX_OP_RV( 29, vnmsac.vx, 0xc0000000ffffffff, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VX_OP_RV( 30, vnmsac.vx, 0xf000000000000000, 0xf000000000000000, 0x000000007fffffff );
  TEST_VX_OP_RV( 31, vnmsac.vx, 0x0000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END