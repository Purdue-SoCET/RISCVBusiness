# See LICENSE for license details.

#*****************************************************************************
# tests_rv32b.S
#-----------------------------------------------------------------------------
#
# Test all instruction.
#

#include "/home/asicfab/a/socet94/RISCVBusiness/verification/asm-env/selfasm/riscv_test.h"
#include "/home/asicfab/a/socet94/RISCVBusiness/verification/asm-env/selfasm/test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  #TEST_RR_OP( 2, div,  3,  20,   6 );
  #TEST_RR_OP( 3, div, -3, -20,   6 );
  #TEST_RR_OP( 4, div, -3,  20,  -6 );
  #TEST_RR_OP( 5, div,  3, -20,  -6 );

  #TEST_RR_OP( 6, div, -1<<31, -1<<31,  1 );
  #TEST_RR_OP( 7, div, -1<<31, -1<<31, -1 );

  #TEST_RR_OP( 8, div, -1, -1<<31, 0 );
  #TEST_RR_OP( 9, div, -1,      1, 0 );
  #TEST_RR_OP(10, div, -1,      0, 0 );
  
  #TEST_IMM_OP( testnum, inst, result, val1, imm ) \
  #TEST_RR_OP( testnum, inst, result, val1, val2 )
  #TEST_RR_OP( 1, add.uw,  26,  20,   6 );
  TEST_RR_OP( 1, andn,  48,  50,   14 );
  TEST_RR_OP( 2, bclr,  48,  50,   1 );
  TEST_IMM_OP( 3, bclri,  48,  50,   1 );
  TEST_RR_OP( 4, bext,  1,  50,   4 );
  TEST_IMM_OP( 5, bexti,  1,  50,   5 );
  TEST_RR_OP( 6, binv,  48,  50,   1 );
  TEST_IMM_OP( 7, binvi,  48,  50,   1 );
  TEST_RR_OP( 8, bset,  50,  50,   1 );
  TEST_IMM_OP( 9, bseti,  50,  50,   1 );
  TEST_RR_OP( 10, clmul,  46,  6,   13 );
  TEST_RR_OP( 11, clmulh,  0,  6,   13 );
  #TEST_RR_OP( 12, clmulr,  2,  6,   13 ); // Check again
  ### CLZ
    li  x1, 51; 
    clz x3, x1; 
    li  x29, 26; 
    li  TESTNUM, 13; 
    bne x3, x29, fail;
  #### CLZW
  #  li  x1, 51; 
  #  clzw x3, x1; 
  #  li  x29, 28; 
  #  li  TESTNUM, 15; 
  #  bne x3, x29, fail;
  ## CPOP
    li  x1, 51; 
    cpop x3, x1; 
    li  x29, 4; 
    li  TESTNUM, 14; 
    bne x3, x29, fail;
  ### CPOPW
  #  li  x1, 51; 
  #  cpopw x3, x1; 
  #  li  x29, 4; 
  #  li  TESTNUM, 17; 
  #  bne x3, x29, fail;
  ## CTZ
    li  x1, 64000; 
    ctz x3, x1; 
    li  x29, 9; 
    li  TESTNUM, 15; 
    bne x3, x29, fail;
  ### CTZW
  #  li  x1, 64000; 
  #  ctzw x3, x1; 
  #  li  x29, 9; 
  #  li  TESTNUM, 19; 
  #  bne x3, x29, fail;
  # MAX (instr rd,rs1,rs2) 
  TEST_RR_OP( 16, max, 0x0000ffff, 0xffff0000, 0x0000ffff );
  TEST_RR_OP( 17, maxu,  13,  6,   13 );
  TEST_RR_OP( 18, min,0xf000000f,  0xf000000f, 0x0000000f );
  TEST_RR_OP( 19, minu,  6,  6,   13 );
  ## orc.b
    li  x1, 0xf0f0f0f0;  
    orc.b x3, x1; 
    li  x29, 0xffffffff;  // Result is the immediate value
    li  TESTNUM, 20; 
    bne x3, x29, fail;
  TEST_RR_OP( 21, orn,0x0000ffff,0x0000ff00,0xffffff00);
  ## rev8
    li  x1, 0xff0277f0;  
    rev8 x3, x1; 
    li  x29, 0xf07702ff;  // Result is the immediate value
    li  TESTNUM, 22; 
    bne x3, x29, fail;
  TEST_RR_OP( 23, rol,0x1001ff00,0xff001001,0x10);
  #TEST_RR_OP( 28, rolw,0x1001ff00,0xff001001,0x10);
  TEST_RR_OP( 24, ror,0x1001ff00,0xff001001,0x10);
  ## rori
    li  x1, 0xff001001;  
    rori x3,x1,0x10; 
    li  x29, 0x1001ff00;  // Result is the immediate value
    li  TESTNUM, 25; 
    bne x3, x29, fail;
  ### roriw
  #  li  x1, 0xff001001;  
  #  roriw x3,x1,0x10; 
  #  li  x29, 0x1001ff00;  // Result is the immediate value
  #  li  TESTNUM, 31; 
  #  bne x3, x29, fail;
  #TEST_RR_OP( 32, rorw,0x1001ff00,0xff001001,0x10); //Check again
  ## sext.b
    li  x1, 0xffffff00;  
    sext.b x3,x1; 
    li  x29, 0x00000000;  // Result is the immediate value
    li  TESTNUM, 26; 
    bne x3, x29, fail;
  ## sext.h
    li  x1, 0xffff0000;  
    sext.h x3,x1; 
    li  x29, 0x00000000;  // Result is the immediate value
    li  TESTNUM, 27; 
    bne x3, x29, fail;
  TEST_RR_OP( 28, sh1add,0x0000ff02,0x00000001,0x0000ff00); //Check again
  #TEST_RR_OP( 36, sh1add.uw,0x0000ff02,0x00000001,0x0000ff00); //Check again
  TEST_RR_OP( 29, sh2add,0x0000ff04,0x00000001,0x0000ff00); //Check again
  #TEST_RR_OP( 38, sh2add.uw,0x0000ff04,0x00000001,0x0000ff00); //Check again
  TEST_RR_OP( 30, sh3add,0x0000ff08,0x00000001,0x0000ff00); //Check again
  #TEST_RR_OP( 40, sh3add.uw,0x0000ff08,0x00000001,0x0000ff00); //Check again
  ### slli.uw
  #  li  x1, 0xffff0001;  
  #  slli.uw x3,x1,0x8; 
  #  li  x29, 0xff000100;  // Result is the immediate value
  #  li  TESTNUM, 42; 
  #  bne x3, x29, fail;
  TEST_RR_OP( 31, xnor,0x00000000,0x0000ffff,0xffff0000); //Check again
  ## zext.h
    li  x1, 0xffff0001;  
    zext.h x3,x1; 
    li  x29, 0x00000001;  // Result is the immediate value
    li  TESTNUM, 32; 
    bne x3, x29, fail;

  ##  li  x1, val1; 
  ##  li  x2, val2; 
  ##  inst x3, x1, x2; 
  ##  li  x29, correctval; 
  ##  li  TESTNUM, testnum; 
  ##  bne testreg, x29, fail;

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

