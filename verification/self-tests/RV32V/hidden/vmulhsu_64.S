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

  TEST_VV_OP( 2,  vmulhsu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vmulhsu.vv, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 4,  vmulhsu.vv, 0x0000000000000000, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VV_OP( 5,  vmulhsu.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 6,  vmulhsu.vv, 0x0000000000000000, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VV_OP( 7,  vmulhsu.vv, 0x0000000000000001, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VV_OP( 8,  vmulhsu.vv, 0xffffffffffff8000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VV_OP( 9,  vmulhsu.vv, 0xf100000000000000, 0xf000000000000001, 0xf000000000000001 );
  TEST_VV_OP( 10, vmulhsu.vv, 0xf100000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VV_OP( 11, vmulhsu.vv, 0x0000000000000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vmulhsu.vv, 0x00000000000007ff, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VV_OP( 13, vmulhsu.vv, 0x00ffffffffffffff, 0x0fffffffffffffff, 0x0fffffffffffffff );

  TEST_VV_OP( 14, vmulhsu.vv, 0x0000000000000000, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VV_OP( 15, vmulhsu.vv, 0xfffffffff8000000, 0xf000000000000000, 0x000000007fffffff );
  TEST_VV_OP( 16, vmulhsu.vv, 0xf100000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vmulhsu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 18, vmulhsu.vx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 19, vmulhsu.vx, 0x0000000000000000, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VX_OP( 20, vmulhsu.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 21, vmulhsu.vx, 0x0000000000000000, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VX_OP( 22, vmulhsu.vx, 0x0000000000000001, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VX_OP( 23, vmulhsu.vx, 0xffffffffffff8000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VX_OP( 24, vmulhsu.vx, 0xf100000000000000, 0xf000000000000001, 0xf000000000000001 );
  TEST_VX_OP( 25, vmulhsu.vx, 0xf100000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VX_OP( 26, vmulhsu.vx, 0x0000000000000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VX_OP( 27, vmulhsu.vx, 0x00000000000007ff, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VX_OP( 28, vmulhsu.vx, 0x00ffffffffffffff, 0x0fffffffffffffff, 0x0fffffffffffffff );
  
  TEST_VX_OP( 29, vmulhsu.vx, 0x0000000000000000, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VX_OP( 30, vmulhsu.vx, 0xfffffffff8000000, 0xf000000000000000, 0x000000007fffffff );
  TEST_VX_OP( 31, vmulhsu.vx, 0xf100000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
