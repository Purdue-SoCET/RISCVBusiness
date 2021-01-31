# See LICENSE for license details.

#*****************************************************************************
# c_add.S
#-----------------------------------------------------------------------------
#
# Test c_add instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RV32C_R_OP( 2,  c.add, 0x00000000, 0x00000000, 0x00000000 );
  TEST_RV32C_R_OP( 3,  c.add, 0x00000002, 0x00000001, 0x00000001 );
  TEST_RV32C_R_OP( 4,  c.add, 0x0000000a, 0x00000003, 0x00000007 );

  TEST_RV32C_R_OP( 5,  c.add, 0xffff8000, 0x00000000, 0xffff8000 );
  TEST_RV32C_R_OP( 6,  c.add, 0x80000000, 0x80000000, 0x00000000 );
  TEST_RV32C_R_OP( 7,  c.add, 0x7fff8000, 0x80000000, 0xffff8000 );

  TEST_RV32C_R_OP( 8,  c.add, 0x00007fff, 0x00000000, 0x00007fff );
  TEST_RV32C_R_OP( 9,  c.add, 0x7fffffff, 0x7fffffff, 0x00000000 );
  TEST_RV32C_R_OP( 10, c.add, 0x80007ffe, 0x7fffffff, 0x00007fff );

  TEST_RV32C_R_OP( 11, c.add, 0x80007fff, 0x80000000, 0x00007fff );
  TEST_RV32C_R_OP( 12, c.add, 0x7fff7fff, 0x7fffffff, 0xffff8000 );

  TEST_RV32C_R_OP( 13, c.add, 0xffffffff, 0x00000000, 0xffffffff );
  TEST_RV32C_R_OP( 14, c.add, 0x00000000, 0xffffffff, 0x00000001 );
  TEST_RV32C_R_OP( 15, c.add, 0xfffffffe, 0xffffffff, 0xffffffff );

  TEST_RV32C_R_OP( 16, c.add, 0x80000000, 0x00000001, 0x7fffffff );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RV32C_RR_SRC12_EQ_DEST( 17, c.add, 26, 13 );
  TEST_RV32C_RR_SRC12_EQ_DEST( 18, c.add, -200, -100 );


  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_RR_DEST_BYPASS( 19, 0, c.add, 24, 13, 11 );
  TEST_RV32C_RR_DEST_BYPASS( 20, 1, c.add, 25, 14, 11 );
  TEST_RV32C_RR_DEST_BYPASS( 21, 2, c.add, 26, 15, 11 );

  TEST_RV32C_RR_SRC12_BYPASS( 22, 0, 0, c.add, 24, 13, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 23, 0, 1, c.add, 25, 14, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 24, 0, 2, c.add, 26, 15, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 25, 1, 0, c.add, 24, 13, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 26, 1, 1, c.add, 25, 14, 11 );
  TEST_RV32C_RR_SRC12_BYPASS( 27, 2, 0, c.add, 26, 15, 11 );

  TEST_RV32C_RR_SRC21_BYPASS( 28, 0, 0, c.add, 24, 13, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 29, 0, 1, c.add, 25, 14, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 30, 0, 2, c.add, 26, 15, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 31, 1, 0, c.add, 24, 13, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 32, 1, 1, c.add, 25, 14, 11 );
  TEST_RV32C_RR_SRC21_BYPASS( 33, 2, 0, c.add, 26, 15, 11 );

  TEST_PASSFAIL

RVTEST_CODE_END


  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
