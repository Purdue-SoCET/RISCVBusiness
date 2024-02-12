# See LICENSE for license details.

#*****************************************************************************
# vle.S
#-----------------------------------------------------------------------------
#
# Test vle, vleff instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vle8
  #-------------------------------------------------------------

  TEST_VLE_OP( 2, vle8.v, 8, 0xff, 0x0, 0  + tdat );
  TEST_VLE_OP( 3, vle8.v, 8, 0x00, 0xff, 4  + tdat );
  TEST_VLE_OP( 4, vle8.v, 8, 0xf0, 0x0f, 8  + tdat );
  TEST_VLE_OP( 5, vle8.v, 8, 0x0f, 0xf0, 12 + tdat );
  TEST_VLE_OP( 6, vle8.v, 8, 0xff, 0x00, -12 + tdat4 );
  TEST_VLE_OP( 7, vle8.v, 8, 0x00, 0xff, -8  + tdat4 );
  TEST_VLE_OP( 8, vle8.v, 8, 0xf0, 0x0f, -4  + tdat4 );
  TEST_VLE_OP( 9, vle8.v, 8, 0x0f, 0xf0,  0  + tdat4 );

  #-------------------------------------------------------------
  # vle16
  #-------------------------------------------------------------

  TEST_VLE_OP( 10, vle16.v, 16, 0x00ff, 0x00ff, 0  + tdat );
  TEST_VLE_OP( 11, vle16.v, 16, 0xff00, 0xff00, 4  + tdat );
  TEST_VLE_OP( 12, vle16.v, 16, 0x0ff0, 0x0ff0, 8  + tdat );
  TEST_VLE_OP( 13, vle16.v, 16, 0xf00f, 0xf00f, 12 + tdat );
  TEST_VLE_OP( 14, vle16.v, 16, 0x00ff, 0x00ff, -12 + tdat4 );
  TEST_VLE_OP( 15, vle16.v, 16, 0xff00, 0xff00, -8  + tdat4 );
  TEST_VLE_OP( 16, vle16.v, 16, 0x0ff0, 0x0ff0, -4  + tdat4 );
  TEST_VLE_OP( 17, vle16.v, 16, 0xf00f, 0xf00f,  0  + tdat4 );
  
  #-------------------------------------------------------------
  # vle32
  #-------------------------------------------------------------

  TEST_VLE_OP( 18, vle32.v, 32, 0x00ff00ff, 0xff00ff00, 0  + tdat );
  TEST_VLE_OP( 19, vle32.v, 32, 0xff00ff00, 0x0ff00ff0, 4  + tdat );
  TEST_VLE_OP( 20, vle32.v, 32, 0x0ff00ff0, 0xf00ff00f, 8  + tdat );
  TEST_VLE_OP( 21, vle32.v, 32, 0xf00ff00f, 0x00ff00ff, 12 + tdat );
  TEST_VLE_OP( 22, vle32.v, 32, 0x00ff00ff, 0xff00ff00, -12 + tdat4 );
  TEST_VLE_OP( 23, vle32.v, 32, 0xff00ff00, 0x0ff00ff0, -8  + tdat4 );
  TEST_VLE_OP( 24, vle32.v, 32, 0x0ff00ff0, 0xf00ff00f, -4  + tdat4 );
  TEST_VLE_OP( 25, vle32.v, 32, 0xf00ff00f, 0x00ff00ff,  0  + tdat4 );

  #-------------------------------------------------------------
  # vle64
  #-------------------------------------------------------------

  #TEST_VLE_OP( 26, vle64.v, 64, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 0 + tdat );
  #TEST_VLE_OP( 27, vle64.v, 64, 0xf00ff00f0ff00ff0, 0xff00ff0000ff00ff, 8 + tdat );
  #TEST_VLE_OP( 28, vle64.v, 64, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, -12 + tdat4 );
  #TEST_VLE_OP( 29, vle64.v, 64, 0xf00ff00f0ff00ff0, 0xff00ff0000ff00ff, -4  + tdat4 );
  
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
