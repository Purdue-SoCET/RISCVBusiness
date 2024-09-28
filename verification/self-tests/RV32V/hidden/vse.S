# See LICENSE for license details.

#*****************************************************************************
# vse.S
#-----------------------------------------------------------------------------
#
# Test vse instruction.
# vse64 only support when VSEW >= 64
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vse8
  #-------------------------------------------------------------

  TEST_VSE_OP( 2, vle8.v, vse8.v, 8, 0xaa,  0  + tdat );
  TEST_VSE_OP( 3, vle8.v, vse8.v, 8, 0x00,  4  + tdat );
  TEST_VSE_OP( 4, vle8.v, vse8.v, 8, 0xa0,  8  + tdat );
  TEST_VSE_OP( 5, vle8.v, vse8.v, 8, 0x0a,  12 + tdat );
  TEST_VSE_OP( 6, vle8.v, vse8.v, 8, 0xaa,  -12 + tdat8 );
  TEST_VSE_OP( 7, vle8.v, vse8.v, 8, 0x00,  -8  + tdat8 );
  TEST_VSE_OP( 8, vle8.v, vse8.v, 8, 0xa0,  -4  + tdat8 );
  TEST_VSE_OP( 9, vle8.v, vse8.v, 8, 0x0a,  0   + tdat8 );

  #-------------------------------------------------------------
  # vse16
  #-------------------------------------------------------------

  TEST_VSE_OP( 10, vle16.v, vse16.v, 16, 0x00aa,  0  + tdat );
  TEST_VSE_OP( 11, vle16.v, vse16.v, 16, 0xaa00,  4  + tdat );
  TEST_VSE_OP( 12, vle16.v, vse16.v, 16, 0x0aa0,  8  + tdat );
  TEST_VSE_OP( 13, vle16.v, vse16.v, 16, 0xa00a,  12 + tdat );
  TEST_VSE_OP( 14, vle16.v, vse16.v, 16, 0x00aa,  -12 + tdat8 );
  TEST_VSE_OP( 15, vle16.v, vse16.v, 16, 0xaa00,  -8  + tdat8 );
  TEST_VSE_OP( 16, vle16.v, vse16.v, 16, 0x0aa0,  -4  + tdat8 );
  TEST_VSE_OP( 17, vle16.v, vse16.v, 16, 0xa00a,  0   + tdat8 );

  #-------------------------------------------------------------
  # vse32
  #-------------------------------------------------------------

  TEST_VSE_OP( 18, vle32.v, vse32.v, 32, 0x00aa00aa,  0  + tdat );
  TEST_VSE_OP( 19, vle32.v, vse32.v, 32, 0xaa00aa00,  4  + tdat );
  TEST_VSE_OP( 20, vle32.v, vse32.v, 32, 0x0aa00aa0,  8  + tdat );
  TEST_VSE_OP( 21, vle32.v, vse32.v, 32, 0xa00aa00a,  12 + tdat );
  TEST_VSE_OP( 22, vle32.v, vse32.v, 32, 0x00aa00aa,  -12 + tdat8 );
  TEST_VSE_OP( 23, vle32.v, vse32.v, 32, 0xaa00aa00,  -8  + tdat8 );
  TEST_VSE_OP( 24, vle32.v, vse32.v, 32, 0x0aa00aa0,  -4  + tdat8 );
  TEST_VSE_OP( 25, vle32.v, vse32.v, 32, 0xa00aa00a,  0   + tdat8 );

  #-------------------------------------------------------------
  # vse64
  # Only support when VSEW >= 64
  #-------------------------------------------------------------

#if __riscv_vsew >= 64

  TEST_VSE_OP( 26, vle64.v, vse64.v, 64, 0xaa00aa0000aa00aa,  0  + tdat );
  TEST_VSE_OP( 27, vle64.v, vse64.v, 64, 0xa00aa00a0aa00aa0,  8  + tdat );
  TEST_VSE_OP( 28, vle64.v, vse64.v, 64, 0xaa00aa0000aa00aa,  -12 + tdat8 );
  TEST_VSE_OP( 29, vle64.v, vse64.v, 64, 0xa00aa00a0aa00aa0,  -4  + tdat8 );

#endif

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
