# See LICENSE for license details.

#*****************************************************************************
# vmdd.S
#-----------------------------------------------------------------------------
#
# Test vmadd instructions.
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

  TEST_VV_OP_WITH_INIT( 2,  vmadd.vv, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VV_OP_WITH_INIT( 3,  vmadd.vv, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 );
  TEST_VV_OP_WITH_INIT( 4,  vmadd.vv, 0x00000000000ffff7, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VV_OP_WITH_INIT( 5,  vmadd.vv, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VV_OP_WITH_INIT( 6,  vmadd.vv, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VV_OP_WITH_INIT( 7,  vmadd.vv, 0xffffffffffff8000, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VV_OP_WITH_INIT( 8,  vmadd.vv, 0xffffffffffff8000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VV_OP_WITH_INIT( 9,  vmadd.vv, 0xf000000000000001, 0xf000000000000001, 0xf000000000000001 );
  TEST_VV_OP_WITH_INIT( 10, vmadd.vv, 0xf000000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VV_OP_WITH_INIT( 11, vmadd.vv, 0x0000000000007fff, 0x0000000080000000, 0x0000000000007fff );
  TEST_VV_OP_WITH_INIT( 12, vmadd.vv, 0x0000000000007fff, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VV_OP_WITH_INIT( 13, vmadd.vv, 0x0fffffffffffffff, 0x0fffffffffffffff, 0x0fffffffffffffff );

  TEST_VV_OP_WITH_INIT( 14, vmadd.vv, 0x000000007fffffff, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VV_OP_WITH_INIT( 15, vmadd.vv, 0x000000007fffffff, 0xf000000000000000, 0x000000007fffffff );
  TEST_VV_OP_WITH_INIT( 16, vmadd.vv, 0xf000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP_RV( 17, vmadd.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP_RV( 18, vmadd.vx, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP_RV( 19, vmadd.vx, 0x00000000000ffff7, 0x00000000000ffff7, 0x00000000000ffff7 );

  TEST_VX_OP_RV( 20, vmadd.vx, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP_RV( 21, vmadd.vx, 0xffffffffffffffff, 0x0000000000000001, 0xffffffffffffffff );
  TEST_VX_OP_RV( 22, vmadd.vx, 0xffffffffffff8000, 0x0000000000000002, 0xffffffffffff8000 );

  TEST_VX_OP_RV( 23, vmadd.vx, 0xffffffffffff8000, 0xffffffffffff8000, 0xffffffffffff8000 );
  TEST_VX_OP_RV( 24, vmadd.vx, 0xf000000000000001, 0xf000000000000001, 0xf000000000000001 );
  TEST_VX_OP_RV( 25, vmadd.vx, 0xf000000000000000, 0xf000000000000001, 0xf000000000000000 );

  TEST_VX_OP_RV( 26, vmadd.vx, 0x0000000000007fff, 0x0000000080000000, 0x0000000000007fff );
  TEST_VX_OP_RV( 27, vmadd.vx, 0x0000000000007fff, 0x0fffffffffffffff, 0x0000000000007fff );
  TEST_VX_OP_RV( 28, vmadd.vx, 0x0fffffffffffffff, 0x0fffffffffffffff, 0x0fffffffffffffff );
  
  TEST_VX_OP_RV( 29, vmadd.vx, 0x000000007fffffff, 0x000000007fffffff, 0x000000007fffffff );
  TEST_VX_OP_RV( 30, vmadd.vx, 0x000000007fffffff, 0xf000000000000000, 0x000000007fffffff );
  TEST_VX_OP_RV( 31, vmadd.vx, 0xf000000000000000, 0xf000000000000000, 0xf000000000000000 );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
