# See LICENSE for license details.

#*****************************************************************************
# vext.S
#-----------------------------------------------------------------------------
#
# Test vext instructions.
# vsext.vf8, vzext.vf8 only support when VSEW >= 64
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vzext.vf2 Tests
  #-------------------------------------------------------------

  TEST_VZEXT2_OP( 2, 0x0000000000000000 );
  TEST_VZEXT2_OP( 3, 0x0000000000000001 );
  TEST_VZEXT2_OP( 4, 0x0000000800000008 );
  TEST_VZEXT2_OP( 5, 0x0000000f0000000f );
  TEST_VZEXT2_OP( 6, 0xffffffffffffffff );
	
  #-------------------------------------------------------------
  # vsext.vf2 Tests
  #-------------------------------------------------------------

  TEST_VSEXT2_OP( 7, 0x0000000000000000 );
  TEST_VSEXT2_OP( 8, 0x0000000000000001 );
  TEST_VSEXT2_OP( 9, 0x0000000800000008 );
  TEST_VSEXT2_OP( 10, 0x0000000f0000000f );
  TEST_VSEXT2_OP( 11, 0xffffffffffffffff );
	
  #-------------------------------------------------------------
  # vzext.vf4 Tests
  #-------------------------------------------------------------

  TEST_VZEXT4_OP( 12, 0x0000000000000000 );
  TEST_VZEXT4_OP( 13, 0x0000000000000001 );
  TEST_VZEXT4_OP( 14, 0x0000000800000008 );
  TEST_VZEXT4_OP( 15, 0x0000000f0000000f );
  TEST_VZEXT4_OP( 16, 0xffffffffffffffff );
	
  #-------------------------------------------------------------
  # vsext.vf4 Tests
  #-------------------------------------------------------------

  TEST_VSEXT4_OP( 17, 0x0000000000000000 );
  TEST_VSEXT4_OP( 18, 0x0000000000000001 );
  TEST_VSEXT4_OP( 19, 0x0000000800000008 );
  TEST_VSEXT4_OP( 20, 0x0000000f0000000f );
  TEST_VSEXT4_OP( 21, 0xffffffffffffffff );
	
  #-------------------------------------------------------------
  # vzext.vf8 Tests
  # Only support when SEW >= 64
  #-------------------------------------------------------------

#if __riscv_vsew >= 64

  TEST_VZEXT8_OP( 22, 0x0000000000000000 );
  TEST_VZEXT8_OP( 23, 0x0000000000000001 );
  TEST_VZEXT8_OP( 24, 0x0000000800000008 );
  TEST_VZEXT8_OP( 25, 0x0000000f0000000f );
  TEST_VZEXT8_OP( 26, 0xffffffffffffffff );
	
  #-------------------------------------------------------------
  # vsext.vf8 Tests
  # Only support when SEW >= 64
  #-------------------------------------------------------------
  TEST_VSEXT8_OP( 27, 0x0000000000000000 );
  TEST_VSEXT8_OP( 28, 0x0000000000000001 );
  TEST_VSEXT8_OP( 29, 0x0000000800000008 );
  TEST_VSEXT8_OP( 30, 0x0000000f0000000f );
  TEST_VSEXT8_OP( 31, 0xffffffffffffffff );
	
#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
