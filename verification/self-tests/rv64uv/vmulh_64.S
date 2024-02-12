# See LICENSE for license details.

#*****************************************************************************
# vmulh.S
#-----------------------------------------------------------------------------
#
# Test vmulh instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vmulh.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vmulh.vv, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 4,  vmulh.vv, 0x0000000000000000, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VV_OP( 5,  vmulh.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 6,  vmulh.vv, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VV_OP( 7,  vmulh.vv, 0xffffffffffffffff, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VV_OP( 8,  vmulh.vv, 0x0000000000000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VV_OP( 9,  vmulh.vv, 0x00ffffffffffffff, 0xf000000000000001, 0xf000000000000001 );
  TEST_VV_OP( 10, vmulh.vv, 0x00ffffffffffffff, 0xf000000000000001, 0xf000000000000000 );

  TEST_VV_OP( 11, vmulh.vv, 0x0000000000000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vmulh.vv, 0x00000000000007ff, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VV_OP( 13, vmulh.vv, 0x00ffffffffffffff, 0x0fffffffffffffff, 0x0fffffffffffffff );

  TEST_VV_OP( 14, vmulh.vv, 0x0000000000000000, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VV_OP( 15, vmulh.vv, 0xfffffffff8000000, 0xf000000000000000, 0x000000007fffffff );
  TEST_VV_OP( 16, vmulh.vv, 0x0100000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vmulh.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 18, vmulh.vx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 19, vmulh.vx, 0x0000000000000000, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VX_OP( 20, vmulh.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 21, vmulh.vx, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VX_OP( 22, vmulh.vx, 0xffffffffffffffff, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VX_OP( 23, vmulh.vx, 0x0000000000000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VX_OP( 24, vmulh.vx, 0x00ffffffffffffff, 0xf000000000000001, 0xf000000000000001 );
  TEST_VX_OP( 25, vmulh.vx, 0x00ffffffffffffff, 0xf000000000000001, 0xf000000000000000 );

  TEST_VX_OP( 26, vmulh.vx, 0x0000000000000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VX_OP( 27, vmulh.vx, 0x00000000000007ff, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VX_OP( 28, vmulh.vx, 0x00ffffffffffffff, 0x0fffffffffffffff, 0x0fffffffffffffff );
  
  TEST_VX_OP( 29, vmulh.vx, 0x0000000000000000, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VX_OP( 30, vmulh.vx, 0xfffffffff8000000, 0xf000000000000000, 0x000000007fffffff );
  TEST_VX_OP( 31, vmulh.vx, 0x0100000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
