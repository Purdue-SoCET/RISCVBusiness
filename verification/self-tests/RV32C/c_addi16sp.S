# See LICENSE for license details.

#*****************************************************************************
# c_addi16sp.S
#-----------------------------------------------------------------------------
#
# Test c_addi16sp instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------
  
  # Immediate values should be multiple of 16

  TEST_RV32C_IMM_OP_SP( 2,  c.addi16sp, 0x00000010, 0x00000000, 0x010 );
  TEST_RV32C_IMM_OP_SP( 3,  c.addi16sp, 0x00000111, 0x00000001, 0x110 );
  TEST_RV32C_IMM_OP_SP( 4,  c.addi16sp, 0x000000aa, 0x0000003a, 0x070 );

  TEST_RV32C_IMM_OP_SP( 5,  c.addi16sp, 0x00000200, 0x00000010, 0x1f0 );
  TEST_RV32C_IMM_OP_SP( 6,  c.addi16sp, 0x800000f0, 0x80000000, 0x0f0 );
  TEST_RV32C_IMM_OP_SP( 7,  c.addi16sp, 0x7ffffef0, 0x80000000, 0x2f0 );

  TEST_RV32C_IMM_OP_SP( 8,  c.addi16sp, 0x000000e0, 0xfffffff0, 0x0f0 );
  TEST_RV32C_IMM_OP_SP( 9,  c.addi16sp, 0x7ffffe9f, 0x7fffffff, 0x2a0 );
  TEST_RV32C_IMM_OP_SP( 10, c.addi16sp, 0x800001ef, 0x7fffffff, 0x1f0 );

  TEST_RV32C_IMM_OP_SP( 11, c.addi16sp, 0x7ffffe20, 0x80000000, 0x220 );
  TEST_RV32C_IMM_OP_SP( 12, c.addi16sp, 0x7ffffdff, 0x7fffffff, 0x200 );

  TEST_RV32C_IMM_OP_SP( 13, c.addi16sp, 0xfffffff0, 0x00000000, 0x3f0 );
  TEST_RV32C_IMM_OP_SP( 14, c.addi16sp, 0x00000000, 0xfffffff0, 0x010 );
  TEST_RV32C_IMM_OP_SP( 15, c.addi16sp, 0xffffffe0, 0xfffffff0, 0x3f0 );

  TEST_RV32C_IMM_OP_SP( 16, c.addi16sp, 0x80000000, 0x7ffffff0, 0x010 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_DEST_BYPASS_SP( 17, 0, c.addi16sp, 116, 100, 16 );
  TEST_RV32C_IMM_DEST_BYPASS_SP( 18, 1, c.addi16sp, 132, 100, 32 );
  TEST_RV32C_IMM_DEST_BYPASS_SP( 19, 2, c.addi16sp, 148, 100, 48 );

  TEST_RV32C_IMM_SRC1_BYPASS_SP( 20, 0, c.addi16sp, 116, 100, 16 );
  TEST_RV32C_IMM_SRC1_BYPASS_SP( 21, 1, c.addi16sp, 132, 100, 32 );
  TEST_RV32C_IMM_SRC1_BYPASS_SP( 22, 2, c.addi16sp, 148, 100, 48 );


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
