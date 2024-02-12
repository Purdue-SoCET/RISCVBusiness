# See LICENSE for license details.

#*****************************************************************************
# vlre.S
#-----------------------------------------------------------------------------
#
# Test vl<nf>re<eew>.v  instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vl<nf>re8
  #-------------------------------------------------------------

  TEST_VLRE1_OP( 2, vl1re8.v, 8, 0xff00ff0000ff00ff, 0  + tdat );
  TEST_VLRE2_OP( 3, vl2re8.v, 8, 0x0f, 0x00,  12 + tdat );
  TEST_VLRE2_OP( 4, vl4re8.v, 8, 0xff, 0xff, -12 + tdat4 );
  TEST_VLRE2_OP( 5, vl8re8.v, 8, 0x0f, 0x00,  0  + tdat4 );
  TEST_VLRE2_OP( 6, vl2r.v, 8, 0xff, 0xff,  0  + tdat );

  #-------------------------------------------------------------
  # vl<nf>re16
  #-------------------------------------------------------------

  TEST_VLRE1_OP( 7, vl1re16.v, 16, 0xff00ff0000ff00ff, 0  + tdat );
  TEST_VLRE2_OP( 8, vl2re16.v, 16, 0x0ff0, 0x00ff,  8  + tdat );
  TEST_VLRE2_OP( 9, vl4re16.v, 16, 0x00ff, 0x00ff, -12 + tdat4 );
  TEST_VLRE2_OP(10, vl8re16.v, 16, 0x0ff0, 0x00ff, -4  + tdat4 );
  
  #-------------------------------------------------------------
  # vl<nf>re32
  #-------------------------------------------------------------

  TEST_VLRE1_OP(11, vl1re32.v, 32, 0xff00ff0000ff00ff, 0  + tdat );
  TEST_VLRE2_OP(12, vl2re32.v, 32, 0x00ff00ff, 0x00ff00ff,  0  + tdat );
  TEST_VLRE2_OP(13, vl4re32.v, 32, 0xff00ff00, 0x0ff00ff0, -8  + tdat4 );
  TEST_VLRE2_OP(14, vl8re32.v, 32, 0xff00ff00, 0x0ff00ff0, -8  + tdat4 );

  #-------------------------------------------------------------
  # vl<nf>re64
  # In spike, when emul=1, vl2re64 will invlove 6 register, can't pass test
  #-------------------------------------------------------------

  #TEST_VLRE_OP(14, vl2re64.v, 64, 0xff00ff0000ff00ff, 0x0ff00ff000ff00ff, 0  + tdat );

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
tdat7:  .word 0x00ff00ff
tdat8:  .word 0xff00ff00

RVTEST_DATA_END
