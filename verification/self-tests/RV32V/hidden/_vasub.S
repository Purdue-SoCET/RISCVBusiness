# See LICENSE for license details.

#*****************************************************************************
# vasub.S
#-----------------------------------------------------------------------------
#
# Test vasub instructions.
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

  TEST_AVG_VV_OP( 2,  vasub.vv, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VV_OP( 3,  vasub.vv, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000001, 0x00000000 );
  TEST_AVG_VV_OP( 4,  vasub.vv, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, 0x00000003, 0x00000007 );

  TEST_AVG_VV_OP( 5,  vasub.vv, (0x00008000 >> 1) + 0, (0x00008000 >> 1) + 0, (0x00008000 >> 1) + 0, (0x00008000 >> 1) + 0, 0x00000000, 0xffff8000 );
  TEST_AVG_VV_OP( 6,  vasub.vv, (0xf80000000 >> 1) + 0, (0xf80000000 >> 1) + 0, (0xf80000000 >> 1) + 0, (0xf80000000 >> 1) + 0, 0x80000000, 0x00000000 );
  TEST_AVG_VV_OP( 7,  vasub.vv, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, 0x80000000, 0xffff8000 );

  TEST_AVG_VV_OP( 8,  vasub.vv, (0xfffff8001 >> 1) + 1, (0xfffff8001 >> 1) + 0, (0xfffff8001 >> 1) + 0, (0xfffff8001 >> 1) + 1, 0x00000000, 0x00007fff );
  TEST_AVG_VV_OP( 9,  vasub.vv, (0x7fffffff >> 1) + 1, (0x7fffffff >> 1) + 1, (0x7fffffff >> 1) + 0, (0x7fffffff >> 1) + 0, 0x7fffffff, 0x00000000 );
  TEST_AVG_VV_OP( 10, vasub.vv, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, 0x7fffffff, 0x00007fff );

  TEST_AVG_VV_OP( 11, vasub.vv, (0xf7fff8001 >> 1) + 1, (0xf7fff8001 >> 1) + 0, (0xf7fff8001 >> 1) + 0, (0xf7fff8001 >> 1) + 1,0x80000000, 0x00007fff );
  TEST_AVG_VV_OP( 12, vasub.vv, (0x80007fff >> 1) + 1, (0x80007fff >> 1) + 1, (0x80007fff >> 1) + 0, (0x80007fff >> 1) + 0, 0x7fffffff, 0xffff8000 );

  TEST_AVG_VV_OP( 13, vasub.vv, (0x00000001 >> 1) + 1,  (0x00000001 >> 1) + 0,  (0x00000001 >> 1) + 0,  (0x00000001 >> 1) + 1, 0x00000000, 0xffffffff );
  TEST_AVG_VV_OP( 14, vasub.vv, (0xffffffffe >> 1) + 0, (0xffffffffe >> 1) + 0, (0xffffffffe >> 1) + 0, (0xffffffffe >> 1) + 0, 0xffffffff, 0x00000001 );
  TEST_AVG_VV_OP( 15, vasub.vv, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0xffffffff, 0xffffffff );
	
  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP( 16, vasub.vx, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0x00000000, 0x00000000 );
  TEST_AVG_VX_OP( 17, vasub.vx, (0x00000001 >> 1) + 1, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 0, (0x00000001 >> 1) + 1, 0x00000001, 0x00000000 );
  TEST_AVG_VX_OP( 18, vasub.vx, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, (0xffffffffc >> 1) + 0, 0x00000003, 0x00000007 );

  TEST_AVG_VX_OP( 19, vasub.vx, (0x00008000 >> 1) + 0, (0x00008000 >> 1) + 0, (0x00008000 >> 1) + 0, (0x00008000 >> 1) + 0, 0x00000000, 0xffff8000 );
  TEST_AVG_VX_OP( 20, vasub.vx, (0xf80000000 >> 1) + 0, (0xf80000000 >> 1) + 0, (0xf80000000 >> 1) + 0, (0xf80000000 >> 1) + 0, 0x80000000, 0x00000000 );
  TEST_AVG_VX_OP( 21, vasub.vx, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, (0xf80008000 >> 1) + 0, 0x80000000, 0xffff8000 );

  TEST_AVG_VX_OP( 22, vasub.vx, (0xfffff8001 >> 1) + 1, (0xfffff8001 >> 1) + 0, (0xfffff8001 >> 1) + 0, (0xfffff8001 >> 1) + 1, 0x00000000, 0x00007fff );
  TEST_AVG_VX_OP( 23, vasub.vx, (0x7fffffff >> 1) + 1, (0x7fffffff >> 1) + 1, (0x7fffffff >> 1) + 0, (0x7fffffff >> 1) + 0, 0x7fffffff, 0x00000000 );
  TEST_AVG_VX_OP( 24, vasub.vx, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, (0x7fff8000 >> 1) + 0, 0x7fffffff, 0x00007fff );

  TEST_AVG_VX_OP( 25, vasub.vx, (0xf7fff8001 >> 1) + 1, (0xf7fff8001 >> 1) + 0, (0xf7fff8001 >> 1) + 0, (0xf7fff8001 >> 1) + 1,0x80000000, 0x00007fff );
  TEST_AVG_VX_OP( 26, vasub.vx, (0x80007fff >> 1) + 1, (0x80007fff >> 1) + 1, (0x80007fff >> 1) + 0, (0x80007fff >> 1) + 0, 0x7fffffff, 0xffff8000 );

  TEST_AVG_VX_OP( 27, vasub.vx, (0x00000001 >> 1) + 1,  (0x00000001 >> 1) + 0,  (0x00000001 >> 1) + 0,  (0x00000001 >> 1) + 1, 0x00000000, 0xffffffff );
  TEST_AVG_VX_OP( 28, vasub.vx, (0xffffffffe >> 1) + 0, (0xffffffffe >> 1) + 0, (0xffffffffe >> 1) + 0, (0xffffffffe >> 1) + 0, 0xffffffff, 0x00000001 );
  TEST_AVG_VX_OP( 29, vasub.vx, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, (0x00000000 >> 1) + 0, 0xffffffff, 0xffffffff );

#endif

#if __riscv_vsew == 64

  #-------------------------------------------------------------
  # VV Tests
  #-------------------------------------------------------------

  TEST_AVG_VV_OP( 2,  vasub.vv, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, 0x0000000000000000, 0x0000000000000000 );
  TEST_AVG_VV_OP( 3,  vasub.vv, (0x0000000000000001 >> 1) + 1, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 1, 0x0000000000000002, 0x0000000000000001 );
  TEST_AVG_VV_OP( 4,  vasub.vv, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, 0x0000000000000003, 0x0000000000000007 );

  TEST_AVG_VV_OP( 5,  vasub.vv, (0x0000000000008000 >> 1) + 0, (0x0000000000008000 >> 1) + 0, (0x0000000000008000 >> 1) + 0, (0x0000000000008000 >> 1) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VV_OP( 6,  vasub.vv, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, 0xffffffff80000000, 0x0000000000000000 );
  TEST_AVG_VV_OP( 7,  vasub.vv, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 8,  vasub.vv, (0xffffffffffffc001) + 0, (0xffffffffffffc001) - 1, (0xffffffffffffc001) - 1, (0xffffffffffffc001) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 9,  vasub.vv, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 0, (0x000000007fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VV_OP( 10, vasub.vv, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VV_OP( 11, vasub.vv, (0xffffffffbfffc001) + 0, (0xffffffffbfffc001) - 1, (0xffffffffbfffc001) - 1, (0xffffffffbfffc001) + 0, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VV_OP( 12, vasub.vv, (0x0000000080007fff >> 1) + 1, (0x0000000080007fff >> 1) + 1, (0x0000000080007fff >> 1) + 0, (0x0000000080007fff >> 1) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VV_OP( 13, vasub.vv, (0x0000000000000001 >> 1) + 1, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VV_OP( 14, vasub.vv, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VV_OP( 15, vasub.vv, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

  #-------------------------------------------------------------
  # VX Tests
  #-------------------------------------------------------------

  TEST_AVG_VX_OP( 16, vasub.vx, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, 0x0000000000000000, 0x0000000000000000 );
  TEST_AVG_VX_OP( 17, vasub.vx, (0x0000000000000001 >> 1) + 1, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 1, 0x0000000000000002, 0x0000000000000001 );
  TEST_AVG_VX_OP( 18, vasub.vx, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, (0xfffffffffffffffe) + 0, 0x0000000000000003, 0x0000000000000007 );

  TEST_AVG_VX_OP( 19, vasub.vx, (0x0000000000008000 >> 1) + 0, (0x0000000000008000 >> 1) + 0, (0x0000000000008000 >> 1) + 0, (0x0000000000008000 >> 1) + 0, 0x0000000000000000, 0xffffffffffff8000 );
  TEST_AVG_VX_OP( 20, vasub.vx, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, (0xffffffffc0000000) + 0, 0xffffffff80000000, 0x0000000000000000 );
  TEST_AVG_VX_OP( 21, vasub.vx, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, (0xffffffffc0004000) + 0, 0xffffffff80000000, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 22, vasub.vx, (0xffffffffffffc001) + 0, (0xffffffffffffc001) - 1, (0xffffffffffffc001) - 1, (0xffffffffffffc001) + 0, 0x0000000000000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 23, vasub.vx, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 1, (0x000000007fffffff >> 1) + 0, (0x000000007fffffff >> 1) + 0, 0x000000007fffffff, 0x0000000000000000 );
  TEST_AVG_VX_OP( 24, vasub.vx, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, (0x000000007fff8000 >> 1) + 0, 0x000000007fffffff, 0x0000000000007fff );

  TEST_AVG_VX_OP( 25, vasub.vx, (0xffffffffbfffc001) + 0, (0xffffffffbfffc001) - 1, (0xffffffffbfffc001) - 1, (0xffffffffbfffc001) + 0, 0xffffffff80000000, 0x0000000000007fff );
  TEST_AVG_VX_OP( 26, vasub.vx, (0x0000000080007fff >> 1) + 1, (0x0000000080007fff >> 1) + 1, (0x0000000080007fff >> 1) + 0, (0x0000000080007fff >> 1) + 0, 0x000000007fffffff, 0xffffffffffff8000 );

  TEST_AVG_VX_OP( 27, vasub.vx, (0x0000000000000001 >> 1) + 1, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 0, (0x0000000000000001 >> 1) + 1, 0x0000000000000000, 0xffffffffffffffff );
  TEST_AVG_VX_OP( 28, vasub.vx, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, (0xffffffffffffffff) + 0, 0xffffffffffffffff, 0x0000000000000001 );
  TEST_AVG_VX_OP( 29, vasub.vx, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, (0x0000000000000000 >> 1) + 0, 0xffffffffffffffff, 0xffffffffffffffff );

#endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
