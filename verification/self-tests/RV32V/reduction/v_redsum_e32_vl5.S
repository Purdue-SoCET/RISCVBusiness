# See LICENSE for license details.

#*****************************************************************************
# Test redsum, e32, vl5
#-----------------------------------------------------------------------------
#
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN
# Setup tasks
    li x7, 5
    vsetvli x8, x7, e32, m4

    la x1, in_data
    la x2, out_data

    add x3, x1, 16

    vl4re32.v v8, (x3)  # vs1[0] = 0x13121110

    vl4re32.v v16, (x1)  # vs2[*] = 0x1f ... 0x00

    vl4re32.v v24, (x2)  # vd[*] = 0x55 ... 0x55

# Reduction instruction
    vredsum.vs v24, v16, v8

# Dump result to memory
    vs4r.v v24, (x2)

# Load and check result word
    li x11, 0x4a443e38
    lw x12, 0(x2)
    li TESTNUM, 1
    bne x11, x12, fail

# Load and check other words
    li x11, 0x55555555
    lw x12, 4(x2)
    li TESTNUM, 2
    bne x11, x12, fail

    li x11, 0x55555555
    lw x12, 8(x2)
    li TESTNUM, 3
    bne x11, x12, fail

    li x11, 0x55555555
    lw x12, 12(x2)
    li TESTNUM, 4
    bne x11, x12, fail

TEST_PASSFAIL
RVTEST_CODE_END
    .data
RVTEST_DATA_BEGIN
TEST_DATA

    .align 8
in_data:
    .word 0x03020100
    .word 0x07060504
    .word 0x0b0a0908
    .word 0x0f0e0d0c
    .word 0x13121110
    .word 0x17161514
    .word 0x1b1a1918
    .word 0x1f1e1d1c
    .word 0x23222120
    .word 0x27262524
    .word 0x2b2a2928
    .word 0x2f2e2d2c
    .word 0x33323130
    .word 0x37363534
    .word 0x3b3a3938
    .word 0x3f3e3d3c
    .word 0x43424140
    .word 0x47464544
    .word 0x4b4a4948
    .word 0x4f4e4d4c
    .word 0x53525150
    .word 0x57565554
    .word 0x5b5a5958
    .word 0x5f5e5d5c
    .word 0x63626160
    .word 0x67666564
    .word 0x6b6a6968
    .word 0x6f6e6d6c
    .word 0x73727170
    .word 0x77767574
    .word 0x7b7a7978
    .word 0x7f7e7d7c
    .word 0x83828180
    .word 0x87868584
    .word 0x8b8a8988
    .word 0x8f8e8d8c
    .word 0x93929190
    .word 0x97969594
    .word 0x9b9a9998
    .word 0x9f9e9d9c
    .word 0xa3a2a1a0
    .word 0xa7a6a5a4
    .word 0xabaaa9a8
    .word 0xafaeadac
    .word 0xb3b2b1b0
    .word 0xb7b6b5b4
    .word 0xbbbab9b8
    .word 0xbfbebdbc
    .word 0xc3c2c1c0
    .word 0xc7c6c5c4
    .word 0xcbcac9c8
    .word 0xcfcecdcc
    .word 0xd3d2d1d0
    .word 0xd7d6d5d4
    .word 0xdbdad9d8
    .word 0xdfdedddc
    .word 0xe3e2e1e0
    .word 0xe7e6e5e4
    .word 0xebeae9e8
    .word 0xefeeedec
    .word 0xf3f2f1f0
    .word 0xf7f6f5f4
    .word 0xfbfaf9f8
    .word 0xfffefdfc

    .align 8
out_data:
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555
    .word 0x55555555

RVTEST_DATA_END
