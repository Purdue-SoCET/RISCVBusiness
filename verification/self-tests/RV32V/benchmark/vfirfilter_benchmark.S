# See LICENSE for license details.

#*****************************************************************************
# vfirfilter.S
#-----------------------------------------------------------------------------
#
# 300 Hz to 3400 Hz bandpass filter implemented using 55-tap FIR filter
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
        // Jump to main (will halt there)
        la      sp, endstack
        j       main

filter_new_sample:                      # @filter_new_sample
        lui     a1, %hi(prev_samples_head)
        lw      t1, %lo(prev_samples_head)(a1)
        lui     a2, %hi(prev_samples)
        addi    a2, a2, %lo(prev_samples)
        slli    a3, t1, 1
        add     a5, a2, a3
        csrr    a3, vlenb
        srli    a4, a3, 3
        li      a6, 14
        sh      a0, 0(a5)
        bltu    a4, a6, .LBB0_2
        li      a3, 0
        li      a6, 0
        j       .LBB0_5
.LBB0_2:
        li      a0, 60
        mul     a0, a4, a0
        andi    a6, a0, 48
        srli    a4, a3, 1
        vsetvli a0, zero, e32, m2, ta, ma
        vid.v   v10
        lui     a0, %hi(fir_coeffs_q15)
        addi    a5, a0, %lo(fir_coeffs_q15)
        vmv.v.i v8, 0
        li      a7, 54
        li      t0, -55
        mv      a0, a6
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
        vadd.vx v12, v10, t1
        vmsgt.vx        v0, v12, a7
        vsetvli zero, zero, e32, m2, ta, mu
        vadd.vx v12, v12, t0, v0.t
        vl1re16.v       v14, (a5)
        vadd.vv v12, v12, v12
        vsetvli zero, zero, e16, m1, ta, ma
        vluxei32.v      v15, (a2), v12
        vwmul.vv        v12, v15, v14
        vsetvli zero, zero, e32, m2, ta, ma
        vsra.vi v12, v12, 15
        vadd.vv v8, v12, v8
        vadd.vx v10, v10, a4
        sub     a0, a0, a4
        add     a5, a5, a3
        bnez    a0, .LBB0_3
        vmv.s.x v10, zero
        vredsum.vs      v8, v8, v10
        vmv.x.s a3, v8
.LBB0_5:
        slli    a0, a6, 1
        lui     a4, %hi(fir_coeffs_q15)
        addi    a4, a4, %lo(fir_coeffs_q15)
        add     a0, a0, a4
        add     a6, a6, t1
        addi    a4, a4, 110
.LBB0_6:                                # =>This Inner Loop Header: Depth=1
        slti    a5, a6, 55
        addi    a5, a5, -1
        andi    a5, a5, -55
        add     a5, a5, a6
        lh      a1, 0(a0)
        slli    a5, a5, 1
        add     a5, a5, a2
        lh      a5, 0(a5)
        mul     a1, a5, a1
        srai    a1, a1, 15
        add     a3, a3, a1
        addi    a0, a0, 2
        addi    a6, a6, 1
        bne     a0, a4, .LBB0_6
        bgtz    t1, .LBB0_9
        li      a1, 54
        j       .LBB0_10
.LBB0_9:
        addi    a1, t1, -1
.LBB0_10:
        lui     a2, %hi(prev_samples_head)
        slli    a0, a3, 16
        srai    a0, a0, 16
        sw      a1, %lo(prev_samples_head)(a2)
        ret
main:                                   # @main
        addi    sp, sp, -16
        sw      ra, 12(sp)                      # 4-byte Folded Spill
        sw      s0, 8(sp)                       # 4-byte Folded Spill
        sw      s1, 4(sp)                       # 4-byte Folded Spill
        sw      s2, 0(sp)                       # 4-byte Folded Spill
        lui     a0, %hi(output)
        addi    s0, a0, %lo(output)
        lui     a0, %hi(inputs)
        addi    s1, a0, %lo(inputs)
        addi    s2, s0, 150
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
        lh      a0, 0(s1)
        call    filter_new_sample
        sh      a0, 0(s0)
        addi    s0, s0, 2
        addi    s1, s1, 2
        bne     s0, s2, .LBB1_1
        li      a0, 0
        lw      ra, 12(sp)                      # 4-byte Folded Reload
        lw      s0, 8(sp)                       # 4-byte Folded Reload
        lw      s1, 4(sp)                       # 4-byte Folded Reload
        lw      s2, 0(sp)                       # 4-byte Folded Reload
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

