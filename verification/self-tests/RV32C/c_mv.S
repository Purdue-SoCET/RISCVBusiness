# See LICENSE for license details.

#*****************************************************************************
# c_mv.S
#-----------------------------------------------------------------------------
#
# Test c_mv instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # 4th argument has no effect

  TEST_RV32C_R_OP( 2,  c.mv, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RV32C_R_OP( 3,  c.mv, 0x00000002, 0x00000000, 0x00000002 );
  TEST_RV32C_R_OP( 4,  c.mv, 0x0000000a, 0x00000000, 0x0000000a );

  TEST_RV32C_R_OP( 5,  c.mv, 0xffff8000, 0x00000000, 0xffff8000 );
  TEST_RV32C_R_OP( 6,  c.mv, 0x80000000, 0x00000000, 0x80000000 );
  TEST_RV32C_R_OP( 7,  c.mv, 0x7fff8000, 0x00000000, 0x7fff8000 );

  TEST_RV32C_R_OP( 8,  c.mv, 0x00007fff, 0x00000000, 0x00007fff );
  TEST_RV32C_R_OP( 9,  c.mv, 0x7fffffff, 0x00000000, 0x7fffffff );
  TEST_RV32C_R_OP( 10, c.mv, 0x80007ffe, 0x00000000, 0x80007ffe );

  TEST_RV32C_R_OP( 11, c.mv, 0x80007fff, 0x00000000, 0x80007fff );
  TEST_RV32C_R_OP( 12, c.mv, 0x7fff7fff, 0x00000000, 0x7fff7fff );

  TEST_RV32C_R_OP( 13, c.mv, 0xffffffff, 0x00000000, 0xffffffff );
  TEST_RV32C_R_OP( 14, c.mv, 0x00000001, 0x00000000, 0x00000001 );
  TEST_RV32C_R_OP( 15, c.mv, 0xfffffffe, 0x00000000, 0xfffffffe );

  TEST_RV32C_R_OP( 16, c.mv, 0x80000000, 0x00000000, 0x80000000 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RV32C_RR_SRC12_EQ_DEST( 17, c.mv, 13, 13 );
  TEST_RV32C_RR_SRC12_EQ_DEST( 18, c.mv, -100, -100 );


  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  # 5th argument has no effect

  TEST_RV32C_RR_DEST_BYPASS( 19, 0, c.mv, 11, 0, 11 );
  TEST_RV32C_RR_DEST_BYPASS( 20, 1, c.mv, 12, 0, 12 );
  TEST_RV32C_RR_DEST_BYPASS( 21, 2, c.mv, 13, 0, 13 );

  TEST_RV32C_RR_SRC12_BYPASS( 22, 0, 0, c.mv, 11, 0, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 23, 0, 1, c.mv, 12, 0, 12 );
  TEST_RV32C_RR_SRC12_BYPASS( 24, 0, 2, c.mv, 13, 0, 13 );
  TEST_RV32C_RR_SRC12_BYPASS( 25, 1, 0, c.mv, 11, 0, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 26, 1, 1, c.mv, 12, 0, 12 );
  TEST_RV32C_RR_SRC12_BYPASS( 27, 2, 0, c.mv, 13, 0, 13 );

  TEST_RV32C_RR_SRC21_BYPASS( 28, 0, 0, c.mv, 11, 0, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 29, 0, 1, c.mv, 12, 0, 12 );
  TEST_RV32C_RR_SRC21_BYPASS( 30, 0, 2, c.mv, 13, 0, 13 );
  TEST_RV32C_RR_SRC21_BYPASS( 31, 1, 0, c.mv, 11, 0, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 32, 1, 1, c.mv, 12, 0, 12 );
  TEST_RV32C_RR_SRC21_BYPASS( 33, 2, 0, c.mv, 13, 0, 13 );

  TEST_PASSFAIL

RVTEST_CODE_END


  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
