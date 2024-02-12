# See LICENSE for license details.

#*****************************************************************************
# vfwcvt.S
#-----------------------------------------------------------------------------
#
# Test vfwcvt (Widening Floating-Point/Integer Type-Convert Instructions) instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vfwcvt.xu.f.v (float to double-width unsigned integer) tests
  #-------------------------------------------------------------

  TEST_W_FP_INT_OP( 2,  vfwcvt.xu.f.v,  0x10,           0,  -3.0 );
  TEST_W_FP_INT_OP( 3,  vfwcvt.xu.f.v,  0x10,           0,  -1.0 );
  TEST_W_FP_INT_OP( 4,  vfwcvt.xu.f.v,  0x10,           0,  -0.9 );
  TEST_W_FP_INT_OP( 5,  vfwcvt.xu.f.v,  0x01,           1,   0.9 );
  TEST_W_FP_INT_OP( 6,  vfwcvt.xu.f.v,  0x00,           1,   1.0 );
  TEST_W_FP_INT_OP( 7,  vfwcvt.xu.f.v,  0x01,           1,   1.1 );
  TEST_W_FP_INT_OP( 8,  vfwcvt.xu.f.v,  0x10,           0,  -3e9 );
  TEST_W_FP_INT_OP( 9,  vfwcvt.xu.f.v,  0x00,  0xb2d05e00,   3e9 );
	
  #-------------------------------------------------------------
  # vfwcvt.x.f.v (float to double-width signed integer) tests
  #-------------------------------------------------------------

  TEST_W_FP_INT_OP(10,  vfwcvt.x.f.v,   0x01,          -1,  -1.1 );
  TEST_W_FP_INT_OP(11,  vfwcvt.x.f.v,   0x00,          -1,  -1.0 );
  TEST_W_FP_INT_OP(12,  vfwcvt.x.f.v,   0x01,          -1,  -0.9 );
  TEST_W_FP_INT_OP(13,  vfwcvt.x.f.v,   0x01,           1,   0.9 );
  TEST_W_FP_INT_OP(14,  vfwcvt.x.f.v,   0x00,           1,   1.0 );
  TEST_W_FP_INT_OP(15,  vfwcvt.x.f.v,   0x01,           1,   1.1 );
  TEST_W_FP_INT_OP(16,  vfwcvt.x.f.v,   0x00, -3000000000,  -3e9 );
  TEST_W_FP_INT_OP(17,  vfwcvt.x.f.v,   0x00,  3000000000,   3e9 );
  TEST_W_FP_INT_OP(18,  vfwcvt.x.f.v,   0x10,      -1<<63, -3e19 );
  TEST_W_FP_INT_OP(19,  vfwcvt.x.f.v,   0x10,   (1<<63)-1,  3e19 );

  #-------------------------------------------------------------
  # vfwcvt.rtz.xu.f.v (float to double-width unsigned integer truncating) tests
  #-------------------------------------------------------------

  TEST_W_FP_INT_OP(20,  vfwcvt.rtz.xu.f.v,   0x10,           0,  -3.0 );
  TEST_W_FP_INT_OP(21,  vfwcvt.rtz.xu.f.v,   0x10,           0,  -1.0 );
  TEST_W_FP_INT_OP(22,  vfwcvt.rtz.xu.f.v,   0x01,           0,  -0.9 );
  TEST_W_FP_INT_OP(23,  vfwcvt.rtz.xu.f.v,   0x01,           0,   0.9 );
  TEST_W_FP_INT_OP(24,  vfwcvt.rtz.xu.f.v,   0x00,           1,   1.0 );
  TEST_W_FP_INT_OP(25,  vfwcvt.rtz.xu.f.v,   0x01,           1,   1.1 );
  TEST_W_FP_INT_OP(26,  vfwcvt.rtz.xu.f.v,   0x10,           0,  -3e9 );
  TEST_W_FP_INT_OP(27,  vfwcvt.rtz.xu.f.v,   0x00,  0xb2d05e00,   3e9 );

  #-------------------------------------------------------------
  # vfwcvt.rtz.x.f.v (float to double-width signed integer truncating) tests
  #-------------------------------------------------------------

  TEST_W_FP_INT_OP(28,  vfwcvt.rtz.x.f.v,    0x01,          -1,  -1.1 );
  TEST_W_FP_INT_OP(29,  vfwcvt.rtz.x.f.v,    0x00,          -1,  -1.0 );
  TEST_W_FP_INT_OP(30,  vfwcvt.rtz.x.f.v,    0x01,           0,  -0.9 );
  TEST_W_FP_INT_OP(31,  vfwcvt.rtz.x.f.v,    0x01,           0,   0.9 );
  TEST_W_FP_INT_OP(32,  vfwcvt.rtz.x.f.v,    0x00,           1,   1.0 );
  TEST_W_FP_INT_OP(33,  vfwcvt.rtz.x.f.v,    0x01,           1,   1.1 );
  TEST_W_FP_INT_OP(34,  vfwcvt.rtz.x.f.v,    0x00, -3000000000,  -3e9  );
  TEST_W_FP_INT_OP(35,  vfwcvt.rtz.x.f.v,    0x00,  3000000000,   3e9  );
  TEST_W_FP_INT_OP(36,  vfwcvt.rtz.x.f.v,    0x10,      -1<<63, -3e19  );
  TEST_W_FP_INT_OP(37,  vfwcvt.rtz.x.f.v,    0x10,   (1<<63)-1,  3e19  );

  #-------------------------------------------------------------
  # vfwcvt.f.xu.v (unsigned integer to double-width float) tests
  #-------------------------------------------------------------

  TEST_W_INT_FP_OP(38,  vfwcvt.f.xu.v,    0x00,          2.0,    2 );
  TEST_W_INT_FP_OP(39,  vfwcvt.f.xu.v,    0x00,   4294967294,   -2 );

  #-------------------------------------------------------------
  # vfwcvt.f.x.v (signed integer to double-width float) tests
  #-------------------------------------------------------------

  TEST_W_INT_FP_OP(40,  vfwcvt.f.x.v,     0x00,          2.0,    2 );
  TEST_W_INT_FP_OP(41,  vfwcvt.f.x.v,     0x00,         -2.0,   -2 );

  #-------------------------------------------------------------
  # vfwcvt.f.f.v (single-width float to double-width float) tests
  #-------------------------------------------------------------

  TEST_W_FP_1OPERAND_OP(42,  vfwcvt.f.f.v,     0x00,          2.0,    2.0 );
  TEST_W_FP_1OPERAND_OP(43,  vfwcvt.f.f.v,     0x00,         -2.0,   -2.0 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