inputs:
        .half   0                               # 0x0
        .half   2119                            # 0x847
        .half   65096                           # 0xfe48
        .half   64000                           # 0xfa00
        .half   1588                            # 0x634
        .half   1926                            # 0x786
        .half   64451                           # 0xfbc3
        .half   65270                           # 0xfef6
        .half   2702                            # 0xa8e
        .half   1163                            # 0x48b
        .half   64418                           # 0xfba2
        .half   1335                            # 0x537
        .half   3045                            # 0xbe5
        .half   248                             # 0xf8
        .half   65134                           # 0xfe6e
        .half   2778                            # 0xada
        .half   2606                            # 0xa2e
        .half   65182                           # 0xfe9e
        .half   903                             # 0x387
        .half   3621                            # 0xe25
        .half   1657                            # 0x679
        .half   65225                           # 0xfec9
        .half   2396                            # 0x95c
        .half   3635                            # 0xe33
        .half   649                             # 0x289
        .half   444                             # 0x1bc
        .half   3584                            # 0xe00
        .half   2887                            # 0xb47
        .half   36                              # 0x24
        .half   1685                            # 0x695
        .half   4071                            # 0xfe7
        .half   1715                            # 0x6b3
        .half   96                              # 0x60
        .half   2978                            # 0xba2
        .half   3704                            # 0xe78
        .half   594                             # 0x252
        .half   828                             # 0x33c
        .half   3842                            # 0xf02
        .half   2632                            # 0xa48
        .half   65489                           # 0xffd1
        .half   1948                            # 0x79c
        .half   3939                            # 0xf63
        .half   1247                            # 0x4df
        .half   14                              # 0xe
        .half   2998                            # 0xbb6
        .half   3194                            # 0xc7a
        .half   37                              # 0x25
        .half   708                             # 0x2c4
        .half   3526                            # 0xdc6
        .half   1835                            # 0x72b
        .half   64936                           # 0xfda8
        .half   1699                            # 0x6a3
        .half   3253                            # 0xcb5
        .half   300                             # 0x12c
        .half   65030                           # 0xfe06
        .half   2518                            # 0x9d6
        .half   2190                            # 0x88e
        .half   64612                           # 0xfc64
        .half   180                             # 0xb4
        .half   2747                            # 0xabb
        .half   633                             # 0x279
        .half   64054                           # 0xfa36
        .half   1080                            # 0x438
        .half   2177                            # 0x881
        .half   64589                           # 0xfc4d
        .half   64249                           # 0xfaf9
        .half   1721                            # 0x6b9
        .half   898                             # 0x382
        .half   63460                           # 0xf7e4
        .half   64991                           # 0xfddf
        .half   1728                            # 0x6c0
        .half   64800                           # 0xfd20
        .half   63079                           # 0xf667
        .half   328                             # 0x148
        .half   963                             # 0x3c3
        .half   63304                           # 0xf748
        .half   63460                           # 0xf7e4
        .half   866                             # 0x362
        .half   65126                           # 0xfe66
        .half   62389                           # 0xf3b5
        .half   64332                           # 0xfb4c
        .half   742                             # 0x2e6
        .half   63549                           # 0xf83d
        .half   62286                           # 0xf34e
        .half   65247                           # 0xfedf
        .half   65427                           # 0xff93
        .half   62261                           # 0xf335
        .half   62931                           # 0xf5d3
        .half   219                             # 0xdb
        .half   64077                           # 0xfa4d
        .half   61663                           # 0xf0df
        .half   63990                           # 0xf9f6
        .half   44                              # 0x2c
        .half   62669                           # 0xf4cd
        .half   61912                           # 0xf1d8
        .half   64993                           # 0xfde1
        .half   64728                           # 0xfcd8
        .half   61684                           # 0xf0f4
        .half   62864                           # 0xf590
        .half   65513                           # 0xffe9

        .align  4
