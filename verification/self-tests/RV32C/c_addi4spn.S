# See LICENSE for license details.

#*****************************************************************************
# c_addi4spn.S
#-----------------------------------------------------------------------------
#
# Test c_addi4spn instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # Immediate values should be multiple of 4

  TEST_RV32C_IMM_OP_SP_REG( 2,  c.addi4spn, 0x00000010, 0x00000000, 0x010 );
  TEST_RV32C_IMM_OP_SP_REG( 3,  c.addi4spn, 0x00000111, 0x00000001, 0x110 );
  TEST_RV32C_IMM_OP_SP_REG( 4,  c.addi4spn, 0x000000aa, 0x0000003a, 0x070 );

  TEST_RV32C_IMM_OP_SP_REG( 5,  c.addi4spn, 0x00000200, 0x00000010, 0x1f0 );
  TEST_RV32C_IMM_OP_SP_REG( 6,  c.addi4spn, 0x800000f0, 0x80000000, 0x0f0 );
  TEST_RV32C_IMM_OP_SP_REG( 7,  c.addi4spn, 0x800002fc, 0x80000000, 0x2fc );

  TEST_RV32C_IMM_OP_SP_REG( 8,  c.addi4spn, 0x000000e0, 0xfffffff0, 0x0f0 );
  TEST_RV32C_IMM_OP_SP_REG( 9,  c.addi4spn, 0x800002a7, 0x7fffffff, 0x2a8 );
  TEST_RV32C_IMM_OP_SP_REG( 10, c.addi4spn, 0x800001ef, 0x7fffffff, 0x1f0 );

  TEST_RV32C_IMM_OP_SP_REG( 11, c.addi4spn, 0x800003fc, 0x80000000, 0x3fc );
  TEST_RV32C_IMM_OP_SP_REG( 12, c.addi4spn, 0x100003fb, 0x0fffffff, 0x3fc );

  TEST_RV32C_IMM_OP_SP_REG( 13, c.addi4spn, 0x000003f0, 0x00000000, 0x3f0 );
  TEST_RV32C_IMM_OP_SP_REG( 14, c.addi4spn, 0x00000000, 0xfffffff0, 0x010 );
  TEST_RV32C_IMM_OP_SP_REG( 15, c.addi4spn, 0x000003e0, 0xfffffff0, 0x3f0 );

  TEST_RV32C_IMM_OP_SP_REG( 16, c.addi4spn, 0x80000000, 0x7ffffff0, 0x010 );


  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_DEST_BYPASS_SP_REG( 17, 0, c.addi4spn, 154, 150, 4 );
  TEST_RV32C_IMM_DEST_BYPASS_SP_REG( 18, 1, c.addi4spn, 158, 150, 8 );
  TEST_RV32C_IMM_DEST_BYPASS_SP_REG( 19, 2, c.addi4spn, 162, 150, 12 );

  TEST_RV32C_IMM_SRC1_BYPASS_SP_REG( 20, 0, c.addi4spn, 154, 150, 4 );
  TEST_RV32C_IMM_SRC1_BYPASS_SP_REG( 21, 1, c.addi4spn, 158, 150, 8 );
  TEST_RV32C_IMM_SRC1_BYPASS_SP_REG( 22, 2, c.addi4spn, 162, 150, 12 );


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
