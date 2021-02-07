# See LICENSE for license details.

#*****************************************************************************
# c_andi.S
#-----------------------------------------------------------------------------
#
# Test c_andi instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_OP( 2, c.andi, 0xff00ff00, 0xff00ff00, 0x3f );
  TEST_RV32C_IMM_OP( 3, c.andi, 0x00000010, 0x0ff00ff0, 0x10 );
  TEST_RV32C_IMM_OP( 4, c.andi, 0x0000000f, 0x00ff00ff, 0x0f );
  TEST_RV32C_IMM_OP( 5, c.andi, 0x00000000, 0xf00ff00f, 0x00 );
  TEST_RV32C_IMM_OP( 6, c.andi, 0x00000000, 0x00000000, 0x20 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_IMM_DEST_BYPASS( 7,  0, c.andi, 0xfff00ff0, 0xfff00ff0, 0x3f );
  TEST_RV32C_IMM_DEST_BYPASS( 8,  1, c.andi, 0xe0ff00f0, 0xe0ff00ff, 0x30 );
  TEST_RV32C_IMM_DEST_BYPASS( 9,  2, c.andi, 0x0000000f, 0xf00ff00f, 0x0f );

  TEST_RV32C_IMM_SRC1_BYPASS( 10, 0, c.andi, 0x0ff00ff0, 0x0ff00ff0, 0x3f );
  TEST_RV32C_IMM_SRC1_BYPASS( 11, 1, c.andi, 0x00ff00f0, 0x00ff00ff, 0x30 );
  TEST_RV32C_IMM_SRC1_BYPASS( 12, 2, c.andi, 0x0000000f, 0xf00ff00f, 0x0f );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
