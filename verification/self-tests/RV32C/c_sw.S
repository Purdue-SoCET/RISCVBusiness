# See LICENSE for license details.

#*****************************************************************************
# c_sw.S
#-----------------------------------------------------------------------------
#
# Test c_sw instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_RV32C_ST_OP( 2, c.lw, c.sw, 0x00aa00aa, 0,  tdat );
  TEST_RV32C_ST_OP( 3, c.lw, c.sw, 0xaa00aa00, 4,  tdat );
  TEST_RV32C_ST_OP( 4, c.lw, c.sw, 0x0aa00aa0, 8,  tdat );
  TEST_RV32C_ST_OP( 5, c.lw, c.sw, 0xa00aa00a, 12, tdat );

  # Test with a negative base

  TEST_CASE( 6, x13, 0x12345678, \
    la  x11, tdat9; \
    li  x12, 0x12345678; \
    addi x14, x11, -32; \
    c.sw x12, 32(x14); \
    c.lw x13, 0(x11); \
  )


  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_RV32C_ST_SRC12_BYPASS( 7, 0, 0, c.lw, c.sw, 0xaabbccdd, 0,  tdat );
  TEST_RV32C_ST_SRC12_BYPASS( 8, 0, 1, c.lw, c.sw, 0xdaabbccd, 4,  tdat );
  TEST_RV32C_ST_SRC12_BYPASS( 9, 0, 2, c.lw, c.sw, 0xddaabbcc, 8,  tdat );
  TEST_RV32C_ST_SRC12_BYPASS( 10, 1, 0, c.lw, c.sw, 0xcddaabbc, 12, tdat );
  TEST_RV32C_ST_SRC12_BYPASS( 11, 1, 1, c.lw, c.sw, 0xccddaabb, 16, tdat );
  TEST_RV32C_ST_SRC12_BYPASS( 12, 2, 0, c.lw, c.sw, 0xbccddaab, 20, tdat );

  TEST_RV32C_ST_SRC21_BYPASS( 13, 0, 0, c.lw, c.sw, 0x00112233, 0,  tdat );
  TEST_RV32C_ST_SRC21_BYPASS( 14, 0, 1, c.lw, c.sw, 0x30011223, 4,  tdat );
  TEST_RV32C_ST_SRC21_BYPASS( 15, 0, 2, c.lw, c.sw, 0x33001122, 8,  tdat );
  TEST_RV32C_ST_SRC21_BYPASS( 16, 1, 0, c.lw, c.sw, 0x23300112, 12, tdat );
  TEST_RV32C_ST_SRC21_BYPASS( 17, 1, 1, c.lw, c.sw, 0x22330011, 16, tdat );
  TEST_RV32C_ST_SRC21_BYPASS( 18, 2, 0, c.lw, c.sw, 0x12233001, 20, tdat );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

tdat:
tdat1:  .word 0xdeadbeef
tdat2:  .word 0xdeadbeef
tdat3:  .word 0xdeadbeef
tdat4:  .word 0xdeadbeef
tdat5:  .word 0xdeadbeef
tdat6:  .word 0xdeadbeef
tdat7:  .word 0xdeadbeef
tdat8:  .word 0xdeadbeef
tdat9:  .word 0xdeadbeef
tdat10: .word 0xdeadbeef

RVTEST_DATA_END
