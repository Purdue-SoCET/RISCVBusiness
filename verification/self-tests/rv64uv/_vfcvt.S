# See LICENSE for license details.

#*****************************************************************************
# vfcvt.S
#-----------------------------------------------------------------------------
#
# Test vfcvt (Single-Width Floating-Point/Integer Type-Convert Instructions) instructions.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vfcvt.xu.f.v (float to unsigned integer) tests
  #-------------------------------------------------------------

  TEST_FP_INT_OP( 2,  vfcvt.xu.f.v,  0x10,           0,  -3.0 );
  TEST_FP_INT_OP( 3,  vfcvt.xu.f.v,  0x10,           0,  -1.0 );
  TEST_FP_INT_OP( 4,  vfcvt.xu.f.v,  0x10,           0,  -0.9 );
  TEST_FP_INT_OP( 5,  vfcvt.xu.f.v,  0x01,           1,   0.9 );
  TEST_FP_INT_OP( 6,  vfcvt.xu.f.v,  0x00,           1,   1.0 );
  TEST_FP_INT_OP( 7,  vfcvt.xu.f.v,  0x01,           1,   1.1 );
  TEST_FP_INT_OP( 8,  vfcvt.xu.f.v,  0x10,           0,  -3e9 );
  TEST_FP_INT_OP( 9,  vfcvt.xu.f.v,  0x00,  0xb2d05e00,   3e9 );
	
  #-------------------------------------------------------------
  # vfcvt.x.f.v (float to signed integer) tests
  #-------------------------------------------------------------

  TEST_FP_INT_OP(10,  vfcvt.x.f.v,   0x01,          -1,  -1.1 );
  TEST_FP_INT_OP(11,  vfcvt.x.f.v,   0x00,          -1,  -1.0 );
  TEST_FP_INT_OP(12,  vfcvt.x.f.v,   0x01,          -1,  -0.9 );
  TEST_FP_INT_OP(13,  vfcvt.x.f.v,   0x01,           1,   0.9 );
  TEST_FP_INT_OP(14,  vfcvt.x.f.v,   0x00,           1,   1.0 );
  TEST_FP_INT_OP(15,  vfcvt.x.f.v,   0x01,           1,   1.1 );
  TEST_FP_INT_OP(16,  vfcvt.x.f.v,   0x10,      -1<<31,  -3e9 );
  TEST_FP_INT_OP(17,  vfcvt.x.f.v,   0x10,   (1<<31)-1,   3e9 );

  #-------------------------------------------------------------
  # vfcvt.rtz.xu.f.v (float to unsigned integer truncating) tests
  #-------------------------------------------------------------

  TEST_FP_INT_OP(18,  vfcvt.rtz.xu.f.v,   0x10,           0,  -3.0 );
  TEST_FP_INT_OP(19,  vfcvt.rtz.xu.f.v,   0x10,           0,  -1.0 );
  TEST_FP_INT_OP(20,  vfcvt.rtz.xu.f.v,   0x01,           0,  -0.9 );
  TEST_FP_INT_OP(21,  vfcvt.rtz.xu.f.v,   0x01,           0,   0.9 );
  TEST_FP_INT_OP(22,  vfcvt.rtz.xu.f.v,   0x00,           1,   1.0 );
  TEST_FP_INT_OP(23,  vfcvt.rtz.xu.f.v,   0x01,           1,   1.1 );
  TEST_FP_INT_OP(24,  vfcvt.rtz.xu.f.v,   0x10,           0,  -3e9 );
  TEST_FP_INT_OP(25,  vfcvt.rtz.xu.f.v,   0x00,  0xb2d05e00,   3e9 );

  #-------------------------------------------------------------
  # vfcvt.rtz.x.f.v (float to signed integer truncating) tests
  #-------------------------------------------------------------

  TEST_FP_INT_OP(26,  vfcvt.rtz.x.f.v,    0x01,          -1,  -1.1 );
  TEST_FP_INT_OP(27,  vfcvt.rtz.x.f.v,    0x00,          -1,  -1.0 );
  TEST_FP_INT_OP(28,  vfcvt.rtz.x.f.v,    0x01,           0,  -0.9 );
  TEST_FP_INT_OP(29,  vfcvt.rtz.x.f.v,    0x01,           0,   0.9 );
  TEST_FP_INT_OP(30,  vfcvt.rtz.x.f.v,    0x00,           1,   1.0 );
  TEST_FP_INT_OP(31,  vfcvt.rtz.x.f.v,    0x01,           1,   1.1 );
  TEST_FP_INT_OP(32,  vfcvt.rtz.x.f.v,    0x10,      -1<<31,  -3e9 );
  TEST_FP_INT_OP(33,  vfcvt.rtz.x.f.v,    0x10,   (1<<31)-1,   3e9 );

  #-------------------------------------------------------------
  # vfcvt.f.xu.v (unsigned integer to float) tests
  #-------------------------------------------------------------

  TEST_INT_FP_OP(34,  vfcvt.f.xu.v,    0x00,          2.0,    2 );
  TEST_INT_FP_OP(35,  vfcvt.f.xu.v,    0x01,  4.2949673e9,   -2 );

  #-------------------------------------------------------------
  # vfcvt.f.x.v (signed integer to float) tests
  #-------------------------------------------------------------

  TEST_INT_FP_OP(36,  vfcvt.f.x.v,     0x00,          2.0,    2 );
  TEST_INT_FP_OP(37,  vfcvt.f.x.v,     0x00,         -2.0,   -2 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
