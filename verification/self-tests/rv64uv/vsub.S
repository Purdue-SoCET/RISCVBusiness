# See LICENSE for license details.

#*****************************************************************************
# vsub.S
#-----------------------------------------------------------------------------
#
# Test vsub instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vsub.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vsub.vv, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 4,  vsub.vv, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );

  TEST_VV_OP( 5,  vsub.vv, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VV_OP( 6,  vsub.vv, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VV_OP( 7,  vsub.vv, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VV_OP( 8,  vsub.vv, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_VV_OP( 9,  vsub.vv, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VV_OP( 10, vsub.vv, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VV_OP( 11, vsub.vv, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vsub.vv, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VV_OP( 13, vsub.vv, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 14, vsub.vv, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VV_OP( 15, vsub.vv, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 16, vsub.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 17, vsub.vx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 18, vsub.vx, 0xfffffffffffffffc, 0x0000000000000003, 0x0000000000000007 );

  TEST_VX_OP( 19, vsub.vx, 0x0000000000008000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VX_OP( 20, vsub.vx, 0xffffffff80000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VX_OP( 21, vsub.vx, 0xffffffff80008000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VX_OP( 22, vsub.vx, 0xffffffffffff8001, 0x0000000000000000, 0x0000000000007fff );
  TEST_VX_OP( 23, vsub.vx, 0x000000007fffffff, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VX_OP( 24, vsub.vx, 0x000000007fff8000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VX_OP( 25, vsub.vx, 0xffffffff7fff8001, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VX_OP( 26, vsub.vx, 0x0000000080007fff, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VX_OP( 27, vsub.vx, 0x0000000000000001, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 28, vsub.vx, 0xfffffffffffffffe, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VX_OP( 29, vsub.vx, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );	
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
