# See LICENSE for license details.

#*****************************************************************************
# vseg_mem.S
#-----------------------------------------------------------------------------
#
# Test vector segmented memory operations 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
  
  //** Test simple unit segment load/stores ***//
    vsetivli x10, 4, e32, m1

    la x1, ldat
    vlseg2e32.v v1, 0(x1)

    la x2, sdat
    vsseg2e32.v v1, 0(x2)
   
    // first seg
    lw x3, 0(x2)
    TEST_CASE(1, x3, 0x11, NOP); 

    addi x2, x2, 4
    lw x3, 0(x2)
    TEST_CASE(2, x3, 0x12, NOP);
    
    // second seg 
    addi x2, x2, 4
    lw x3, 0(x2)
    TEST_CASE(3, x3, 0x21, NOP);

    
    addi x2, x2, 4
    lw x3, 0(x2)
    TEST_CASE(4, x3, 0x22, NOP);


    // third seg 
    addi x2, x2, 4
    lw x3, 0(x2)
    TEST_CASE(5, x3, 0x31, NOP);

    addi x2, x2, 4
    lw x3, 0(x2)
    TEST_CASE(6, x3, 0x32, NOP);

    // fourth seg 
    addi x2, x2, 4
    lw x3, 0(x2)
    TEST_CASE(7, x3, 0x41, NOP);

    addi x2, x2, 4
    lw x3, 0(x2)
    TEST_CASE(8, x3, 0x42, NOP);      
  

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

  ldat: 
  // first seg
  .word 0x11
  .word 0X12

  // second seg 
  .word 0x21
  .word 0X22

  // third seg 
  .word 0x31
  .word 0X32

   // fourth seg 
  .word 0x41
  .word 0X42


  sdat: 
  // first seg
  .word 0x00
  .word 0X00

  // second seg 
  .word 0x00
  .word 0X00

  // third seg 
  .word 0x00
  .word 0X00

   // fourth seg 
  .word 0x00
  .word 0X00



RVTEST_DATA_END
