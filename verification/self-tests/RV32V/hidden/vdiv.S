# See LICENSE for license details.

#*****************************************************************************
# vdiv.S
#-----------------------------------------------------------------------------
#
# Test vdiv instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_VV_OP( 2,  vdiv.vv, 0x0000000000000003, 0x0000000000000014, 0x0000000000000006 ); #  20 /  6
  TEST_VV_OP( 3,  vdiv.vv, 0xfffffffffffffffd, 0x0000000000000014, 0xfffffffffffffffa ); #  20 / -6
  TEST_VV_OP( 4,  vdiv.vv, 0xfffffffffffffffd, 0xffffffffffffffec, 0x0000000000000006 ); # -20 /  6
  TEST_VV_OP( 5,  vdiv.vv, 0x0000000000000003, 0xffffffffffffffec, 0xfffffffffffffffa ); # -20 / -6

  TEST_VV_OP( 6,  vdiv.vv, 0x8000000000000001, 0x8000000000000001, 0x0000000000000001 ); # (INT64_MIN + 1) /  1
  TEST_VV_OP( 7,  vdiv.vv, 0x7fffffffffffffff, 0x8000000000000001, 0xffffffffffffffff ); # (INT64_MIN + 1) / -1

  TEST_VV_OP( 8,  vdiv.vv, 0x8000000000000000, 0x8000000000000000, 0x0000000000000001 ); # INT64_MIN / 1
  TEST_VV_OP( 9,  vdiv.vv, 0x8000000000000000, 0x8000000000000000, 0xffffffffffffffff ); # INT64_MIN / -1 = ERROR (Should be defined to specific result)

  TEST_VV_OP( 10, vdiv.vv, 0x0fffffffffffffff, 0x0fffffffffffffff, 0x0000000000000001 ); # INT64_MAX /  1
  TEST_VV_OP( 11, vdiv.vv, 0xf000000000000001, 0x0fffffffffffffff, 0xffffffffffffffff ); # INT64_MAX / -1

  TEST_VV_OP( 12, vdiv.vv, -1, 0x0000000000000014, 0x0000000000000000 ); #  20 / 0 = ERROR (Should be defined to specific result)
  TEST_VV_OP( 13, vdiv.vv, -1, 0xffffffffffffffec, 0x0000000000000000 ); # -20 / 0 = ERROR (Should be defined to specific result)
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_VX_OP( 14, vdiv.vx, 0x0000000000000003, 0x0000000000000014, 0x0000000000000006 ); #  20 /  6
  TEST_VX_OP( 15, vdiv.vx, 0xfffffffffffffffd, 0x0000000000000014, 0xfffffffffffffffa ); #  20 / -6
  TEST_VX_OP( 16, vdiv.vx, 0xfffffffffffffffd, 0xffffffffffffffec, 0x0000000000000006 ); # -20 /  6
  TEST_VX_OP( 17, vdiv.vx, 0x0000000000000003, 0xffffffffffffffec, 0xfffffffffffffffa ); # -20 / -6

  TEST_VX_OP( 18, vdiv.vx, 0x8000000000000001, 0x8000000000000001, 0x0000000000000001 ); # (INT64_MIN + 1) /  1
  TEST_VX_OP( 19, vdiv.vx, 0x7fffffffffffffff, 0x8000000000000001, 0xffffffffffffffff ); # (INT64_MIN + 1) / -1

  TEST_VX_OP( 20, vdiv.vx, 0x8000000000000000, 0x8000000000000000, 0x0000000000000001 ); # INT64_MIN / 1
  TEST_VX_OP( 21, vdiv.vx, 0x8000000000000000, 0x8000000000000000, 0xffffffffffffffff ); # INT64_MIN / -1 = ERROR (Should be defined to specific result)

  TEST_VX_OP( 22, vdiv.vx, 0x0fffffffffffffff, 0x0fffffffffffffff, 0x0000000000000001 ); # INT64_MAX /  1
  TEST_VX_OP( 23, vdiv.vx, 0xf000000000000001, 0x0fffffffffffffff, 0xffffffffffffffff ); # INT64_MAX / -1
  
  TEST_VX_OP( 24, vdiv.vx, -1, 0x0000000000000014, 0x0000000000000000 ); #  20 / 0 = ERROR (Should be defined to specific result)
  TEST_VX_OP( 25, vdiv.vx, -1, 0xffffffffffffffec, 0x0000000000000000 ); # -20 / 0 = ERROR (Should be defined to specific result)
	
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
