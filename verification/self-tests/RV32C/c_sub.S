# See LICENSE for license details.

#*****************************************************************************
# c_sub.S
#-----------------------------------------------------------------------------
#
# Test c_sub instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RV32C_R_OP( 2,  c.sub, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RV32C_R_OP( 3,  c.sub, 0x00000000, 0x00000001, 0x00000001 );
  TEST_RV32C_R_OP( 4,  c.sub, 0xfffffffc, 0x00000003, 0x00000007 );

  TEST_RV32C_R_OP( 5,  c.sub, 0x00008000, 0x00000000, 0xffff8000 );
  TEST_RV32C_R_OP( 6,  c.sub, 0x80000000, 0x80000000, 0x00000000 );
  TEST_RV32C_R_OP( 7,  c.sub, 0x80008000, 0x80000000, 0xffff8000 );

  TEST_RV32C_R_OP( 8,  c.sub, 0xffff8001, 0x00000000, 0x00007fff );
  TEST_RV32C_R_OP( 9,  c.sub, 0x7fffffff, 0x7fffffff, 0x00000000 );
  TEST_RV32C_R_OP( 10, c.sub, 0x7fff8000, 0x7fffffff, 0x00007fff );

  TEST_RV32C_R_OP( 11, c.sub, 0x7fff8001, 0x80000000, 0x00007fff );
  TEST_RV32C_R_OP( 12, c.sub, 0x80007fff, 0x7fffffff, 0xffff8000 );

  TEST_RV32C_R_OP( 13, c.sub, 0x00000001, 0x00000000, 0xffffffff );
  TEST_RV32C_R_OP( 14, c.sub, 0xfffffffe, 0xffffffff, 0x00000001 );
  TEST_RV32C_R_OP( 15, c.sub, 0x00000000, 0xffffffff, 0xffffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RV32C_RR_SRC12_EQ_DEST( 16, c.sub, 0, 13 );
  TEST_RV32C_RR_SRC12_EQ_DEST( 17, c.sub, 0, -5 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_RR_DEST_BYPASS( 18, 0, c.sub, 2, 13, 11 );
  TEST_RV32C_RR_DEST_BYPASS( 19, 1, c.sub, 3, 14, 11 );
  TEST_RV32C_RR_DEST_BYPASS( 20, 2, c.sub, 4, 15, 11 );

  TEST_RV32C_RR_SRC12_BYPASS( 21, 0, 0, c.sub, 2, 13, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 22, 0, 1, c.sub, 3, 14, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 23, 0, 2, c.sub, 4, 15, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 24, 1, 0, c.sub, 2, 13, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 25, 1, 1, c.sub, 3, 14, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 26, 2, 0, c.sub, 4, 15, 11 );

  TEST_RV32C_RR_SRC21_BYPASS( 27, 0, 0, c.sub, 2, 13, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 28, 0, 1, c.sub, 3, 14, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 29, 0, 2, c.sub, 4, 15, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 30, 1, 0, c.sub, 2, 13, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 31, 1, 1, c.sub, 3, 14, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 32, 2, 0, c.sub, 4, 15, 11 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
