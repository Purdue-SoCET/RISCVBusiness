# See LICENSE for license details.

#*****************************************************************************
# vrem.S
#-----------------------------------------------------------------------------
#
# Test vrem instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vrem.vv, 0x0000000000000002, 0x0000000000000014, 0x0000000000000006 ); #  20 %  6
  TEST_VV_OP( 3,  vrem.vv, 0x0000000000000002, 0x0000000000000014, 0xfffffffffffffffa ); #  20 % -6
  TEST_VV_OP( 4,  vrem.vv, 0xfffffffffffffffe, 0xffffffffffffffec, 0x0000000000000006 ); # -20 %  6
  TEST_VV_OP( 5,  vrem.vv, 0xfffffffffffffffe, 0xffffffffffffffec, 0xfffffffffffffffa ); # -20 % -6

  TEST_VV_OP( 6,  vrem.vv, 0x0000000000000000, 0x8000000000000001, 0x0000000000000001 ); # (INT64_MIN + 1) %  1
  TEST_VV_OP( 7,  vrem.vv, 0x0000000000000000, 0x8000000000000001, 0xffffffffffffffff ); # (INT64_MIN + 1) % -1

  TEST_VV_OP( 8,  vrem.vv, 0x0000000000000000, 0x8000000000000000, 0x0000000000000001 ); # INT64_MIN % 1
#if __riscv_vsew == 32 
  TEST_VV_OP( 9,  vrem.vv, 0x8000000000000000, 0x8000000000000000, 0xffffffffffffffff ); # INT64_MIN % -1 = ERROR (Should be defined to specific result)
#endif

#if __riscv_vsew == 64
  TEST_VV_OP( 26,  vrem.vv, 0x0000000000000000, 0x8000000000000000, 0xffffffffffffffff ); 
#endif

  TEST_VV_OP( 10, vrem.vv, 0x0000000000000000, 0x0fffffffffffffff, 0x0000000000000001 ); # INT64_MAX %  1
  TEST_VV_OP( 11, vrem.vv, 0x0000000000000000, 0x0fffffffffffffff, 0xffffffffffffffff ); # INT64_MAX % -1

  TEST_VV_OP( 12, vrem.vv, 0x0000000000000014, 0x0000000000000014, 0x0000000000000000 ); #  20 % 0 = ERROR (Should be defined to specific result)
  TEST_VV_OP( 13, vrem.vv, 0xffffffffffffffec, 0xffffffffffffffec, 0x0000000000000000 ); # -20 % 0 = ERROR (Should be defined to specific result)
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 14, vrem.vx, 0x0000000000000002, 0x0000000000000014, 0x0000000000000006 ); #  20 %  6
  TEST_VX_OP( 15, vrem.vx, 0x0000000000000002, 0x0000000000000014, 0xfffffffffffffffa ); #  20 % -6
  TEST_VX_OP( 16, vrem.vx, 0xfffffffffffffffe, 0xffffffffffffffec, 0x0000000000000006 ); # -20 %  6
  TEST_VX_OP( 17, vrem.vx, 0xfffffffffffffffe, 0xffffffffffffffec, 0xfffffffffffffffa ); # -20 % -6

  TEST_VX_OP( 18, vrem.vx, 0x0000000000000000, 0x8000000000000001, 0x0000000000000001 ); # (INT64_MIN + 1) %  1
  TEST_VX_OP( 19, vrem.vx, 0x0000000000000000, 0x8000000000000001, 0xffffffffffffffff ); # (INT64_MIN + 1) % -1

  TEST_VX_OP( 20, vrem.vx, 0x0000000000000000, 0x8000000000000000, 0x0000000000000001 ); # INT64_MIN % 1
#if __riscv_vsew == 32
  TEST_VX_OP( 21, vrem.vx, 0x8000000000000000, 0x8000000000000000, 0xffffffffffffffff ); # INT64_MIN % -1 = ERROR (Should be defined to specific reresult)
#endif

#if __riscv_vsew == 64
  TEST_VX_OP( 27, vrem.vx, 0x0000000000000000, 0x8000000000000000, 0xffffffffffffffff ); 
#endif

  TEST_VX_OP( 22, vrem.vx, 0x0000000000000000, 0x0fffffffffffffff, 0x0000000000000001 ); # INT64_MAX %  1
  TEST_VX_OP( 23, vrem.vx, 0x0000000000000000, 0x0fffffffffffffff, 0xffffffffffffffff ); # INT64_MAX % -1
  
  TEST_VX_OP( 24, vrem.vx, 0x0000000000000014, 0x0000000000000014, 0x0000000000000000 ); #  20 % 0 = ERROR (Should be defined to specific result)
  TEST_VX_OP( 25, vrem.vx, 0xffffffffffffffec, 0xffffffffffffffec, 0x0000000000000000 ); # -20 % 0 = ERROR (Should be defined to specific result)
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
