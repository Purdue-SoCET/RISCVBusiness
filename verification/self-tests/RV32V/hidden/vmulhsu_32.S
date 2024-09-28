# See LICENSE for license details.

#*****************************************************************************
# vmulhsu.S
#-----------------------------------------------------------------------------
#
# Test vmulhsu instructions.
# TEST_VV(X)_OP( testnum, inst, result, val1, val2 )
#   val1: signed, val2: unsigned
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vmulhsu.vv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VV_OP( 3,  vmulhsu.vv, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VV_OP( 4,  vmulhsu.vv, 0x000000ff, 0x000ffff7, 0x000ffff7 );

  TEST_VV_OP( 5,  vmulhsu.vv, 0x00000000, 0x00000000, 0xffffffff );
  TEST_VV_OP( 6,  vmulhsu.vv, 0x00000000, 0x00000001, 0xffffffff );
  TEST_VV_OP( 7,  vmulhsu.vv, 0x00000001, 0x00000002, 0xffff8000 );

  TEST_VV_OP( 8,  vmulhsu.vv, 0xffff8000, 0xffff8000, 0xffff8000 );
  TEST_VV_OP( 9,  vmulhsu.vv, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VV_OP( 10, vmulhsu.vv, 0x00000000, 0x00000001, 0x00000000 );

  TEST_VV_OP( 11, vmulhsu.vv, 0xffffc000, 0x80000000, 0x00007fff );
  TEST_VV_OP( 12, vmulhsu.vv, 0xffffffff, 0xffffffff, 0x00007fff );
  TEST_VV_OP( 13, vmulhsu.vv, 0xffffffff, 0xffffffff, 0xffffffff );

  TEST_VV_OP( 14, vmulhsu.vv, 0x3fffffff, 0x7fffffff, 0x7fffffff );
  TEST_VV_OP( 15, vmulhsu.vv, 0x00000000, 0x00000000, 0x7fffffff );
  TEST_VV_OP( 16, vmulhsu.vv, 0x00000000, 0x00000000, 0x00000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vmulhsu.vx, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VX_OP( 18, vmulhsu.vx, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VX_OP( 19, vmulhsu.vx, 0x000000ff, 0x000ffff7, 0x000ffff7 );

  TEST_VX_OP( 20, vmulhsu.vx, 0x00000000, 0x00000000, 0xffffffff );
  TEST_VX_OP( 21, vmulhsu.vx, 0x00000000, 0x00000001, 0xffffffff );
  TEST_VX_OP( 22, vmulhsu.vx, 0x00000001, 0x00000002, 0xffff8000 );

  TEST_VX_OP( 23, vmulhsu.vx, 0xffff8000, 0xffff8000, 0xffff8000 );
  TEST_VX_OP( 24, vmulhsu.vx, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VX_OP( 25, vmulhsu.vx, 0x00000000, 0x00000001, 0x00000000 );

  TEST_VX_OP( 26, vmulhsu.vx, 0xffffc000, 0x80000000, 0x00007fff );
  TEST_VX_OP( 27, vmulhsu.vx, 0xffffffff, 0xffffffff, 0x00007fff );
  TEST_VX_OP( 28, vmulhsu.vx, 0xffffffff, 0xffffffff, 0xffffffff );
  
  TEST_VX_OP( 29, vmulhsu.vx, 0x3fffffff, 0x7fffffff, 0x7fffffff );
  TEST_VX_OP( 30, vmulhsu.vx, 0x00000000, 0x00000000, 0x7fffffff );
  TEST_VX_OP( 31, vmulhsu.vx, 0x00000000, 0x00000000, 0x00000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
