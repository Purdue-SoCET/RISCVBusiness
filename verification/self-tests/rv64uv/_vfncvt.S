# See LICENSE for license details.

#*****************************************************************************
# vfncvt.S
#-----------------------------------------------------------------------------
#
# Test vfncvt (Narrowing Floating-Point/Integer Type-Convert Instructions) instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vfncvt.xu.f.w (double-width float to unsigned integer) tests
  #-------------------------------------------------------------

  TEST_N_FP_INT_OP( 2,  vfncvt.xu.f.w,  0x10,           0,  -3.0 );
  TEST_N_FP_INT_OP( 3,  vfncvt.xu.f.w,  0x10,           0,  -1.0 );
  TEST_N_FP_INT_OP( 4,  vfncvt.xu.f.w,  0x10,           0,  -0.9 );
  TEST_N_FP_INT_OP( 5,  vfncvt.xu.f.w,  0x01,           1,   0.9 );
  TEST_N_FP_INT_OP( 6,  vfncvt.xu.f.w,  0x00,           1,   1.0 );
  TEST_N_FP_INT_OP( 7,  vfncvt.xu.f.w,  0x01,           1,   1.1 );
  TEST_N_FP_INT_OP( 8,  vfncvt.xu.f.w,  0x10,           0,  -3e9 );
  TEST_N_FP_INT_OP( 9,  vfncvt.xu.f.w,  0x00,  0xb2d05e00,   3e9 );
	
  #-------------------------------------------------------------
  # vfncvt.x.f.w (double-width float to signed integer) tests
  #-------------------------------------------------------------

  TEST_N_FP_INT_OP(10,  vfncvt.x.f.w,   0x01,          -1,  -1.1 );
  TEST_N_FP_INT_OP(11,  vfncvt.x.f.w,   0x00,          -1,  -1.0 );
  TEST_N_FP_INT_OP(12,  vfncvt.x.f.w,   0x01,          -1,  -0.9 );
  TEST_N_FP_INT_OP(13,  vfncvt.x.f.w,   0x01,           1,   0.9 );
  TEST_N_FP_INT_OP(14,  vfncvt.x.f.w,   0x00,           1,   1.0 );
  TEST_N_FP_INT_OP(15,  vfncvt.x.f.w,   0x01,           1,   1.1 );
  TEST_N_FP_INT_OP(16,  vfncvt.x.f.w,   0x10, -2147483648,  -3e9 );
  TEST_N_FP_INT_OP(17,  vfncvt.x.f.w,   0x10,  2147483647,   3e9 );
  TEST_N_FP_INT_OP(18,  vfncvt.x.f.w,   0x10,      -1<<31, -3e19 );
  TEST_N_FP_INT_OP(19,  vfncvt.x.f.w,   0x10,   (1<<31)-1,  3e19 );

  #-------------------------------------------------------------
  # vfncvt.rtz.xu.f.w (double-width float to unsigned integer truncating) tests
  #-------------------------------------------------------------

  TEST_N_FP_INT_OP(20,  vfncvt.rtz.xu.f.w,   0x10,           0,  -3.0 );
  TEST_N_FP_INT_OP(21,  vfncvt.rtz.xu.f.w,   0x10,           0,  -1.0 );
  TEST_N_FP_INT_OP(22,  vfncvt.rtz.xu.f.w,   0x01,           0,  -0.9 );
  TEST_N_FP_INT_OP(23,  vfncvt.rtz.xu.f.w,   0x01,           0,   0.9 );
  TEST_N_FP_INT_OP(24,  vfncvt.rtz.xu.f.w,   0x00,           1,   1.0 );
  TEST_N_FP_INT_OP(25,  vfncvt.rtz.xu.f.w,   0x01,           1,   1.1 );
  TEST_N_FP_INT_OP(26,  vfncvt.rtz.xu.f.w,   0x10,           0,  -3e9 );
  TEST_N_FP_INT_OP(27,  vfncvt.rtz.xu.f.w,   0x00,  0xb2d05e00,   3e9 );

  #-------------------------------------------------------------
  # vfncvt.rtz.x.f.w (double-width float to signed integer truncating) tests
  #-------------------------------------------------------------

  TEST_N_FP_INT_OP(28,  vfncvt.rtz.x.f.w,    0x01,          -1,  -1.1 );
  TEST_N_FP_INT_OP(29,  vfncvt.rtz.x.f.w,    0x00,          -1,  -1.0 );
  TEST_N_FP_INT_OP(30,  vfncvt.rtz.x.f.w,    0x01,           0,  -0.9 );
  TEST_N_FP_INT_OP(31,  vfncvt.rtz.x.f.w,    0x01,           0,   0.9 );
  TEST_N_FP_INT_OP(32,  vfncvt.rtz.x.f.w,    0x00,           1,   1.0 );
  TEST_N_FP_INT_OP(33,  vfncvt.rtz.x.f.w,    0x01,           1,   1.1 );
  TEST_N_FP_INT_OP(34,  vfncvt.rtz.x.f.w,    0x10, -2147483648,  -3e9  );
  TEST_N_FP_INT_OP(35,  vfncvt.rtz.x.f.w,    0x10,  2147483647,   3e9  );
  TEST_N_FP_INT_OP(36,  vfncvt.rtz.x.f.w,    0x10,      -1<<31, -3e19  );
  TEST_N_FP_INT_OP(37,  vfncvt.rtz.x.f.w,    0x10,   (1<<31)-1,  3e19  );

  #-------------------------------------------------------------
  # vfncvt.f.xu.v (double-width unsigned integer to float) tests
  #-------------------------------------------------------------

  TEST_N_INT_FP_OP(38,  vfncvt.f.xu.w,    0x00,          2.0,    2 );
  TEST_N_INT_FP_OP(39,  vfncvt.f.xu.w,    0x01, 1.8446744e19,   -2 );

  #-------------------------------------------------------------
  # vfncvt.f.x.v (double-width signed integer to float) tests
  #-------------------------------------------------------------

  TEST_N_INT_FP_OP(40,  vfncvt.f.x.w,     0x00,          2.0,    2 );
  TEST_N_INT_FP_OP(41,  vfncvt.f.x.w,     0x00,         -2.0,   -2 );

  #-------------------------------------------------------------
  # vfncvt.f.f.w (single-width float to double-width float) tests
  #-------------------------------------------------------------

  TEST_N_FP_1OPERAND_OP(42,  vfncvt.f.f.w,     0x00,          2.0,    2.0 );
  TEST_N_FP_1OPERAND_OP(43,  vfncvt.f.f.w,     0x00,         -2.0,   -2.0 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
