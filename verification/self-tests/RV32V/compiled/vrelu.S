# See LICENSE for license details.

#*****************************************************************************
# vrelu.S
#-----------------------------------------------------------------------------
#
# In-place ReLU on an array of 256 signed 8-bit integers
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
        // Jump to main (will halt there)
        la      sp, endstack
        j       main

relu:
        ble     a1,zero,.L5
        vsetvli a5,zero,e8,m1,ta,ma
        vmv.v.i v2,0
        mv      a4,a0
.L3:
        vsetvli a5,a1,e8,m1,ta,ma
        vle8.v  v1,0(a0)
        sub     a1,a1,a5
        add     a0,a0,a5
        vmax.vv v1,v1,v2
        vse8.v  v1,0(a4)
        add     a4,a4,a5
        bne     a1,zero,.L3
.L5:
        ret
main:                                   # @main
        addi    sp, sp, -16
        sw      ra, 12(sp)                      # 4-byte Folded Spill
        sw      s0, 8(sp)                       # 4-byte Folded Spill
        lui     a0, %hi(input)
        addi    s0, a0, %lo(input)
        li      a1, 256
        mv      a0, s0
        call    relu
        li      a0, 0
        lui     a1, %hi(expect)
        addi    a1, a1, %lo(expect)
        addi    a2, a1, 256
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
        lbu     a3, 0(s0)
        lbu     a4, 0(a1)
        xor     a3, a3, a4
        snez    a3, a3
        add     a0, a0, a3
        addi    a1, a1, 1
        addi    s0, s0, 1
        bne     a1, a2, .LBB1_1
        lw      ra, 12(sp)                      # 4-byte Folded Reload
        lw      s0, 8(sp)                       # 4-byte Folded Reload
        addi    sp, sp, 16

        // Check for errors
        la a1, errors
        sw a0, 0(a1)
        TEST_CASE(1, a0, 0, NOP)

        TEST_PASSFAIL

RVTEST_CODE_END

        .data
RVTEST_DATA_BEGIN

        TEST_DATA

input:
        .ascii  "\r\3024\226\265x\013\220\323\252\230\357\233\202\235\200\tS\215\333\302\230H:V\313b\341\354L\352\262&\346\215\311\215\204\216\373TJ'\225\231\265`\016a\247\246*$\313\277\217l\213\025\033uQW\002\255,s\371{.\177\214\033:\233\210\354\017\250\333\001R\343\r\024\226\266\342\352\304\332\035\320\032\031x>\031\376*\356\342\337\357\227\025j\271C\337\373`\023\376w\307zE\252\024\245F\204\205!!\322\005\007\226\231\022!\216\035\035\240U\273\334y\3013N%\027\365\206!\262\276\340\372\343\006\371\3157Z6%\343 R\335\215\030\022\3455\354CQ!J\203\370A\365\374\b\346\b7\251\335@\245\240\255Pw\207\204\345/^\007\212\024\377RO\351:/\226Q\343'\017l\211IQ\377J\004\0252FP\tI7U1\325J\221\370\307mf\264\320\233z:\030\025\030\236y\377w\t\312\341A\177v3\367Y\035"

expect:
        .ascii  "\r\0004\000\000x\013\000\000\000\000\000\000\000\000\000\tS\000\000\000\000H:V\000b\000\000L\000\000&\000\000\000\000\000\000\000TJ'\000\000\000`\016a\000\000*$\000\000\000l\000\025\033uQW\002\000,s\000{.\177\000\033:\000\000\000\017\000\000\001R\000\r\024\000\000\000\000\000\000\035\000\032\031x>\031\000*\000\000\000\000\000\025j\000C\000\000`\023\000w\000zE\000\024\000F\000\000!!\000\005\007\000\000\022!\000\035\035\000U\000\000y\0003N%\027\000\000!\000\000\000\000\000\006\000\0007Z6%\000 R\000\000\030\022\0005\000CQ!J\000\000A\000\000\b\000\b7\000\000@\000\000\000Pw\000\000\000/^\007\000\024\000RO\000:/\000Q\000'\017l\000IQ\000J\004\0252FP\tI7U1\000J\000\000\000mf\000\000\000z:\030\025\030\000y\000w\t\000\000A\177v3\000Y\035"

        .align 4
stack:
        .zero   4096
endstack:

errors:
        .word   0xffffffff

RVTEST_DATA_END
