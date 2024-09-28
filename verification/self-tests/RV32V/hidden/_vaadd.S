# See LICENSE for license details.

#*****************************************************************************
# vaadd.S
#-----------------------------------------------------------------------------
#
# Test vaadd instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
#if __riscv_vsew == 32

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_AVG_VV_OP( 2,  vaadd.vv, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VV_OP( 3,  vaadd.vv, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, 0x00000001, 0x00000001 );
  TEST_AVG_VV_OP( 4,  vaadd.vv, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000000, 0x00000001 );

  TEST_AVG_VV_OP( 5,  vaadd.vv, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VV_OP( 6,  vaadd.vv, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, 0xffffffff80000000, 0x00000000 );
  TEST_AVG_VV_OP( 7,  vaadd.vv, (0xffffffff7fff8000 >> 1) + 0, (0xffffffff7fff8000 >> 1) + 0, (0xffffffff7fff8000 >> 1) + 0, (0xffffffff7fff8000 >> 1) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 8,  vaadd.vv, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 0, (0x0000000000007fff >> 1) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 9,  vaadd.vv, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 0, (0x000000007fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VV_OP( 10, vaadd.vv, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VV_OP( 11, vaadd.vv, (0xffffffff80007fff >> 1) + 1, (0xffffffff80007fff >> 1) + 1, (0xffffffff80007fff >> 1) + 0, (0xffffffff80007fff >> 1) + 0, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 12, vaadd.vv, (0x000000007fff7fff >> 1) + 1, (0x000000007fff7fff >> 1) + 1, (0x000000007fff7fff >> 1) + 0, (0x000000007fff7fff >> 1) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 13, vaadd.vv, (0xffffffffffffffff >> 1) + 1, (0xffffffffffffffff >> 1) + 1, (0xffffffffffffffff >> 1) + 0, (0xffffffffffffffff >> 1) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VV_OP( 14, vaadd.vv, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VV_OP( 15, vaadd.vv, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_AVG_VV_OP( 16, vaadd.vv, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, 0x0000000000000001, 0x000000007fffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP( 17, vaadd.vx, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VX_OP( 18, vaadd.vx, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, 0x00000001, 0x00000001 );
  TEST_AVG_VX_OP( 19, vaadd.vx, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000000, 0x00000001 );

  TEST_AVG_VX_OP( 20, vaadd.vx, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VX_OP( 21, vaadd.vx, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, 0xffffffff80000000, 0x00000000 );
  TEST_AVG_VX_OP( 22, vaadd.vx, (0xffffffff7fff8000 >> 1) + 0, (0xffffffff7fff8000 >> 1) + 0, (0xffffffff7fff8000 >> 1) + 0, (0xffffffff7fff8000 >> 1) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 23, vaadd.vx, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 0, (0x0000000000007fff >> 1) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 24, vaadd.vx, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 0, (0x000000007fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VX_OP( 25, vaadd.vx, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VX_OP( 26, vaadd.vx, (0xffffffff80007fff >> 1) + 1, (0xffffffff80007fff >> 1) + 1, (0xffffffff80007fff >> 1) + 0, (0xffffffff80007fff >> 1) + 0, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 27, vaadd.vx, (0x000000007fff7fff >> 1) + 1, (0x000000007fff7fff >> 1) + 1, (0x000000007fff7fff >> 1) + 0, (0x000000007fff7fff >> 1) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 28, vaadd.vx, (0xffffffffffffffff >> 1) + 1, (0xffffffffffffffff >> 1) + 1, (0xffffffffffffffff >> 1) + 0, (0xffffffffffffffff >> 1) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VX_OP( 29, vaadd.vx, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VX_OP( 30, vaadd.vx, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_AVG_VX_OP( 31, vaadd.vx, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, 0x0000000000000001, 0x000000007fffffff );
		
#endif

#if __riscv_vsew == 64
# Because 0xffffffffffffffff >> 1 = 0x7fffffffffffffff (unsigned right shift), but we want signed shift
# so those test case whose answer starts at 1 will be rewrite by hand, rather than using >>

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_AVG_VV_OP( 2,  vaadd.vv, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VV_OP( 3,  vaadd.vv, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, 0x00000001, 0x00000001 );
  TEST_AVG_VV_OP( 4,  vaadd.vv, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000000, 0x00000001 );

  TEST_AVG_VV_OP( 5,  vaadd.vv, (0xffffffffffffc000) + 0, (0xffffffffffffc000) + 0, (0xffffffffffffc000) + 0, (0xffffffffffffc000) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VV_OP( 6,  vaadd.vv, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, 0xffffffff80000000, 0x00000000 );
  TEST_AVG_VV_OP( 7,  vaadd.vv, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 8,  vaadd.vv, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 0, (0x0000000000007fff >> 1) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 9,  vaadd.vv, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 0, (0x000000007fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VV_OP( 10, vaadd.vv, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VV_OP( 11, vaadd.vv, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, (0xffffffffc0004000) - 1, (0xffffffffc0004000) - 1, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 12, vaadd.vv, (0x000000007fff7fff >> 1) + 1, (0x000000007fff7fff >> 1) + 1, (0x000000007fff7fff >> 1) + 0, (0x000000007fff7fff >> 1) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 13, vaadd.vv, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VV_OP( 14, vaadd.vv, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VV_OP( 15, vaadd.vv, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_AVG_VV_OP( 16, vaadd.vv, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, 0x0000000000000001, 0x000000007fffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP( 17, vaadd.vx, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VX_OP( 18, vaadd.vx, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, 0x00000001, 0x00000001 );
  TEST_AVG_VX_OP( 19, vaadd.vx, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000000, 0x00000001 );

  TEST_AVG_VX_OP( 20, vaadd.vx, (0xffffffffffffc000) + 0, (0xffffffffffffc000) + 0, (0xffffffffffffc000) + 0, (0xffffffffffffc000) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VX_OP( 21, vaadd.vx, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, 0xffffffff80000000, 0x00000000 );
  TEST_AVG_VX_OP( 22, vaadd.vx, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 23, vaadd.vx, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 0, (0x0000000000007fff >> 1) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 24, vaadd.vx, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 0, (0x000000007fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VX_OP( 25, vaadd.vx, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VX_OP( 26, vaadd.vx, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, (0xffffffffc0004000) - 1, (0xffffffffc0004000) - 1, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 27, vaadd.vx, (0x000000007fff7fff >> 1) + 1, (0x000000007fff7fff >> 1) + 1, (0x000000007fff7fff >> 1) + 0, (0x000000007fff7fff >> 1) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 28, vaadd.vx, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 1, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VX_OP( 29, vaadd.vx, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, (0x0000000000000000 >> 0) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VX_OP( 30, vaadd.vx, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_AVG_VX_OP( 31, vaadd.vx, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, 0x0000000000000001, 0x000000007fffffff );

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
