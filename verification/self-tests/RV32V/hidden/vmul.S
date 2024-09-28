# See LICENSE for license details.

#*****************************************************************************
# vmul.S
#-----------------------------------------------------------------------------
#
# Test vmul instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vmul.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP( 3,  vmul.vv, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP( 4,  vmul.vv, 0x000000fffee00051, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VV_OP( 5,  vmul.vv, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP( 6,  vmul.vv, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VV_OP( 7,  vmul.vv, 0xffffffffffff0000, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VV_OP( 8,  vmul.vv, 0x0000000040000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VV_OP( 9,  vmul.vv, 0xe000000000000001, 0xf000000000000001, 0xf000000000000001 );
  TEST_VV_OP( 10, vmul.vv, 0xf000000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VV_OP( 11, vmul.vv, 0x00003fff80000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VV_OP( 12, vmul.vv, 0xefffffffffff8001, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VV_OP( 13, vmul.vv, 0xe000000000000001, 0x0fffffffffffffff, 0x0fffffffffffffff );

  TEST_VV_OP( 14, vmul.vv, 0x3fffffff00000001, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VV_OP( 15, vmul.vv, 0x1000000000000000, 0xf000000000000000, 0x000000007fffffff );
  TEST_VV_OP( 16, vmul.vv, 0x0000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 17, vmul.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 18, vmul.vx, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 19, vmul.vx, 0x000000fffee00051, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VX_OP( 20, vmul.vx, 0x0000000000000000, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 21, vmul.vx, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VX_OP( 22, vmul.vx, 0xffffffffffff0000, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VX_OP( 23, vmul.vx, 0x0000000040000000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VX_OP( 24, vmul.vx, 0xe000000000000001, 0xf000000000000001, 0xf000000000000001 );
  TEST_VX_OP( 25, vmul.vx, 0xf000000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VX_OP( 26, vmul.vx, 0x00003fff80000000, 0x0000000080000000, 0x0000000000007fff );
  TEST_VX_OP( 27, vmul.vx, 0xefffffffffff8001, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VX_OP( 28, vmul.vx, 0xe000000000000001, 0x0fffffffffffffff, 0x0fffffffffffffff );
  
  TEST_VX_OP( 29, vmul.vx, 0x3fffffff00000001, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VX_OP( 30, vmul.vx, 0x1000000000000000, 0xf000000000000000, 0x000000007fffffff );
  TEST_VX_OP( 31, vmul.vx, 0x0000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
