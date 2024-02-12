# See LICENSE for license details.

#*****************************************************************************
# vrsub.S
#-----------------------------------------------------------------------------
#
# Test vrsub instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 2,  vrsub.vx, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000 );
  TEST_VX_OP( 3,  vrsub.vx, 0x0000000000000000, 0x0000000000000001, 0x0000000000000001 );
  TEST_VX_OP( 4,  vrsub.vx, 0x0000000000000004, 0x0000000000000003, 0x0000000000000007 );

  TEST_VX_OP( 5,  vrsub.vx, 0xffffffffffff8000, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_VX_OP( 6,  vrsub.vx, 0x0000000080000000, 0xffffffff80000000, 0x0000000000000000 );
  TEST_VX_OP( 7,  vrsub.vx, 0x000000007FFF8000, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_VX_OP( 8,  vrsub.vx, 0x0000000000007fff, 0x0000000000000000, 0x0000000000007fff );
  TEST_VX_OP( 9,  vrsub.vx, 0xFFFFFFFF80000001, 0x000000007fffffff, 0x0000000000000000 );
  TEST_VX_OP( 10, vrsub.vx, 0xFFFFFFFF80008000, 0x000000007fffffff, 0x0000000000007fff );

  TEST_VX_OP( 11, vrsub.vx, 0x0000000080007FFF, 0xffffffff80000000, 0x0000000000007fff );
  TEST_VX_OP( 12, vrsub.vx, 0xFFFFFFFF7FFF8001, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_VX_OP( 13, vrsub.vx, 0xffffffffffffffff, 0x0000000000000000, 0xffffffffffffffff );
  TEST_VX_OP( 14, vrsub.vx, 0x0000000000000002, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_VX_OP( 15, vrsub.vx, 0x0000000000000000, 0xffffffffffffffff, 0xffffffffffffffff );
	
  #-------------------------------------------------------------
  # VI Tests
  #-------------------------------------------------------------

  TEST_VI_OP( 16, vrsub.vi, 0x0000000000000000, 0x0000000000000000, 0x0 );
  TEST_VI_OP( 17, vrsub.vi, 0x0000000000000000, 0x0000000000000001, 0x1 );
  TEST_VI_OP( 18, vrsub.vi, 0x0000000000000004, 0x0000000000000003, 0x7 );

  TEST_VI_OP( 19, vrsub.vi, 0x0000000000000008, 0x0000000000000000, 0x8 );
  TEST_VI_OP( 20, vrsub.vi, 0x0000000080000000, 0xffffffff80000000, 0x0 );
  TEST_VI_OP( 21, vrsub.vi, 0x0000000080000008, 0xffffffff80000000, 0x8 );

  TEST_VI_OP( 22, vrsub.vi, 0x0000000000000007, 0x0000000000000000, 0x7 );
  TEST_VI_OP( 23, vrsub.vi, 0xFFFFFFFF80000001, 0x000000007fffffff, 0x0 );
  TEST_VI_OP( 24, vrsub.vi, 0xFFFFFFFF80000008, 0x000000007fffffff, 0x7 );

  TEST_VI_OP( 25, vrsub.vi, 0x0000000080000007, 0xffffffff80000000, 0x7 );
  TEST_VI_OP( 26, vrsub.vi, 0xFFFFFFFF80000009, 0x000000007fffffff, 0x8 );

  TEST_VI_OP( 27, vrsub.vi, 0xffffffffffffffff, 0x0000000000000000, 0x1f );
  TEST_VI_OP( 28, vrsub.vi, 0x0000000000000002, 0xffffffffffffffff, 0x1 );
  TEST_VI_OP( 29, vrsub.vi, 0x0000000000000000, 0xffffffffffffffff, 0x1f );
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
