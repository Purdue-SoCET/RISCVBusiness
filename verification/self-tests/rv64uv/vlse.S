# See LICENSE for license details.

#*****************************************************************************
# vlse.S
#-----------------------------------------------------------------------------
#
# Test vlse instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vlse8
  #-------------------------------------------------------------

  TEST_VLSE_OP( 2, vlse8.v, 8, 0xff, 0x0,  1, 0  + tdat );
  TEST_VLSE_OP( 3, vlse8.v, 8, 0x00, 0xff, 1, 4  + tdat );
  TEST_VLSE_OP( 4, vlse8.v, 8, 0xf0, 0x0f, 1, 8  + tdat );
  TEST_VLSE_OP( 5, vlse8.v, 8, 0x0f, 0xf0, 1, 12 + tdat );
  TEST_VLSE_OP( 6, vlse8.v, 8, 0xff, 0x00, 1, -12 + tdat4 );
  TEST_VLSE_OP( 7, vlse8.v, 8, 0x00, 0xff, 1, -8  + tdat4 );
  TEST_VLSE_OP( 8, vlse8.v, 8, 0xf0, 0x0f, 1, -4  + tdat4 );
  TEST_VLSE_OP( 9, vlse8.v, 8, 0x0f, 0xf0, 1,  0  + tdat4 );

  #-------------------------------------------------------------
  # vlse16
  #-------------------------------------------------------------

  TEST_VLSE_OP( 10, vlse16.v, 16, 0x00ff, 0x00ff, 2, 0  + tdat );
  TEST_VLSE_OP( 11, vlse16.v, 16, 0xff00, 0xff00, 2, 4  + tdat );
  TEST_VLSE_OP( 12, vlse16.v, 16, 0x0ff0, 0x0ff0, 2, 8  + tdat );
  TEST_VLSE_OP( 13, vlse16.v, 16, 0xf00f, 0xf00f, 2, 12 + tdat );
  TEST_VLSE_OP( 14, vlse16.v, 16, 0x00ff, 0x00ff, 2, -12 + tdat4 );
  TEST_VLSE_OP( 15, vlse16.v, 16, 0xff00, 0xff00, 2, -8  + tdat4 );
  TEST_VLSE_OP( 16, vlse16.v, 16, 0x0ff0, 0x0ff0, 2, -4  + tdat4 );
  TEST_VLSE_OP( 17, vlse16.v, 16, 0xf00f, 0xf00f, 2,  0  + tdat4 );
  
  #-------------------------------------------------------------
  # vlse32
  #-------------------------------------------------------------

  TEST_VLSE_OP( 18, vlse32.v, 32, 0x00ff00ff, 0xff00ff00, 4, 0  + tdat );
  TEST_VLSE_OP( 19, vlse32.v, 32, 0xff00ff00, 0x0ff00ff0, 4, 4  + tdat );
  TEST_VLSE_OP( 20, vlse32.v, 32, 0x0ff00ff0, 0xf00ff00f, 4, 8  + tdat );
  TEST_VLSE_OP( 21, vlse32.v, 32, 0xf00ff00f, 0x00ff00ff, 4, 12 + tdat );
  TEST_VLSE_OP( 22, vlse32.v, 32, 0x00ff00ff, 0xff00ff00, 4, -12 + tdat4 );
  TEST_VLSE_OP( 23, vlse32.v, 32, 0xff00ff00, 0x0ff00ff0, 4, -8  + tdat4 );
  TEST_VLSE_OP( 24, vlse32.v, 32, 0x0ff00ff0, 0xf00ff00f, 4, -4  + tdat4 );
  TEST_VLSE_OP( 25, vlse32.v, 32, 0xf00ff00f, 0x00ff00ff, 4,  0  + tdat4 );

  #-------------------------------------------------------------
  # vlse64
  #-------------------------------------------------------------

  #TEST_VLSE_OP( 26, vlse64.v, 64, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 8, 0  + tdat );
  #TEST_VLSE_OP( 27, vlse64.v, 64, 0xf00ff00f0ff00ff0, 0xff00ff0000ff00ff, 8, 8  + tdat );
  #TEST_VLSE_OP( 28, vlse64.v, 64, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 8, -12 + tdat4 );
  #TEST_VLSE_OP( 29, vlse64.v, 64, 0xf00ff00f0ff00ff0, 0xff00ff0000ff00ff, 8, -4  + tdat4 );
  
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
tdat5:  .word 0x00ff00ff
tdat6:  .word 0xff00ff00
tdat7:  .word 0x0ff00ff0
tdat8:  .word 0xf00ff00f

RVTEST_DATA_END
