# See LICENSE for license details.

#*****************************************************************************
# c_lw.S
#-----------------------------------------------------------------------------
#
# Test c_lw instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_RV32C_LD_OP( 2, c.lw, 0x00ff00ff, 0,  tdat );
  TEST_RV32C_LD_OP( 3, c.lw, 0xff00ff00, 4,  tdat );
  TEST_RV32C_LD_OP( 4, c.lw, 0x0ff00ff0, 8,  tdat );
  TEST_RV32C_LD_OP( 5, c.lw, 0xf00ff00f, 12, tdat );

  # Test with a negative base

  TEST_CASE( 6, x13, 0x00ff00ff, \
    la  x11, tdat; \
    addi x11, x11, -32; \
    c.lw x13, 32(x11); \
  )

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_LD_DEST_BYPASS( 7, 0, c.lw, 0x0ff00ff0, 4, tdat2 );
  TEST_RV32C_LD_DEST_BYPASS( 8, 1, c.lw, 0xf00ff00f, 4, tdat3 );
  TEST_RV32C_LD_DEST_BYPASS( 9, 2, c.lw, 0xff00ff00, 4, tdat1 );

  TEST_RV32C_LD_SRC1_BYPASS( 10, 0, c.lw, 0x0ff00ff0, 4, tdat2 );
  TEST_RV32C_LD_SRC1_BYPASS( 11, 1, c.lw, 0xf00ff00f, 4, tdat3 );
  TEST_RV32C_LD_SRC1_BYPASS( 12, 2, c.lw, 0xff00ff00, 4, tdat1 );

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  TEST_CASE( 13, x12, 2, \
    la  x13, tdat; \
    c.lw  x12, 0(x13); \
    li  x12, 2; \
  )

  TEST_CASE( 14, x12, 2, \
    la  x13, tdat; \
    c.lw  x12, 0(x13); \
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
