# See LICENSE for license details.

#*****************************************************************************
# vsxseg.S
#-----------------------------------------------------------------------------
#
# Test vsuxseg, vsoxseg instruction.
# vsuxseg64 only support when VSEW >= 64
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET
  
  #-------------------------------------------------------------
  # vsuxseg3ei8
  #-------------------------------------------------------------

  #TEST_VSXSEG1_OP( 2, vluxseg1ei8.v, vsuxseg1ei8.v, 8, 0x00ff00ff, 0  + tdat, idx8dat );
  TEST_VSXSEG1_OP( 3, vluxseg2ei8.v, vsuxseg2ei8.v, 8, 0xf00ff00f, 16 + tdat, idx8dat );
  TEST_VSXSEG3_OP( 4, vluxseg3ei8.v, vsuxseg3ei8.v, 8, 0x00ff00ff, 0xff00ff00, 0x0ff00ff0, -16 + tdat5, idx8dat);
  TEST_VSXSEG3_OP( 5, vluxseg4ei8.v, vsuxseg4ei8.v, 8, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  0  + tdat5, idx8dat);
  TEST_VSXSEG3_OP( 6, vluxseg5ei8.v, vsuxseg5ei8.v, 8, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  0  + tdat5, idx8dat);
  TEST_VSXSEG3_OP( 7, vluxseg6ei8.v, vsuxseg6ei8.v, 8, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  0  + tdat5, idx8dat);
  TEST_VSXSEG3_OP( 8, vluxseg7ei8.v, vsuxseg7ei8.v, 8, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  0  + tdat5, idx8dat);
  TEST_VSXSEG3_OP( 9, vluxseg8ei8.v, vsuxseg8ei8.v, 8, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  0  + tdat5, idx8dat);

  #-------------------------------------------------------------
  # vsuxseg3ei16
  #-------------------------------------------------------------

  #TEST_VSXSEG1_OP(10, vluxseg1ei16.v, vsuxseg1ei16.v, 16, 0x00ff00ff, 0  + tdat, idx16dat );
  TEST_VSXSEG1_OP(11, vluxseg2ei16.v, vsuxseg2ei16.v, 16, 0xf00ff00f, 16 + tdat, idx16dat );
  TEST_VSXSEG3_OP(12, vluxseg3ei16.v, vsuxseg3ei16.v, 16, 0x00ff00ff, 0xff00ff00, 0x0ff00ff0, -16 + tdat5, idx16dat);
  TEST_VSXSEG3_OP(13, vluxseg4ei16.v, vsuxseg4ei16.v, 16, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  0  + tdat5, idx16dat);
  TEST_VSXSEG3_OP(14, vluxseg5ei16.v, vsuxseg5ei16.v, 16, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  0  + tdat5, idx16dat);
  TEST_VSXSEG3_OP(15, vluxseg6ei16.v, vsuxseg6ei16.v, 16, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  0  + tdat5, idx16dat);
  TEST_VSXSEG3_OP(16, vluxseg7ei16.v, vsuxseg7ei16.v, 16, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  0  + tdat5, idx16dat);
  TEST_VSXSEG3_OP(17, vluxseg8ei16.v, vsuxseg8ei16.v, 16, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  0  + tdat5, idx16dat);

  #-------------------------------------------------------------
  # vsuxseg3ei32
  #-------------------------------------------------------------

  #TEST_VSXSEG1_OP(18, vluxseg1ei32.v, vsuxseg1ei32.v, 32, 0x00ff00ff, 0  + tdat, idx32dat );
  TEST_VSXSEG1_OP(19, vluxseg2ei32.v, vsuxseg2ei32.v, 32, 0xf00ff00f, 16 + tdat, idx32dat );
  TEST_VSXSEG3_OP(20, vluxseg3ei32.v, vsuxseg3ei32.v, 32, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  16 + tdat, idx32dat );
  TEST_VSXSEG3_OP(21, vluxseg4ei32.v, vsuxseg4ei32.v, 32, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  16 + tdat, idx32dat );
  TEST_VSXSEG3_OP(22, vluxseg5ei32.v, vsuxseg5ei32.v, 32, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  16 + tdat, idx32dat );
  TEST_VSXSEG3_OP(23, vluxseg6ei32.v, vsuxseg6ei32.v, 32, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  16 + tdat, idx32dat );
  TEST_VSXSEG3_OP(24, vluxseg7ei32.v, vsuxseg7ei32.v, 32, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  16 + tdat, idx32dat );
  TEST_VSXSEG3_OP(25, vluxseg8ei32.v, vsuxseg8ei32.v, 32, 0xf00ff00f, 0xf00ff00f, 0x0ff00ff0,  16 + tdat, idx32dat );

  #-------------------------------------------------------------
  # vsuxseg3ei64
  # Only support when VSEW >= 64
  # In spike, when emul=1, vstore_3nf_seg will invlove 6 register, can't pass test
  #-------------------------------------------------------------

#if __riscv_vsew >= 64

  #TEST_VSXSEG_OP(26, vluxseg3ei64.v, vsuxseg3ei64.v, 64, 0x00ff00ff, 0xff00ff00, 0x0ff00ff0,  0  + tdat, idx64dat );

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

idx8dat:
idx8dat1:  .byte 0
idx8dat2:  .byte 1
idx8dat3:  .byte 2
idx8dat4:  .byte 3
idx8dat5:  .word 0x00000000
idx8dat6:  .word 0x00000000
idx8dat7:  .word 0x00000000

idx16dat:
idx16dat1:  .word 0x00010000
idx16dat2:  .word 0x00030002
idx16dat3:  .word 0x00050004
idx16dat4:  .word 0x00070006

idx32dat:
idx32dat1:  .word 0x00000000
idx32dat2:  .word 0x00000001
idx32dat3:  .word 0x00000002
idx32dat4:  .word 0x00000003

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
