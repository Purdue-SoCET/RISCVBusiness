# See LICENSE for license details.

#*****************************************************************************
# c_lwsp.S
#-----------------------------------------------------------------------------
#
# Test c_lwsp instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_RV32C_LDSP_OP( 2, c.lwsp, 0x00ff00ff, 0,  tdat );
  TEST_RV32C_LDSP_OP( 3, c.lwsp, 0xff00ff00, 4,  tdat );
  TEST_RV32C_LDSP_OP( 4, c.lwsp, 0x0ff00ff0, 8,  tdat );
  TEST_RV32C_LDSP_OP( 5, c.lwsp, 0xf00ff00f, 12, tdat );

  # Test with a negative base

  TEST_CASE( 6, x13, 0x00ff00ff, \
    la  x2, tdat; \
    addi x2, x2, -32; \
    c.lwsp x13, 32(x2); \
  )

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_LDSP_DEST_BYPASS( 7, 0, c.lwsp, 0x0ff00ff0, 4, tdat2 );
  TEST_RV32C_LDSP_DEST_BYPASS( 8, 1, c.lwsp, 0xf00ff00f, 4, tdat3 );
  TEST_RV32C_LDSP_DEST_BYPASS( 9, 2, c.lwsp, 0xff00ff00, 4, tdat1 );

  TEST_RV32C_LDSP_SRC1_BYPASS( 10, 0, c.lwsp, 0x0ff00ff0, 4, tdat2 );
  TEST_RV32C_LDSP_SRC1_BYPASS( 11, 1, c.lwsp, 0xf00ff00f, 4, tdat3 );
  TEST_RV32C_LDSP_SRC1_BYPASS( 12, 2, c.lwsp, 0xff00ff00, 4, tdat1 );

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  TEST_CASE( 13, x12, 2, \
    la  x2, tdat; \
    c.lwsp  x12, 0(x2); \
    li  x12, 2; \
  )

  TEST_CASE( 14, x12, 2, \
    la  x2, tdat; \
    c.lwsp  x12, 0(x2); \
    nop; \
    li  x12, 2; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

tdat:
tdat1:  .word 0x00ff00ff
tdat2:  .word 0xff00ff00
tdat3:  .word 0x0ff00ff0
tdat4:  .word 0xf00ff00f

RVTEST_DATA_END
