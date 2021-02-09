# See LICENSE for license details.

#*****************************************************************************
# c_and.S
#-----------------------------------------------------------------------------
#
# Test c_and instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  TEST_RV32C_R_OP( 2, c.and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_R_OP( 3, c.and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_R_OP( 4, c.and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RV32C_R_OP( 5, c.and, 0xf000f000, 0xf00ff00f, 0xf0f0f0f0 );
  TEST_RV32C_R_OP( 6, c.and, 0x00000000, 0x00000000, 0xf0f0f0f0 );

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  TEST_RV32C_RR_SRC12_EQ_DEST( 7, c.and, 0xff00ff00, 0xff00ff00 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_RR_DEST_BYPASS( 8,  0, c.and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_RR_DEST_BYPASS( 9, 1, c.and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_RR_DEST_BYPASS( 10, 2, c.and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RV32C_RR_SRC12_BYPASS( 11, 0, 0, c.and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC12_BYPASS( 12, 0, 1, c.and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_RR_SRC12_BYPASS( 13, 0, 2, c.and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC12_BYPASS( 14, 1, 0, c.and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC12_BYPASS( 15, 1, 1, c.and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_RR_SRC12_BYPASS( 16, 2, 0, c.and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );

  TEST_RV32C_RR_SRC21_BYPASS( 17, 0, 0, c.and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC21_BYPASS( 18, 0, 1, c.and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_RR_SRC21_BYPASS( 19, 0, 2, c.and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC21_BYPASS( 20, 1, 0, c.and, 0x0f000f00, 0xff00ff00, 0x0f0f0f0f );
  TEST_RV32C_RR_SRC21_BYPASS( 21, 1, 1, c.and, 0x00f000f0, 0x0ff00ff0, 0xf0f0f0f0 );
  TEST_RV32C_RR_SRC21_BYPASS( 22, 2, 0, c.and, 0x000f000f, 0x00ff00ff, 0x0f0f0f0f );


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
