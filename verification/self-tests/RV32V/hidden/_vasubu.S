# See LICENSE for license details.

#*****************************************************************************
# vasubu.S
#-----------------------------------------------------------------------------
#
# Test vasubu instructions.
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

  TEST_AVG_VV_OP( 2,  vasubu.vv, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VV_OP( 3,  vasubu.vv, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000001, 0x00000000 );
  TEST_AVG_VV_OP( 4,  vasubu.vv, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, 0x00000003, 0x00000007 );

  TEST_AVG_VV_OP( 5,  vasubu.vv, (0x80004000) + 0, (0x80004000) + 0, (0x80004000) + 0, (0x80004000) + 0, 0x00000000, 0xffff8000 );
  TEST_AVG_VV_OP( 6,  vasubu.vv, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, 0x80000000, 0x00000000 );
  TEST_AVG_VV_OP( 7,  vasubu.vv, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, 0x80000000, 0xffff8000 );

  TEST_AVG_VV_OP( 8,  vasubu.vv, (0xfffff8001 >> 1) + 1, (0xfffff8001 >> 1) + 0, (0xfffff8001 >> 1) + 0, (0xfffff8001 >> 1) + 1, 0x00000000, 0x00007fff );
  TEST_AVG_VV_OP( 9,  vasubu.vv, (0x7fffffff >> 1) + 1, (0x7fffffff >> 1) + 1, (0x7fffffff >> 1) + 0, (0x7fffffff >> 1) + 0, 0x7fffffff, 0x00000000 );
  TEST_AVG_VV_OP( 10, vasubu.vv, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, 0x7fffffff, 0x00007fff );

  TEST_AVG_VV_OP( 11, vasubu.vv, (0x7fff8001 >> 1) + 1, (0x7fff8001 >> 1) + 0, (0x7fff8001 >> 1) + 0, (0x7fff8001 >> 1) + 1,0x80000000, 0x00007fff );
  TEST_AVG_VV_OP( 12, vasubu.vv, (0xf80007fff >> 1) + 1, (0xf80007fff >> 1) + 1, (0xf80007fff >> 1) + 0, (0xf80007fff >> 1) + 0, 0x7fffffff, 0xffff8000 );

  TEST_AVG_VV_OP( 13, vasubu.vv, (0xf00000001 >> 1) + 1,  (0xf00000001 >> 1) + 0,  (0xf00000001 >> 1) + 0,  (0xf00000001 >> 1) + 1, 0x00000000, 0xffffffff );
  TEST_AVG_VV_OP( 14, vasubu.vv, (0xfffffffe >> 1) + 0, (0xfffffffe >> 1) + 0, (0xfffffffe >> 1) + 0, (0xfffffffe >> 1) + 0, 0xffffffff, 0x00000001 );
  TEST_AVG_VV_OP( 15, vasubu.vv, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0xffffffff, 0xffffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP( 16, vasubu.vx, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VX_OP( 17, vasubu.vx, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000001, 0x00000000 );
  TEST_AVG_VX_OP( 18, vasubu.vx, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, 0x00000003, 0x00000007 );

  TEST_AVG_VX_OP( 19, vasubu.vx, (0x80004000) + 0, (0x80004000) + 0, (0x80004000) + 0, (0x80004000) + 0, 0x00000000, 0xffff8000 );
  TEST_AVG_VX_OP( 20, vasubu.vx, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, (0x80000000 >> 1) + 0, 0x80000000, 0x00000000 );
  TEST_AVG_VX_OP( 21, vasubu.vx, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, 0x80000000, 0xffff8000 );

  TEST_AVG_VX_OP( 22, vasubu.vx, (0xfffff8001 >> 1) + 1, (0xfffff8001 >> 1) + 0, (0xfffff8001 >> 1) + 0, (0xfffff8001 >> 1) + 1, 0x00000000, 0x00007fff );
  TEST_AVG_VX_OP( 23, vasubu.vx, (0x7fffffff >> 1) + 1, (0x7fffffff >> 1) + 1, (0x7fffffff >> 1) + 0, (0x7fffffff >> 1) + 0, 0x7fffffff, 0x00000000 );
  TEST_AVG_VX_OP( 24, vasubu.vx, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, 0x7fffffff, 0x00007fff );

  TEST_AVG_VX_OP( 25, vasubu.vx, (0x7fff8001 >> 1) + 1, (0x7fff8001 >> 1) + 0, (0x7fff8001 >> 1) + 0, (0x7fff8001 >> 1) + 1,0x80000000, 0x00007fff );
  TEST_AVG_VX_OP( 26, vasubu.vx, (0xf80007fff >> 1) + 1, (0xf80007fff >> 1) + 1, (0xf80007fff >> 1) + 0, (0xf80007fff >> 1) + 0, 0x7fffffff, 0xffff8000 );

  TEST_AVG_VX_OP( 27, vasubu.vx, (0xf00000001 >> 1) + 1,  (0xf00000001 >> 1) + 0,  (0xf00000001 >> 1) + 0,  (0xf00000001 >> 1) + 1, 0x00000000, 0xffffffff );
  TEST_AVG_VX_OP( 28, vasubu.vx, (0xfffffffe >> 1) + 0, (0xfffffffe >> 1) + 0, (0xfffffffe >> 1) + 0, (0xfffffffe >> 1) + 0, 0xffffffff, 0x00000001 );
  TEST_AVG_VX_OP( 29, vasubu.vx, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0xffffffff, 0xffffffff );

#endif

#if __riscv_vsew == 64

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_AVG_VV_OP( 2,  vasubu.vv, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, 0x0000000000000000, 0x0000000000000000 );
  TEST_AVG_VV_OP( 3,  vasubu.vv, (0x0000000000000001 >> 1) + 1, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 1, 0x0000000000000002, 0x0000000000000001 );
  TEST_AVG_VV_OP( 4,  vasubu.vv, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, 0x0000000000000003, 0x0000000000000007 );

  TEST_AVG_VV_OP( 5,  vasubu.vv, (0x8000000000004000) + 0, (0x8000000000004000) + 0, (0x8000000000004000) + 0, (0x8000000000004000) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VV_OP( 6,  vasubu.vv, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, 0xffffffff80000000, 0x0000000000000000 );
  TEST_AVG_VV_OP( 7,  vasubu.vv, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 8,  vasubu.vv, (0xffffffffffffc001) + 0, (0xffffffffffffc001) - 1, (0xffffffffffffc001) - 1, (0xffffffffffffc001) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 9,  vasubu.vv, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 0, (0x000000007fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VV_OP( 10, vasubu.vv, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VV_OP( 11, vasubu.vv, (0xffffffff7fff8001 >> 1) + 1, (0xffffffff7fff8001 >> 1) + 0, (0xffffffff7fff8001 >> 1) + 0, (0xffffffff7fff8001 >> 1) + 1, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 12, vasubu.vv, (0x8000000040003fff) + 1, (0x8000000040003fff) + 1, (0x8000000040003fff) + 0, (0x8000000040003fff) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 13, vasubu.vv, (0x8000000000000000) + 1, (0x8000000000000000) + 0, (0x8000000000000000) + 0, (0x8000000000000000) + 1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VV_OP( 14, vasubu.vv, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VV_OP( 15, vasubu.vv, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP( 16, vasubu.vx, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, 0x0000000000000000, 0x0000000000000000 );
  TEST_AVG_VX_OP( 17, vasubu.vx, (0x0000000000000001 >> 1) + 1, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 1, 0x0000000000000002, 0x0000000000000001 );
  TEST_AVG_VX_OP( 18, vasubu.vx, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, 0x0000000000000003, 0x0000000000000007 );

  TEST_AVG_VX_OP( 19, vasubu.vx, (0x8000000000004000) + 0, (0x8000000000004000) + 0, (0x8000000000004000) + 0, (0x8000000000004000) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VX_OP( 20, vasubu.vx, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, (0xffffffff80000000 >> 1) + 0, 0xffffffff80000000, 0x0000000000000000 );
  TEST_AVG_VX_OP( 21, vasubu.vx, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 22, vasubu.vx, (0xffffffffffffc001) + 0, (0xffffffffffffc001) - 1, (0xffffffffffffc001) - 1, (0xffffffffffffc001) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 23, vasubu.vx, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 0, (0x000000007fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VX_OP( 24, vasubu.vx, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VX_OP( 25, vasubu.vx, (0xffffffff7fff8001 >> 1) + 1, (0xffffffff7fff8001 >> 1) + 0, (0xffffffff7fff8001 >> 1) + 0, (0xffffffff7fff8001 >> 1) + 1, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 26, vasubu.vx, (0x8000000040003fff) + 1, (0x8000000040003fff) + 1, (0x8000000040003fff) + 0, (0x8000000040003fff) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 27, vasubu.vx, (0x8000000000000000) + 1, (0x8000000000000000) + 0, (0x8000000000000000) + 0, (0x8000000000000000) + 1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VX_OP( 28, vasubu.vx, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, (0xfffffffffffffffe >> 1) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VX_OP( 29, vasubu.vx, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