expect:
        .half   0                               # 0x0
        .half   65534                           # 0xfffe
        .half   65535                           # 0xffff
        .half   65535                           # 0xffff
        .half   65534                           # 0xfffe
        .half   65534                           # 0xfffe
        .half   65531                           # 0xfffb
        .half   65535                           # 0xffff
        .half   65530                           # 0xfffa
        .half   65533                           # 0xfffd
        .half   26                              # 0x1a
        .half   18                              # 0x12
        .half   65524                           # 0xfff4
        .half   11                              # 0xb
        .half   33                              # 0x21
        .half   3                               # 0x3
        .half   65526                           # 0xfff6
        .half   16                              # 0x10
        .half   15                              # 0xf
        .half   65441                           # 0xffa1
        .half   30                              # 0x1e
        .half   6                               # 0x6
        .half   65359                           # 0xff4f
        .half   65522                           # 0xfff2
        .half   65336                           # 0xff38
        .half   10                              # 0xa
        .half   65083                           # 0xfe3b
        .half   65504                           # 0xffe0
        .half   1750                            # 0x6d6
        .half   64855                           # 0xfd57
        .half   63344                           # 0xf770
        .half   1299                            # 0x513
        .half   1404                            # 0x57c
        .half   63736                           # 0xf8f8
        .half   64553                           # 0xfc29
        .half   2024                            # 0x7e8
        .half   365                             # 0x16d
        .half   63317                           # 0xf755
        .half   334                             # 0x14e
        .half   2123                            # 0x84b
        .half   64554                           # 0xfc2a
        .half   63735                           # 0xf8f7
        .half   1560                            # 0x618
        .half   1327                            # 0x52f
        .half   63564                           # 0xf84c
        .half   64838                           # 0xfd46
        .half   2189                            # 0x88d
        .half   65525                           # 0xfff5
        .half   63317                           # 0xf755
        .half   680                             # 0x2a8
        .half   1974                            # 0x7b6
        .half   64211                           # 0xfad3
        .half   63944                           # 0xf9c8
        .half   1791                            # 0x6ff
        .half   998                             # 0x3e6
        .half   63400                           # 0xf7a8
        .half   65177                           # 0xfe99
        .half   2216                            # 0x8a8
        .half   65174                           # 0xfe96
        .half   63405                           # 0xf7ad
        .half   1003                            # 0x3eb
        .half   1794                            # 0x702
        .half   63948                           # 0xf9cc
        .half   64211                           # 0xfad3
        .half   1974                            # 0x7b6
        .half   678                             # 0x2a6
        .half   63326                           # 0xf75e
        .half   65523                           # 0xfff3
        .half   2194                            # 0x892
        .half   64833                           # 0xfd41
        .half   63533                           # 0xf82d
        .half   1299                            # 0x513
        .half   1558                            # 0x616
        .half   63718                           # 0xf8e6
        .half   64510                           # 0xfbfe
        .half   2106                            # 0x83a
        .half   335                             # 0x14f
        .half   63287                           # 0xf737
        .half   332                             # 0x14c
        .half   2104                            # 0x838
        .half   64502                           # 0xfbf6
        .half   63711                           # 0xf8df
        .half   1557                            # 0x615
        .half   1291                            # 0x50b
        .half   63529                           # 0xf829
        .half   64827                           # 0xfd3b
        .half   2184                            # 0x888
        .half   65514                           # 0xffea
        .half   63310                           # 0xf74e
        .half   666                             # 0x29a
        .half   1963                            # 0x7ab
        .half   64201                           # 0xfac9
        .half   63936                           # 0xf9c0
        .half   1778                            # 0x6f2
        .half   985                             # 0x3d9
        .half   63383                           # 0xf797
        .half   65156                           # 0xfe84
        .half   2201                            # 0x899
        .half   65158                           # 0xfe86
        .half   63379                           # 0xf793

        .align  4
fir_coeffs_q15:
        .half   65520                           # 0xfff0
        .half   65533                           # 0xfffd
        .half   65531                           # 0xfffb
        .half   65525                           # 0xfff5
        .half   15                              # 0xf
        .half   65515                           # 0xffeb
        .half   37                              # 0x25
        .half   65510                           # 0xffe6
        .half   52                              # 0x34
        .half   478                             # 0x1de
        .half   508                             # 0x1fc
        .half   365                             # 0x16d
        .half   310                             # 0x136
        .half   130                             # 0x82
        .half   65518                           # 0xffee
        .half   65314                           # 0xff22
        .half   65093                           # 0xfe45
        .half   64872                           # 0xfd68
        .half   63545                           # 0xf839
        .half   65164                           # 0xfe8c
        .half   63892                           # 0xf994
        .half   63354                           # 0xf77a
        .half   65233                           # 0xfed1
        .half   60964                           # 0xee24
        .half   1403                            # 0x57b
        .half   58915                           # 0xe623
        .half   2578                            # 0xa12
        .half   26475                           # 0x676b
        .half   2578                            # 0xa12
        .half   58915                           # 0xe623
        .half   1403                            # 0x57b
        .half   60964                           # 0xee24
        .half   65233                           # 0xfed1
        .half   63354                           # 0xf77a
        .half   63892                           # 0xf994
        .half   65164                           # 0xfe8c
        .half   63545                           # 0xf839
        .half   64872                           # 0xfd68
        .half   65093                           # 0xfe45
        .half   65314                           # 0xff22
        .half   65518                           # 0xffee
        .half   130                             # 0x82
        .half   310                             # 0x136
        .half   365                             # 0x16d
        .half   508                             # 0x1fc
        .half   478                             # 0x1de
        .half   52                              # 0x34
        .half   65510                           # 0xffe6
        .half   37                              # 0x25
        .half   65515                           # 0xffeb
        .half   15                              # 0xf
        .half   65525                           # 0xfff5
        .half   65531                           # 0xfffb
        .half   65533                           # 0xfffd
        .half   65520                           # 0xfff0

        .align  4
prev_samples:
        .zero   110

        .align 4
prev_samples_head:
        .word   0                               # 0x0

        .align 4
output:
        .zero   200

        .align 4
stack:
        .zero   4096
endstack:

errors:
        .word   0xffffffff

RVTEST_DATA_END
