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

  TEST_VV_OP( 2,  vmulhu.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vmulhu.vv, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 4,  vmulhu.vv, 0x0000000000000000, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VV_OP( 5,  vmulhu.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 6,  vmulhu.vv, 0x0000000000000000, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VV_OP( 7,  vmulhu.vv, 0x0000000000000001, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VV_OP( 8,  vmulhu.vv, 0xffffffffffff0000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VV_OP( 9,  vmulhu.vv, 0xe100000000000001, 0xf000000000000001, 0xf000000000000001 );
  TEST_VV_OP( 10, vmulhu.vv, 0xe100000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VV_OP( 11, vmulhu.vv, 0x0000000000000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vmulhu.vv, 0x00000000000007ff, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VV_OP( 13, vmulhu.vv, 0x00ffffffffffffff, 0x0fffffffffffffff, 0x0fffffffffffffff );

  TEST_VV_OP( 14, vmulhu.vv, 0x0000000000000000, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VV_OP( 15, vmulhu.vv, 0x0000000077ffffff, 0xf000000000000000, 0x000000007fffffff );
  TEST_VV_OP( 16, vmulhu.vv, 0xe100000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vmulhu.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 18, vmulhu.vx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 19, vmulhu.vx, 0x0000000000000000, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VX_OP( 20, vmulhu.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 21, vmulhu.vx, 0x0000000000000000, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VX_OP( 22, vmulhu.vx, 0x0000000000000001, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VX_OP( 23, vmulhu.vx, 0xffffffffffff0000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VX_OP( 24, vmulhu.vx, 0xe100000000000001, 0xf000000000000001, 0xf000000000000001 );
  TEST_VX_OP( 25, vmulhu.vx, 0xe100000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VX_OP( 26, vmulhu.vx, 0x0000000000000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VX_OP( 27, vmulhu.vx, 0x00000000000007ff, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VX_OP( 28, vmulhu.vx, 0x00ffffffffffffff, 0x0fffffffffffffff, 0x0fffffffffffffff );
  
  TEST_VX_OP( 29, vmulhu.vx, 0x0000000000000000, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VX_OP( 30, vmulhu.vx, 0x0000000077ffffff, 0xf000000000000000, 0x000000007fffffff );
  TEST_VX_OP( 31, vmulhu.vx, 0xe100000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
