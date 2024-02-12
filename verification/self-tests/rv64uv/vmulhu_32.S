# See LICENSE for license details.

#*****************************************************************************
# vmulhu.S
#-----------------------------------------------------------------------------
#
# Test vmulhu instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vmulhu.vv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VV_OP( 3,  vmulhu.vv, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VV_OP( 4,  vmulhu.vv, 0x000000ff, 0x000ffff7, 0x000ffff7 );

  TEST_VV_OP( 5,  vmulhu.vv, 0x00000000, 0x00000000, 0xffffffff );
  TEST_VV_OP( 6,  vmulhu.vv, 0x00000000, 0x00000001, 0xffffffff );
  TEST_VV_OP( 7,  vmulhu.vv, 0x00000001, 0x00000002, 0xffff8000 );

  TEST_VV_OP( 8,  vmulhu.vv, 0xffff0000, 0xffff8000, 0xffff8000 );
  TEST_VV_OP( 9,  vmulhu.vv, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VV_OP( 10, vmulhu.vv, 0x00000000, 0x00000001, 0x00000000 );

  TEST_VV_OP( 11, vmulhu.vv, 0x00003fff, 0x80000000, 0x00007fff );
  TEST_VV_OP( 12, vmulhu.vv, 0x00007ffe, 0xffffffff, 0x00007fff );
  TEST_VV_OP( 13, vmulhu.vv, 0xfffffffe, 0xffffffff, 0xffffffff );

  TEST_VV_OP( 14, vmulhu.vv, 0x3fffffff, 0x7fffffff, 0x7fffffff );
  TEST_VV_OP( 15, vmulhu.vv, 0x00000000, 0x00000000, 0x7fffffff );
  TEST_VV_OP( 16, vmulhu.vv, 0x00000000, 0x00000000, 0x00000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vmulhu.vx, 0x00000000, 0x00000000, 0x00000000 );
  TEST_VX_OP( 18, vmulhu.vx, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VX_OP( 19, vmulhu.vx, 0x000000ff, 0x000ffff7, 0x000ffff7 );

  TEST_VX_OP( 20, vmulhu.vx, 0x00000000, 0x00000000, 0xffffffff );
  TEST_VX_OP( 21, vmulhu.vx, 0x00000000, 0x00000001, 0xffffffff );
  TEST_VX_OP( 22, vmulhu.vx, 0x00000001, 0x00000002, 0xffff8000 );

  TEST_VX_OP( 23, vmulhu.vx, 0xffff0000, 0xffff8000, 0xffff8000 );
  TEST_VX_OP( 24, vmulhu.vx, 0x00000000, 0x00000001, 0x00000001 );
  TEST_VX_OP( 25, vmulhu.vx, 0x00000000, 0x00000001, 0x00000000 );

  TEST_VX_OP( 26, vmulhu.vx, 0x00003fff, 0x80000000, 0x00007fff );
  TEST_VX_OP( 27, vmulhu.vx, 0x00007ffe, 0xffffffff, 0x00007fff );
  TEST_VX_OP( 28, vmulhu.vx, 0xfffffffe, 0xffffffff, 0xffffffff );
  
  TEST_VX_OP( 29, vmulhu.vx, 0x3fffffff, 0x7fffffff, 0x7fffffff );
  TEST_VX_OP( 30, vmulhu.vx, 0x00000000, 0x00000000, 0x7fffffff );
  TEST_VX_OP( 31, vmulhu.vx, 0x00000000, 0x00000000, 0x00000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
