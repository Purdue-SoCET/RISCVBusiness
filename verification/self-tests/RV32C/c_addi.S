# See LICENSE for license details.

#*****************************************************************************
# c_addi.S
#-----------------------------------------------------------------------------
#
# Test c_addi instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_OP( 2,  c.addi, 0x00000000, 0x00000000, 0x00 );
  TEST_RV32C_IMM_OP( 3,  c.addi, 0x00000002, 0x00000001, 0x01 );
  TEST_RV32C_IMM_OP( 4,  c.addi, 0x0000000a, 0x00000003, 0x07 );

  TEST_RV32C_IMM_OP( 5,  c.addi, 0x00000020, 0x00000001, 0x1f );
  TEST_RV32C_IMM_OP( 6,  c.addi, 0x80000000, 0x80000000, 0x00 );
  TEST_RV32C_IMM_OP( 7,  c.addi, 0x7fffffef, 0x80000000, 0x2f );

  TEST_RV32C_IMM_OP( 8,  c.addi, 0x1000000e, 0x0fffffff, 0x0f );
  TEST_RV32C_IMM_OP( 9,  c.addi, 0x7fffffff, 0x7fffffff, 0x00 );
  TEST_RV32C_IMM_OP( 10, c.addi, 0x8000001e, 0x7fffffff, 0x1f );

  TEST_RV32C_IMM_OP( 11, c.addi, 0x7fffffe2, 0x80000000, 0x22 );
  TEST_RV32C_IMM_OP( 12, c.addi, 0x7fffffdf, 0x7fffffff, 0x20 );

  TEST_RV32C_IMM_OP( 13, c.addi, 0xffffffff, 0x00000000, 0x3f );
  TEST_RV32C_IMM_OP( 14, c.addi, 0x00000000, 0xffffffff, 0x01 );
  TEST_RV32C_IMM_OP( 15, c.addi, 0xfffffffe, 0xffffffff, 0x3f );

  TEST_RV32C_IMM_OP( 16, c.addi, 0x80000000, 0x7fffffff, 0x01 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_DEST_BYPASS( 17, 0, c.addi, 24, 13, 11 );
  TEST_RV32C_IMM_DEST_BYPASS( 18, 1, c.addi, 23, 13, 10 );
  TEST_RV32C_IMM_DEST_BYPASS( 19, 2, c.addi, 22, 13,  9 );

  TEST_RV32C_IMM_SRC1_BYPASS( 20, 0, c.addi, 24, 13, 11 );
  TEST_RV32C_IMM_SRC1_BYPASS( 21, 1, c.addi, 23, 13, 10 );
  TEST_RV32C_IMM_SRC1_BYPASS( 22, 2, c.addi, 22, 13,  9 );


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
