# See LICENSE for license details.

#*****************************************************************************
# vlxseg_64.S
#-----------------------------------------------------------------------------
#
# Test vluxseg<nf>ei<eew>.v instruction for RISCV_VSEW=64.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vluxseg<nf>ei8
  #-------------------------------------------------------------

  #TEST_VLXSEG1_OP( 2, vluxseg1ei8.v, 8, 0xff00ff0000ff00ff, 0  + tdat, idx8dat );
  TEST_VLXSEG1_OP( 3, vluxseg2ei8.v, 8, 0xff00ff0000ff00ff, 0  + tdat, idx8dat );
  TEST_VLXSEG3_OP( 4, vluxseg3ei8.v, 8, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 0x0ff00ff0f00ff00f,  0  + tdat,  idx8dat );
  TEST_VLXSEG3_OP( 5, vluxseg4ei8.v, 8, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  16 + tdat,  idx8dat );
  TEST_VLXSEG3_OP( 6, vluxseg5ei8.v, 8, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 0x0ff00ff0f00ff00f, -12 + tdat4, idx8dat );
  TEST_VLXSEG3_OP( 7, vluxseg6ei8.v, 8, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  4  + tdat4, idx8dat );
  TEST_VLXSEG3_OP( 8, vluxseg7ei8.v, 8, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  4  + tdat4, idx8dat );
  TEST_VLXSEG3_OP( 9, vluxseg8ei8.v, 8, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  4  + tdat4, idx8dat );

  #-------------------------------------------------------------
  # vluxseg<nf>ei16
  #-------------------------------------------------------------

  #TEST_VLXSEG1_OP(10, vluxseg1ei16.v, 16, 0x00ff00ff, 0  + tdat, idx16dat );
  TEST_VLXSEG1_OP(11, vluxseg2ei16.v, 16, 0xff00ff0000ff00ff, 0 + tdat, idx16dat );
  TEST_VLXSEG3_OP(12, vluxseg3ei16.v, 16, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 0x0ff00ff0f00ff00f,  0  + tdat,  idx16dat );
  TEST_VLXSEG3_OP(13, vluxseg4ei16.v, 16, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  16 + tdat,  idx16dat );
  TEST_VLXSEG3_OP(14, vluxseg5ei16.v, 16, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 0x0ff00ff0f00ff00f, -12 + tdat4, idx16dat );
  TEST_VLXSEG3_OP(15, vluxseg6ei16.v, 16, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  4  + tdat4, idx16dat );
  TEST_VLXSEG3_OP(16, vluxseg7ei16.v, 16, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  4  + tdat4, idx16dat );
  TEST_VLXSEG3_OP(17, vluxseg8ei16.v, 16, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  4  + tdat4, idx16dat );
  
  #-------------------------------------------------------------
  # vluxseg<nf>ei32
  #-------------------------------------------------------------

  #TEST_VLXSEG1_OP(18, vluxseg1ei32.v, 32, 0x00ff00ff, 0  + tdat, idx32dat);
  TEST_VLXSEG1_OP(19, vluxseg2ei32.v, 32, 0xff00ff0000ff00ff, 0 + tdat, idx32dat );
  TEST_VLXSEG3_OP(20, vluxseg3ei32.v, 32, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 0x0ff00ff0f00ff00f,  0  + tdat,  idx32dat );
  TEST_VLXSEG3_OP(21, vluxseg4ei32.v, 32, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  16 + tdat,  idx32dat );
  TEST_VLXSEG3_OP(22, vluxseg5ei32.v, 32, 0xff00ff0000ff00ff, 0xf00ff00f0ff00ff0, 0x0ff00ff0f00ff00f, -12 + tdat4, idx32dat );
  TEST_VLXSEG3_OP(23, vluxseg6ei32.v, 32, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  4  + tdat4, idx32dat );
  TEST_VLXSEG3_OP(24, vluxseg7ei32.v, 32, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  4  + tdat4, idx32dat );
  TEST_VLXSEG3_OP(25, vluxseg8ei32.v, 32, 0x0ff00ff0f00ff00f, 0x00ff00ffff00ff00, 0xff00ff0000ff00ff,  4  + tdat4, idx32dat );

  #-------------------------------------------------------------
  # vluxseg<nf>ei64
  # In spike, when emul=1, vstore_3nf_seg will invlove 6 register, can't pass test
  #-------------------------------------------------------------

  #TEST_VLXSEG3_OP(26, vluxseg3ei64.v, 64, 0x00ff00ff, 0xff00ff00, 0x0ff00ff0,  0  + tdat, idx64dat );

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
tdat5:  .word 0xf00ff00f
tdat6:  .word 0x0ff00ff0
tdat7:  .word 0xff00ff00
tdat8:  .word 0x00ff00ff
tdat9:  .word 0x00ff00ff
tdat10: .word 0xff00ff00
tdat11: .word 0x00000000
tdat12: .word 0x00000000

idx8dat:
idx8dat1:  .byte 0
idx8dat2:  .byte 4
idx8dat3:  .byte 8
idx8dat4:  .byte 12
idx8dat5:  .word 0x00000000
idx8dat6:  .word 0x00000000
idx8dat7:  .word 0x00000000

idx16dat:
idx16dat1:  .word 0x00040000
idx16dat2:  .word 0x000c0008
idx16dat3:  .word 0x00140010
idx16dat4:  .word 0x001c0018

idx32dat:
idx32dat1:  .word 0x00000000
idx32dat2:  .word 0x00000004
idx32dat3:  .word 0x00000008
idx32dat4:  .word 0x0000000c

idx64dat:
idx64dat1:  .word 0x00000000
idx64dat2:  .word 0x00000000
idx64dat3:  .word 0x00000004
idx64dat4:  .word 0x00000000
idx64dat5:  .word 0x00000008
idx64dat6:  .word 0x00000000
idx64dat7:  .word 0x0000000c
idx64dat8:  .word 0x00000000


RVTEST_DATA_END
