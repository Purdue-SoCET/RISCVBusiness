# See LICENSE for license details.

#*****************************************************************************
# c_xor.S
#-----------------------------------------------------------------------------
#
# Test c_xor instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  TEST_RV32C_R_OP( 2, c.xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_R_OP( 3, c.xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_R_OP( 4, c.xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RV32C_R_OP( 5, c.xor, 0x00ff00ff, 0xf00ff00f, 0xf0f0f0f0 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RV32C_RR_SRC12_EQ_DEST( 6, c.xor, 0x00000000, 0xff00ff00 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_RR_DEST_BYPASS( 7,  0, c.xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_RR_DEST_BYPASS( 8, 1, c.xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_RR_DEST_BYPASS( 9, 2, c.xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RV32C_RR_SRC12_BYPASS( 10, 0, 0, c.xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC12_BYPASS( 11, 0, 1, c.xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_RR_SRC12_BYPASS( 12, 0, 2, c.xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC12_BYPASS( 13, 1, 0, c.xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC12_BYPASS( 14, 1, 1, c.xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_RR_SRC12_BYPASS( 15, 2, 0, c.xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RV32C_RR_SRC21_BYPASS( 16, 0, 0, c.xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC21_BYPASS( 17, 0, 1, c.xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_RR_SRC21_BYPASS( 18, 0, 2, c.xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC21_BYPASS( 19, 1, 0, c.xor, 0xf00ff00f, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC21_BYPASS( 20, 1, 1, c.xor, 0xff00ff00, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_RR_SRC21_BYPASS( 21, 2, 0, c.xor, 0x0ff00ff0, 0x00ff00ff, 0x0f0f0f0f );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
