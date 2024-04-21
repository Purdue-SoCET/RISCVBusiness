# See LICENSE for license details.

#*****************************************************************************
# vsumsq.S
#-----------------------------------------------------------------------------
#
# Simple test to calculate sum of squares of array using vmacc and vredsum
# Originally written to replicate failed fetch latch flushing on a branch 
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U

RVTEST_CODE_BEGIN

    li x1, 20
    la x2, data

    // Initialize result registers
    vsetvli x5, zero, e32, m2
    vsub.vv v16, v16, v16
    vmv.s.x v0, zero

loop:
    vsetvli x5, x1, e32, m2
    sub x1, x1, x5        // Stripmine
    slli x6, x5, 2
    vle32.v v8, 0(x2)
    add x2, x2, x6        // Increment array ptr
    vmacc.vv v16, v8, v8
    bne x1, x0, loop

    // Reduce partial sums
    vsetvli x5, zero, e32, m2
    vredsum.vs v0, v16, v0 

    // Store result to memory
    vsetivli x5, 1, e32, m2
    la x3, result
    vse32.v v0, (x3)

    // Load and check result
    lw x4, 0(x3)
    TEST_CASE(1, x4, 2870, NOP)

    TEST_PASSFAIL

RVTEST_CODE_END

    .data

RVTEST_DATA_BEGIN

    TEST_DATA

data:
    .word 0x00000001
    .word 0x00000002
    .word 0x00000003
    .word 0x00000004
    .word 0x00000005
    .word 0x00000006
    .word 0x00000007
    .word 0x00000008
    .word 0x00000009
    .word 0x0000000a
    .word 0x0000000b
    .word 0x0000000c
    .word 0x0000000d
    .word 0x0000000e
    .word 0x0000000f
    .word 0x00000010
    .word 0x00000011
    .word 0x00000012
    .word 0x00000013
    .word 0x00000014
    .word 0x00000015
    .word 0x00000016
    .word 0x00000017
    .word 0x00000018
    .word 0x00000019
    .word 0x0000001a

result:
	  .word 0x55555555

RVTEST_DATA_END
