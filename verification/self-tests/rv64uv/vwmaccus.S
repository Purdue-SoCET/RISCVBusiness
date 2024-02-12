# See LICENSE for license details.

#*****************************************************************************
# vwmaccus.S
#-----------------------------------------------------------------------------
#
# Test vwmaccus instructions.
#  This test file regards the value in vd register as 0.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_W_VX_OP_RV( 2,  vwmaccus.vx, 0x0000000000000000, 0x00000000, 0x00000000 );
  TEST_W_VX_OP_RV( 3,  vwmaccus.vx, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VX_OP_RV( 4,  vwmaccus.vx, 0x000000fffee00051, 0x000ffff7, 0x000ffff7 );

  TEST_W_VX_OP_RV( 5,  vwmaccus.vx, 0x0000000000000000, 0x00000000, 0xffffffff );
  TEST_W_VX_OP_RV( 6,  vwmaccus.vx, 0xffffffffffffffff, 0x00000001, 0xffffffff );
  TEST_W_VX_OP_RV( 7,  vwmaccus.vx, 0xffffffffffff0000, 0x00000002, 0xffff8000 );

  TEST_W_VX_OP_RV( 8,  vwmaccus.vx, 0xffff800040000000, 0xffff8000, 0xffff8000 );
  TEST_W_VX_OP_RV( 9,  vwmaccus.vx, 0x0000000000000001, 0x00000001, 0x00000001 );
  TEST_W_VX_OP_RV( 10, vwmaccus.vx, 0x0000000000000000, 0x00000001, 0x00000000 );

  TEST_W_VX_OP_RV( 11, vwmaccus.vx, 0x00003fff80000000, 0x80000000, 0x00007fff );
  TEST_W_VX_OP_RV( 12, vwmaccus.vx, 0x00007ffeffff8001, 0xffffffff, 0x00007fff );
  TEST_W_VX_OP_RV( 13, vwmaccus.vx, 0xffffffff00000001, 0xffffffff, 0xffffffff );
  
  TEST_W_VX_OP_RV( 14, vwmaccus.vx, 0x3fffffff00000001, 0x7fffffff, 0x7fffffff );
  TEST_W_VX_OP_RV( 15, vwmaccus.vx, 0x0000000000000000, 0x00000000, 0x7fffffff );
  TEST_W_VX_OP_RV( 16, vwmaccus.vx, 0x0000000000000000, 0x00000000, 0x00000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
