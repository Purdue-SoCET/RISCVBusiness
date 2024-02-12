# See LICENSE for license details.

#*****************************************************************************
# vaaddu.S
#-----------------------------------------------------------------------------
#
# Test vaaddu instructions.
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

  TEST_AVG_VV_OP( 2,  vaaddu.vv, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VV_OP( 3,  vaaddu.vv, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, 0x00000001, 0x00000001 );
  TEST_AVG_VV_OP( 4,  vaaddu.vv, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000000, 0x00000001 );

  TEST_AVG_VV_OP( 5,  vaaddu.vv, (0xffff8000 >> 1) + 0, (0xffff8000 >> 1) + 0, (0xffff8000 >> 1) + 0, (0xffff8000 >> 1) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VV_OP( 6,  vaaddu.vv, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, 0xffffffff80000000, 0x00000000 );
  TEST_AVG_VV_OP( 7,  vaaddu.vv, (0x17fff8000 >> 1) + 0,(0x17fff8000 >> 1) + 0, (0x17fff8000 >> 1) + 0, (0x17fff8000 >> 1) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 8,  vaaddu.vv, (0x00007fff >> 1) + 1, (0x00007fff >> 1) + 1,(0x00007fff >> 1) + 0, (0x00007fff >> 1) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 9,  vaaddu.vv, (0x7fffffff >> 1) + 1, (0x7fffffff >> 1) + 1,(0x7fffffff >> 1) + 0, (0x7fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VV_OP( 10, vaaddu.vv, (0x80007ffe >> 1) + 0, (0x80007ffe >> 1) + 0,(0x80007ffe >> 1) + 0, (0x80007ffe >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VV_OP( 11, vaaddu.vv, (0x80007fff >> 1) + 1, (0x80007fff >> 1) + 1, (0x80007fff >> 1) + 0, (0x80007fff >> 1) + 0, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 12, vaaddu.vv, (0x17fff7fff >> 1) + 1,(0x17fff7fff >> 1) + 1, (0x17fff7fff >> 1) + 0, (0x17fff7fff >> 1) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 13, vaaddu.vv, (0xffffffff >> 1) + 1, (0xffffffff >> 1) + 1, (0xffffffff >> 1) + 0, (0xffffffff >> 1) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VV_OP( 14, vaaddu.vv, (0x100000000 >> 1) + 0, (0x100000000 >> 1) + 0, (0x100000000 >> 1) + 0, (0x100000000 >> 1) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VV_OP( 15, vaaddu.vv, (0x1fffffffe >> 1) + 0, (0x1fffffffe >> 1) + 0, (0x1fffffffe >> 1) + 0, (0x1fffffffe >> 1) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_AVG_VV_OP( 16, vaaddu.vv, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, 0x0000000000000001, 0x000000007fffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP( 17, vaaddu.vx, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VX_OP( 18, vaaddu.vx, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, 0x00000001, 0x00000001 );
  TEST_AVG_VX_OP( 19, vaaddu.vx, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000000, 0x00000001 );

  TEST_AVG_VX_OP( 20, vaaddu.vx, (0xffff8000 >> 1) + 0, (0xffff8000 >> 1) + 0, (0xffff8000 >> 1) + 0, (0xffff8000 >> 1) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VX_OP( 21, vaaddu.vx, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, 0xffffffff80000000, 0x00000000 );
  TEST_AVG_VX_OP( 22, vaaddu.vx, (0x17fff8000 >> 1) + 0,(0x17fff8000 >> 1) + 0, (0x17fff8000 >> 1) + 0, (0x17fff8000 >> 1) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 23, vaaddu.vx, (0x00007fff >> 1) + 1, (0x00007fff >> 1) + 1,(0x00007fff >> 1) + 0, (0x00007fff >> 1) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 24, vaaddu.vx, (0x7fffffff >> 1) + 1, (0x7fffffff >> 1) + 1,(0x7fffffff >> 1) + 0, (0x7fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VX_OP( 25, vaaddu.vx, (0x80007ffe >> 1) + 0, (0x80007ffe >> 1) + 0,(0x80007ffe >> 1) + 0, (0x80007ffe >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VX_OP( 26, vaaddu.vx, (0x80007fff >> 1) + 1, (0x80007fff >> 1) + 1, (0x80007fff >> 1) + 0, (0x80007fff >> 1) + 0, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 27, vaaddu.vx, (0x17fff7fff >> 1) + 1,(0x17fff7fff >> 1) + 1, (0x17fff7fff >> 1) + 0, (0x17fff7fff >> 1) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 28, vaaddu.vx, (0xffffffff >> 1) + 1, (0xffffffff >> 1) + 1, (0xffffffff >> 1) + 0, (0xffffffff >> 1) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VX_OP( 29, vaaddu.vx, (0x100000000 >> 1) + 0, (0x100000000 >> 1) + 0, (0x100000000 >> 1) + 0, (0x100000000 >> 1) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VX_OP( 30, vaaddu.vx, (0x1fffffffe >> 1) + 0, (0x1fffffffe >> 1) + 0, (0x1fffffffe >> 1) + 0, (0x1fffffffe >> 1) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_AVG_VX_OP( 31, vaaddu.vx, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, 0x0000000000000001, 0x000000007fffffff );

#endif

#if __riscv_vsew == 64

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_AVG_VV_OP( 2,  vaaddu.vv, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VV_OP( 3,  vaaddu.vv, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, 0x00000001, 0x00000001 );
  TEST_AVG_VV_OP( 4,  vaaddu.vv, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000000, 0x00000001 );

  TEST_AVG_VV_OP( 5,  vaaddu.vv, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VV_OP( 6,  vaaddu.vv, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, 0xffffffff80000000, 0x00000000 );
  TEST_AVG_VV_OP( 7,  vaaddu.vv, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 8,  vaaddu.vv, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 0, (0x0000000000007fff >> 1) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 9,  vaaddu.vv, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 0, (0x000000007fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VV_OP( 10, vaaddu.vv, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VV_OP( 11, vaaddu.vv, (0xffffffff80007fff >> 1) + 1, (0xffffffff80007fff >> 1) + 1, (0xffffffff80007fff >> 1) + 0, (0xffffffff80007fff >> 1) + 0, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 12, vaaddu.vv, (0x800000003fffbfff) + 1,  (0x800000003fffbfff) + 1,  (0x800000003fffbfff) + 0,  (0x800000003fffbfff) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 13, vaaddu.vv, (0xffffffffffffffff >> 1) + 1, (0xffffffffffffffff >> 1) + 1, (0xffffffffffffffff >> 1) + 0, (0xffffffffffffffff >> 1) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VV_OP( 14, vaaddu.vv, (0x8000000000000000 >> 0) + 0, (0x8000000000000000 >> 0) + 0, (0x8000000000000000 >> 0) + 0, (0x8000000000000000 >> 0) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VV_OP( 15, vaaddu.vv, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_AVG_VV_OP( 16, vaaddu.vv, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, 0x0000000000000001, 0x000000007fffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP( 17, vaaddu.vx, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VX_OP( 18, vaaddu.vx, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, (0x00000002 >> 1) + 0, 0x00000001, 0x00000001 );
  TEST_AVG_VX_OP( 19, vaaddu.vx, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000000, 0x00000001 );

  TEST_AVG_VX_OP( 20, vaaddu.vx, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, (0xffffffffffff8000 >> 1) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VX_OP( 21, vaaddu.vx, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, 0xffffffff80000000, 0x00000000 );
  TEST_AVG_VX_OP( 22, vaaddu.vx, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, (0xffffffffbfffc000) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 23, vaaddu.vx, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 1, (0x0000000000007fff >> 1) + 0, (0x0000000000007fff >> 1) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 24, vaaddu.vx, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 0, (0x000000007fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VX_OP( 25, vaaddu.vx, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, (0x0000000080007ffe >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VX_OP( 26, vaaddu.vx, (0xffffffff80007fff >> 1) + 1, (0xffffffff80007fff >> 1) + 1, (0xffffffff80007fff >> 1) + 0, (0xffffffff80007fff >> 1) + 0, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 27, vaaddu.vx, (0x800000003fffbfff) + 1,  (0x800000003fffbfff) + 1,  (0x800000003fffbfff) + 0,  (0x800000003fffbfff) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 28, vaaddu.vx, (0xffffffffffffffff >> 1) + 1, (0xffffffffffffffff >> 1) + 1, (0xffffffffffffffff >> 1) + 0, (0xffffffffffffffff >> 1) + 0, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VX_OP( 29, vaaddu.vx, (0x8000000000000000 >> 0) + 0, (0x8000000000000000 >> 0) + 0, (0x8000000000000000 >> 0) + 0, (0x8000000000000000 >> 0) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VX_OP( 30, vaaddu.vx, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

  TEST_AVG_VX_OP( 31, vaaddu.vx, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, (0x0000000080000000 >> 1) + 0, 0x0000000000000001, 0x000000007fffffff );

#endif


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
