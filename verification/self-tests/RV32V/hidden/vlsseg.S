# See LICENSE for license details.

#*****************************************************************************
# vlsseg.S
#-----------------------------------------------------------------------------
#
# Test vlsseg instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vlsseg<nf>e8
  #-------------------------------------------------------------

  #TEST_VLSSEG1_OP( 2, vlsseg1e8.v, 8, 0xff, 1,  0  + tdat );
  TEST_VLSSEG1_OP( 3, vlsseg2e8.v, 8, 0xff, 1,  0  + tdat );
  TEST_VLSSEG3_OP( 4, vlsseg3e8.v, 8, 0xff, 0x00, 0xff, 1,  0  + tdat );
  TEST_VLSSEG3_OP( 5, vlsseg4e8.v, 8, 0x0f, 0xf0, 0x0f, 1,  12 + tdat );
  TEST_VLSSEG3_OP( 6, vlsseg5e8.v, 8, 0xff, 0x00, 0xff, 1, -12 + tdat4 );
  TEST_VLSSEG3_OP( 7, vlsseg6e8.v, 8, 0x0f, 0xf0, 0x0f, 1,  0  + tdat4 );
  TEST_VLSSEG3_OP( 8, vlsseg7e8.v, 8, 0x0f, 0xf0, 0x0f, 1,  0  + tdat4 );
  TEST_VLSSEG3_OP( 9, vlsseg8e8.v, 8, 0x0f, 0xf0, 0x0f, 1,  0  + tdat4 );

  #-------------------------------------------------------------
  # vlsseg<nf>e16
  #-------------------------------------------------------------

  #TEST_VLSSEG1_OP(10, vlsseg1e16.v, 16, 0x00ff, 2,  0  + tdat );
  TEST_VLSSEG1_OP(11, vlsseg2e16.v, 16, 0x00ff, 2,  0  + tdat );
  TEST_VLSSEG3_OP(12, vlsseg3e16.v, 16, 0x00ff, 0x00ff, 0xff00, 2,  0  + tdat );
  TEST_VLSSEG3_OP(13, vlsseg4e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f, 2,  8  + tdat );
  TEST_VLSSEG3_OP(14, vlsseg5e16.v, 16, 0x00ff, 0x00ff, 0xff00, 2, -12 + tdat4 );
  TEST_VLSSEG3_OP(15, vlsseg6e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f, 2, -4  + tdat4 );
  TEST_VLSSEG3_OP(16, vlsseg7e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f, 2, -4  + tdat4 );
  TEST_VLSSEG3_OP(17, vlsseg8e16.v, 16, 0x0ff0, 0x0ff0, 0xf00f, 2, -4  + tdat4 );
  
  #-------------------------------------------------------------
  # vlsseg<nf>e32
  #-------------------------------------------------------------

  #TEST_VLSSEG1_OP(18, vlsseg1e32.v, 32, 0x00ff00ff, 4,  0  + tdat );
  TEST_VLSSEG1_OP(19, vlsseg2e32.v, 32, 0x00ff00ff, 4,  0  + tdat );
  TEST_VLSSEG3_OP(20, vlsseg3e32.v, 32, 0x00ff00ff, 0xff00ff00, 0x0ff00ff0, 4,  0  + tdat );
  TEST_VLSSEG3_OP(21, vlsseg4e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );
  TEST_VLSSEG3_OP(22, vlsseg5e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );
  TEST_VLSSEG3_OP(23, vlsseg6e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );
  TEST_VLSSEG3_OP(24, vlsseg7e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );
  TEST_VLSSEG3_OP(25, vlsseg8e32.v, 32, 0xff00ff00, 0x0ff00ff0, 0xf00ff00f, 4, -8  + tdat4 );

  #-------------------------------------------------------------
  # vlsseg<nf>e64
  # In spike, when emul=1, vlsseg3e64 will invlove 6 register, can't pass test
  #-------------------------------------------------------------

  #TEST_VLSSEG3_OP(26, vlsseg3e64.v, 64, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 0x0ff00ff000ff00ff, 8, 0  + tdat );

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
tdat6:  .word 0x0ff00ff0

RVTEST_DATA_END
