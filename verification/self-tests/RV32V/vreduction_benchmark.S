# See LICENSE for license details.

#*****************************************************************************
# vreduction_benchmark.S
#-----------------------------------------------------------------------------
#
# benchmarking 
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN

    li x1, 130 // loop variable N, range is 0 - 130
    la x2, A_data

    // Initialize result register
    vsub.vv v16, v16, v16

loop:
    vsetvli x5, x1, e32, m8
    vle32.v v8, 0(x2)
    vredsum.vs v16, v8, v16

    // update pointers 
    slli x6, x5, 2
    add x2, x2, x6

    // stripmining 
    sub x1, x1, x5
    bne x1, x0, loop

	// Store result to memory
	vsetivli x5, 1, e32, m8
	la x3, result
	vse32.v v16, (x3)

	// Load and check result
	lw x4, 0(x3)
	TEST_CASE(1, x4, 8515, NOP)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

A_data:
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
    .word 0x0000001b
    .word 0x0000001c
    .word 0x0000001d
    .word 0x0000001e
    .word 0x0000001f
    .word 0x00000020
    .word 0x00000021
    .word 0x00000022
    .word 0x00000023
    .word 0x00000024
    .word 0x00000025
    .word 0x00000026
    .word 0x00000027
    .word 0x00000028
    .word 0x00000029
    .word 0x0000002a
    .word 0x0000002b
    .word 0x0000002c
    .word 0x0000002d
    .word 0x0000002e
    .word 0x0000002f
    .word 0x00000030
    .word 0x00000031
    .word 0x00000032
    .word 0x00000033
    .word 0x00000034
    .word 0x00000035
    .word 0x00000036
    .word 0x00000037
    .word 0x00000038
    .word 0x00000039
    .word 0x0000003a
    .word 0x0000003b
    .word 0x0000003c
    .word 0x0000003d
    .word 0x0000003e
    .word 0x0000003f
    .word 0x00000040
    .word 0x00000041
    .word 0x00000042
    .word 0x00000043
    .word 0x00000044
    .word 0x00000045
    .word 0x00000046
    .word 0x00000047
    .word 0x00000048
    .word 0x00000049
    .word 0x0000004a
    .word 0x0000004b
    .word 0x0000004c
    .word 0x0000004d
    .word 0x0000004e
    .word 0x0000004f
    .word 0x00000050
    .word 0x00000051
    .word 0x00000052
    .word 0x00000053
    .word 0x00000054
    .word 0x00000055
    .word 0x00000056
    .word 0x00000057
    .word 0x00000058
    .word 0x00000059
    .word 0x0000005a
    .word 0x0000005b
    .word 0x0000005c
    .word 0x0000005d
    .word 0x0000005e
    .word 0x0000005f
    .word 0x00000060
    .word 0x00000061
    .word 0x00000062
    .word 0x00000063
    .word 0x00000064
    .word 0x00000065
    .word 0x00000066
    .word 0x00000067
    .word 0x00000068
    .word 0x00000069
    .word 0x0000006a
    .word 0x0000006b
    .word 0x0000006c
    .word 0x0000006d
    .word 0x0000006e
    .word 0x0000006f
    .word 0x00000070
    .word 0x00000071
    .word 0x00000072
    .word 0x00000073
    .word 0x00000074
    .word 0x00000075
    .word 0x00000076
    .word 0x00000077
    .word 0x00000078
    .word 0x00000079
    .word 0x0000007a
    .word 0x0000007b
    .word 0x0000007c
    .word 0x0000007d
    .word 0x0000007e
    .word 0x0000007f
    .word 0x00000080
    .word 0x00000081
    .word 0x00000082

result:
	.word 0x55555555

RVTEST_DATA_END
