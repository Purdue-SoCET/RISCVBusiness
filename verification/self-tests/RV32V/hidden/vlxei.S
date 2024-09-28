# See LICENSE for license details.

#*****************************************************************************
# vlxei.S
#-----------------------------------------------------------------------------
#
# Test vluxei, vloxei instruction.
#

#include "riscv_test.h"
#include "test_macros_vector.h"

RVTEST_RV64UV
RVTEST_CODE_BEGIN
RVTEST_VSET

  #-------------------------------------------------------------
  # vluxei8
  #-------------------------------------------------------------

  TEST_VLXEI_OP( 2, vluxei8.v, 8, 0x00ff00ff, 0xff00ff00, 0  + tdat , idx8dat );
  TEST_VLXEI_OP( 3, vluxei8.v, 8, 0xff00ff00, 0x0ff00ff0, 4  + tdat , idx8dat );
  TEST_VLXEI_OP( 4, vluxei8.v, 8, 0x0ff00ff0, 0xf00ff00f, 8  + tdat , idx8dat );
  TEST_VLXEI_OP( 5, vluxei8.v, 8, 0xf00ff00f, 0x00ff00ff, 12 + tdat , idx8dat );
  TEST_VLXEI_OP( 6, vluxei8.v, 8, 0x00ff00ff, 0xff00ff00, -12 + tdat4 , idx8dat );
  TEST_VLXEI_OP( 7, vluxei8.v, 8, 0xff00ff00, 0x0ff00ff0, -8  + tdat4 , idx8dat );
  TEST_VLXEI_OP( 8, vluxei8.v, 8, 0x0ff00ff0, 0xf00ff00f, -4  + tdat4 , idx8dat );
  TEST_VLXEI_OP( 9, vluxei8.v, 8, 0xf00ff00f, 0x00ff00ff,  0  + tdat4 , idx8dat );

  #-------------------------------------------------------------
  # vluxei16
  #-------------------------------------------------------------

  TEST_VLXEI_OP( 10, vluxei16.v, 16, 0x00ff00ff, 0xff00ff00, 0  + tdat , idx16dat );
  TEST_VLXEI_OP( 11, vluxei16.v, 16, 0xff00ff00, 0x0ff00ff0, 4  + tdat , idx16dat );
  TEST_VLXEI_OP( 12, vluxei16.v, 16, 0x0ff00ff0, 0xf00ff00f, 8  + tdat , idx16dat );
  TEST_VLXEI_OP( 13, vluxei16.v, 16, 0xf00ff00f, 0x00ff00ff, 12 + tdat , idx16dat );
  TEST_VLXEI_OP( 14, vluxei16.v, 16, 0x00ff00ff, 0xff00ff00, -12 + tdat4 , idx16dat );
  TEST_VLXEI_OP( 15, vluxei16.v, 16, 0xff00ff00, 0x0ff00ff0, -8  + tdat4 , idx16dat );
  TEST_VLXEI_OP( 16, vluxei16.v, 16, 0x0ff00ff0, 0xf00ff00f, -4  + tdat4 , idx16dat );
  TEST_VLXEI_OP( 17, vluxei16.v, 16, 0xf00ff00f, 0x00ff00ff,  0  + tdat4 , idx16dat );
  
  #-------------------------------------------------------------
  # vluxei32
  #-------------------------------------------------------------

  TEST_VLXEI_OP( 18, vluxei32.v, 32, 0x00ff00ff, 0xff00ff00, 0  + tdat , idx32dat );
  TEST_VLXEI_OP( 19, vluxei32.v, 32, 0xff00ff00, 0x0ff00ff0, 4  + tdat , idx32dat );
  TEST_VLXEI_OP( 20, vluxei32.v, 32, 0x0ff00ff0, 0xf00ff00f, 8  + tdat , idx32dat );
  TEST_VLXEI_OP( 21, vluxei32.v, 32, 0xf00ff00f, 0x00ff00ff, 12 + tdat , idx32dat );
  TEST_VLXEI_OP( 22, vluxei32.v, 32, 0x00ff00ff, 0xff00ff00, -12 + tdat4 , idx32dat );
  TEST_VLXEI_OP( 23, vluxei32.v, 32, 0xff00ff00, 0x0ff00ff0, -8  + tdat4 , idx32dat );
  TEST_VLXEI_OP( 24, vluxei32.v, 32, 0x0ff00ff0, 0xf00ff00f, -4  + tdat4 , idx32dat );
  TEST_VLXEI_OP( 25, vluxei32.v, 32, 0xf00ff00f, 0x00ff00ff,  0  + tdat4 , idx32dat );

  #-------------------------------------------------------------
  # vluxei64
  #-------------------------------------------------------------

  #TEST_VLXEI_OP( 26, vluxei64.v, 64, 0x00ff00ff, 0xff00ff00, 0  + tdat , idx64dat );
  #TEST_VLXEI_OP( 27, vluxei64.v, 64, 0x0ff00ff0, 0xf00ff00f, 8  + tdat , idx64dat );
  #TEST_VLXEI_OP( 28, vluxei64.v, 64, 0x00ff00ff, 0xff00ff00, -12 + tdat4 , idx64dat );
  #TEST_VLXEI_OP( 29, vluxei64.v, 64, 0x0ff00ff0, 0xf00ff00f, -4  + tdat4 , idx64dat );
  
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
