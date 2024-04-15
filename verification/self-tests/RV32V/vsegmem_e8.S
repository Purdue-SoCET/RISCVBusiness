# See LICENSE for license details.

#*****************************************************************************
# vsegmem_e8.S
#-----------------------------------------------------------------------------
#
# Test vector segmented memory operations 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
  
  //** complex strided seg load/store ***//
    li x11, 30
    vsetvli x10, x11, e8, m2

    // load mask
    la x1, v0_load
    vlm.v v0, 0(x1)

    la x1, ldat # base
    li x11, 4 # stride
    vlsseg3e8.v v2, 0(x1), x11, v0.t

    la x2, sdat
    vssseg3e8.v v2, 0(x2), x11, v0.t
   
lw x3, 0(x2)
TEST_CASE(1, x3, 0x00010101, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(2, x3, 0x00020202, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(3, x3, 0x00030303, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(4, x3, 0x00040404, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(5, x3, 0x00050505, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(6, x3, 0x00060606, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(7, x3, 0x00070707, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(8, x3, 0x00080808, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(9, x3, 0x00090909, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(10, x3, 0x00101010, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(11, x3, 0x00111111, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(12, x3, 0x00121212, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(13, x3, 0x00131313, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(14, x3, 0x00141414, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(15, x3, 0x00151515, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(16, x3, 0x00161616, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(17, x3, 0x00171717, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(18, x3, 0x00181818, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(19, x3, 0x00191919, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(20, x3, 0x00202020, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(21, x3, 0x00212121, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(22, x3, 0x00222222, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(23, x3, 0x00232323, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(24, x3, 0x00242424, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(25, x3, 0x00252525, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(26, x3, 0x00262626, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(27, x3, 0x00272727, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(28, x3, 0x00282828, NOP)


addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(29, x3, 0x00292929, NOP)

// remaining 3 segments: should be masked 
addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(30, x3, 0, NOP)

addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(31, x3, 0, NOP)

addi x2, x2, 4
lw x3, 0(x2)
TEST_CASE(32, x3, 0, NOP)





  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA
  v0_load:
  .word 0x1FFFFFFF

ldat: 
// segment1
.byte 0x01
.byte 0x01
.byte 0x01
.byte 0

// segment2
.byte 0x02
.byte 0x02
.byte 0x02
.byte 0

// segment3
.byte 0x03
.byte 0x03
.byte 0x03
.byte 0

// segment4
.byte 0x04
.byte 0x04
.byte 0x04
.byte 0

// segment5
.byte 0x05
.byte 0x05
.byte 0x05
.byte 0

// segment6
.byte 0x06
.byte 0x06
.byte 0x06
.byte 0

// segment7
.byte 0x07
.byte 0x07
.byte 0x07
.byte 0

// segment8
.byte 0x08
.byte 0x08
.byte 0x08
.byte 0

// segment9
.byte 0x09
.byte 0x09
.byte 0x09
.byte 0

// segment10
.byte 0x10
.byte 0x10
.byte 0x10
.byte 0

// segment11
.byte 0x11
.byte 0x11
.byte 0x11
.byte 0

// segment12
.byte 0x12
.byte 0x12
.byte 0x12
.byte 0

// segment13
.byte 0x13
.byte 0x13
.byte 0x13
.byte 0

// segment14
.byte 0x14
.byte 0x14
.byte 0x14
.byte 0

// segment15
.byte 0x15
.byte 0x15
.byte 0x15
.byte 0

// segment16
.byte 0x16
.byte 0x16
.byte 0x16
.byte 0

// segment17
.byte 0x17
.byte 0x17
.byte 0x17
.byte 0

// segment18
.byte 0x18
.byte 0x18
.byte 0x18
.byte 0

// segment19
.byte 0x19
.byte 0x19
.byte 0x19
.byte 0

// segment20
.byte 0x20
.byte 0x20
.byte 0x20
.byte 0

// segment21
.byte 0x21
.byte 0x21
.byte 0x21
.byte 0

// segment22
.byte 0x22
.byte 0x22
.byte 0x22
.byte 0

// segment23
.byte 0x23
.byte 0x23
.byte 0x23
.byte 0

// segment24
.byte 0x24
.byte 0x24
.byte 0x24
.byte 0

// segment25
.byte 0x25
.byte 0x25
.byte 0x25
.byte 0

// segment26
.byte 0x26
.byte 0x26
.byte 0x26
.byte 0

// segment27
.byte 0x27
.byte 0x27
.byte 0x27
.byte 0

// segment28
.byte 0x28
.byte 0x28
.byte 0x28
.byte 0

// segment29
.byte 0x29
.byte 0x29
.byte 0x29
.byte 0

// segment30
.byte 0x30
.byte 0x30
.byte 0x30
.byte 0

// segment31
.byte 0x31
.byte 0x31
.byte 0x31
.byte 0

// segment32
.byte 0x32
.byte 0x32
.byte 0x32
.byte 0


sdat: 
// segment1
.byte 0
.byte 0
.byte 0
.byte 0

// segment2
.byte 0
.byte 0
.byte 0
.byte 0

// segment3
.byte 0
.byte 0
.byte 0
.byte 0

// segment4
.byte 0
.byte 0
.byte 0
.byte 0

// segment5
.byte 0
.byte 0
.byte 0
.byte 0

// segment6
.byte 0
.byte 0
.byte 0
.byte 0

// segment7
.byte 0
.byte 0
.byte 0
.byte 0

// segment8
.byte 0
.byte 0
.byte 0
.byte 0

// segment9
.byte 0
.byte 0
.byte 0
.byte 0

// segment10
.byte 0
.byte 0
.byte 0
.byte 0

// segment11
.byte 0
.byte 0
.byte 0
.byte 0

// segment12
.byte 0
.byte 0
.byte 0
.byte 0

// segment13
.byte 0
.byte 0
.byte 0
.byte 0

// segment14
.byte 0
.byte 0
.byte 0
.byte 0

// segment15
.byte 0
.byte 0
.byte 0
.byte 0

// segment16
.byte 0
.byte 0
.byte 0
.byte 0

// segment17
.byte 0
.byte 0
.byte 0
.byte 0

// segment18
.byte 0
.byte 0
.byte 0
.byte 0

// segment19
.byte 0
.byte 0
.byte 0
.byte 0

// segment20
.byte 0
.byte 0
.byte 0
.byte 0

// segment21
.byte 0
.byte 0
.byte 0
.byte 0

// segment22
.byte 0
.byte 0
.byte 0
.byte 0

// segment23
.byte 0
.byte 0
.byte 0
.byte 0

// segment24
.byte 0
.byte 0
.byte 0
.byte 0

// segment25
.byte 0
.byte 0
.byte 0
.byte 0

// segment26
.byte 0
.byte 0
.byte 0
.byte 0

// segment27
.byte 0
.byte 0
.byte 0
.byte 0

// segment28
.byte 0
.byte 0
.byte 0
.byte 0

// segment29
.byte 0
.byte 0
.byte 0
.byte 0

// segment30
.byte 0
.byte 0
.byte 0
.byte 0

// segment31
.byte 0
.byte 0
.byte 0
.byte 0

// segment32
.byte 0
.byte 0
.byte 0
.byte 0






RVTEST_DATA_END
