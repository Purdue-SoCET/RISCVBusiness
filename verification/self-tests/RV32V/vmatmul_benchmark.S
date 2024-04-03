# See LICENSE for license details.

#*****************************************************************************
# vmatmul_benchmark.S
#-----------------------------------------------------------------------------
#
# 16x16 matrix multiplication compiled with LLVM
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
        // Jump to main (will halt there)
        la      sp, endstack
        j       main

matmul:                                 # @matmul
        blez    a3, .LBB0_18
        addi    sp, sp, -32
        sw      s0, 28(sp)                      # 4-byte Folded Spill
        sw      s1, 24(sp)                      # 4-byte Folded Spill
        sw      s2, 20(sp)                      # 4-byte Folded Spill
        sw      s3, 16(sp)                      # 4-byte Folded Spill
        sw      s4, 12(sp)                      # 4-byte Folded Spill
        sw      s5, 8(sp)                       # 4-byte Folded Spill
        sw      s6, 4(sp)                       # 4-byte Folded Spill
        li      t0, 0
        slli    a7, a4, 2
        csrr    a5, vlenb
        slli    s4, a5, 1
        srli    t1, a5, 1
        slli    t2, a6, 2
        li      t3, 1
        srli    a5, a5, 3
        slli    t4, a5, 2
        vsetvli a5, zero, e32, m2, ta, ma
        vmv.v.i v8, 0
        j       .LBB0_3
.LBB0_2:                                #   in Loop: Header=BB0_3 Depth=1
        addi    t0, t0, 1
        add     a0, a0, a7
        beq     t0, a3, .LBB0_17
.LBB0_3:                                # =>This Loop Header: Depth=1
        blez    a6, .LBB0_2
        li      t5, 0
        mul     a5, t0, a6
        slli    a5, a5, 2
        add     t6, a2, a5
        mv      s3, a1
        j       .LBB0_7
.LBB0_5:                                #   in Loop: Header=BB0_7 Depth=2
        li      s5, 0
.LBB0_6:                                #   in Loop: Header=BB0_7 Depth=2
        slli    a5, t5, 2
        add     a5, a5, t6
        sw      s5, 0(a5)
        addi    t5, t5, 1
        addi    s3, s3, 4
        beq     t5, a6, .LBB0_2
.LBB0_7:                                #   Parent Loop BB0_3 Depth=1
        blez    a4, .LBB0_5
        li      s0, 8
        mv      a5, t1
        bltu    s0, t1, .LBB0_10
        li      a5, 8
.LBB0_10:                               #   in Loop: Header=BB0_7 Depth=2
        li      s2, 0
        li      s5, 0
        bltu    a4, a5, .LBB0_15
        bne     a6, t3, .LBB0_15
        neg     a5, t4
        and     s2, a5, a4
        mv      a5, s2
        mv      s0, s3
        mv      s1, a0
        vmv2r.v v10, v8
.LBB0_13:                               #   Parent Loop BB0_3 Depth=1
        vl2re32.v       v12, (s1)
        vl2re32.v       v14, (s0)
        vmacc.vv        v10, v14, v12
        add     s1, s1, s4
        sub     a5, a5, t1
        add     s0, s0, s4
        bnez    a5, .LBB0_13
        vmv.s.x v12, zero
        vredsum.vs      v10, v10, v12
        vmv.x.s s5, v10
        beq     s2, a4, .LBB0_6
.LBB0_15:                               #   in Loop: Header=BB0_7 Depth=2
        sub     s6, a4, s2
        mul     a5, t2, s2
        add     a5, a5, s3
        slli    s1, s2, 2
        add     s1, s1, a0
.LBB0_16:                               #   Parent Loop BB0_3 Depth=1
        lw      s2, 0(s1)
        lw      s0, 0(a5)
        mul     s0, s0, s2
        add     s5, s5, s0
        addi    s6, s6, -1
        add     a5, a5, t2
        addi    s1, s1, 4
        bnez    s6, .LBB0_16
        j       .LBB0_6
.LBB0_17:
        lw      s0, 28(sp)                      # 4-byte Folded Reload
        lw      s1, 24(sp)                      # 4-byte Folded Reload
        lw      s2, 20(sp)                      # 4-byte Folded Reload
        lw      s3, 16(sp)                      # 4-byte Folded Reload
        lw      s4, 12(sp)                      # 4-byte Folded Reload
        lw      s5, 8(sp)                       # 4-byte Folded Reload
        lw      s6, 4(sp)                       # 4-byte Folded Reload
        addi    sp, sp, 32
.LBB0_18:
        ret
main:                                   # @main
        addi    sp, sp, -16
        sw      ra, 12(sp)                      # 4-byte Folded Spill
        sw      s0, 8(sp)                       # 4-byte Folded Spill
        sw      s1, 4(sp)                       # 4-byte Folded Spill
        lui     a0, %hi(matrix1)
        addi    a0, a0, %lo(matrix1)
        lui     a1, %hi(matrix2)
        addi    a1, a1, %lo(matrix2)
        lui     s1, %hi(result)
        addi    s0, s1, %lo(result)
        li      a3, 16
        li      a4, 16
        li      a6, 16
        mv      a2, s0
        call    matmul
        csrr    a3, vlenb
        srli    a0, a3, 3
        li      a1, 64
        bgeu    a1, a0, .LBB1_2
        li      a1, 0
        li      a0, 0
        j       .LBB1_5
.LBB1_2:
        li      a1, 508
        mul     a0, a0, a1
        andi    a1, a0, 256
        srli    a0, a3, 1
        lui     a2, %hi(expect)
        addi    a2, a2, %lo(expect)
        slli    a3, a3, 1
        vsetvli a4, zero, e32, m2, ta, ma
        vmv.v.i v8, 0
        mv      a4, a1
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
        vl2re32.v       v10, (s0)
        vl2re32.v       v12, (a2)
        vsetvli zero, zero, e32, m2, ta, mu
        vmsne.vv        v0, v10, v12
        vadd.vi v8, v8, 1, v0.t
        add     s0, s0, a3
        sub     a4, a4, a0
        add     a2, a2, a3
        bnez    a4, .LBB1_3
        vmv.s.x v10, zero
        vredsum.vs      v8, v8, v10
        vmv.x.s a0, v8
        bnez    a1, .LBB1_7
.LBB1_5:
        slli    a2, a1, 2
        lui     a1, %hi(expect)
        addi    a3, a1, %lo(expect)
        add     a1, a3, a2
        addi    a4, s1, %lo(result)
        add     a2, a2, a4
        addi    a3, a3, 1024
.LBB1_6:                                # =>This Inner Loop Header: Depth=1
        lw      a4, 0(a2)
        lw      a5, 0(a1)
        xor     a4, a4, a5
        snez    a4, a4
        add     a0, a0, a4
        addi    a1, a1, 4
        addi    a2, a2, 4
        bne     a1, a3, .LBB1_6
.LBB1_7:
        lw      ra, 12(sp)                      # 4-byte Folded Reload
        lw      s0, 8(sp)                       # 4-byte Folded Reload
        lw      s1, 4(sp)                       # 4-byte Folded Reload
        addi    sp, sp, 16    

        // Check for errors
        TEST_CASE(1, a0, 0, NOP)

        TEST_PASSFAIL

RVTEST_CODE_END

        .data
RVTEST_DATA_BEGIN

        TEST_DATA

matrix1:
        .word   213                             # 0xd5
        .word   236                             # 0xec
        .word   287                             # 0x11f
        .word   715                             # 0x2cb
        .word   625                             # 0x271
        .word   112                             # 0x70
        .word   560                             # 0x230
        .word   51                              # 0x33
        .word   792                             # 0x318
        .word   19                              # 0x13
        .word   808                             # 0x328
        .word   835                             # 0x343
        .word   646                             # 0x286
        .word   954                             # 0x3ba
        .word   667                             # 0x29b
        .word   287                             # 0x11f
        .word   881                             # 0x371
        .word   482                             # 0x1e2
        .word   768                             # 0x300
        .word   91                              # 0x5b
        .word   378                             # 0x17a
        .word   952                             # 0x3b8
        .word   146                             # 0x92
        .word   256                             # 0x100
        .word   109                             # 0x6d
        .word   580                             # 0x244
        .word   896                             # 0x380
        .word   22                              # 0x16
        .word   952                             # 0x3b8
        .word   421                             # 0x1a5
        .word   133                             # 0x85
        .word   462                             # 0x1ce
        .word   31                              # 0x1f
        .word   648                             # 0x288
        .word   183                             # 0xb7
        .word   48                              # 0x30
        .word   294                             # 0x126
        .word   996                             # 0x3e4
        .word   135                             # 0x87
        .word   88                              # 0x58
        .word   312                             # 0x138
        .word   978                             # 0x3d2
        .word   697                             # 0x2b9
        .word   95                              # 0x5f
        .word   992                             # 0x3e0
        .word   701                             # 0x2bd
        .word   377                             # 0x179
        .word   211                             # 0xd3
        .word   172                             # 0xac
        .word   689                             # 0x2b1
        .word   693                             # 0x2b5
        .word   43                              # 0x2b
        .word   313                             # 0x139
        .word   557                             # 0x22d
        .word   865                             # 0x361
        .word   404                             # 0x194
        .word   160                             # 0xa0
        .word   724                             # 0x2d4
        .word   284                             # 0x11c
        .word   81                              # 0x51
        .word   455                             # 0x1c7
        .word   679                             # 0x2a7
        .word   116                             # 0x74
        .word   555                             # 0x22b
        .word   803                             # 0x323
        .word   980                             # 0x3d4
        .word   693                             # 0x2b5
        .word   215                             # 0xd7
        .word   113                             # 0x71
        .word   202                             # 0xca
        .word   936                             # 0x3a8
        .word   911                             # 0x38f
        .word   613                             # 0x265
        .word   622                             # 0x26e
        .word   623                             # 0x26f
        .word   706                             # 0x2c2
        .word   61                              # 0x3d
        .word   823                             # 0x337
        .word   939                             # 0x3ab
        .word   513                             # 0x201
        .word   758                             # 0x2f6
        .word   426                             # 0x1aa
        .word   696                             # 0x2b8
        .word   275                             # 0x113
        .word   590                             # 0x24e
        .word   896                             # 0x380
        .word   796                             # 0x31c
        .word   913                             # 0x391
        .word   883                             # 0x373
        .word   587                             # 0x24b
        .word   246                             # 0xf6
        .word   785                             # 0x311
        .word   191                             # 0xbf
        .word   116                             # 0x74
        .word   621                             # 0x26d
        .word   885                             # 0x375
        .word   200                             # 0xc8
        .word   909                             # 0x38d
        .word   268                             # 0x10c
        .word   734                             # 0x2de
        .word   411                             # 0x19b
        .word   613                             # 0x265
        .word   374                             # 0x176
        .word   636                             # 0x27c
        .word   577                             # 0x241
        .word   318                             # 0x13e
        .word   453                             # 0x1c5
        .word   180                             # 0xb4
        .word   639                             # 0x27f
        .word   903                             # 0x387
        .word   237                             # 0xed
        .word   929                             # 0x3a1
        .word   612                             # 0x264
        .word   433                             # 0x1b1
        .word   470                             # 0x1d6
        .word   118                             # 0x76
        .word   959                             # 0x3bf
        .word   24                              # 0x18
        .word   760                             # 0x2f8
        .word   263                             # 0x107
        .word   603                             # 0x25b
        .word   355                             # 0x163
        .word   908                             # 0x38c
        .word   155                             # 0x9b
        .word   199                             # 0xc7
        .word   393                             # 0x189
        .word   671                             # 0x29f
        .word   276                             # 0x114
        .word   665                             # 0x299
        .word   786                             # 0x312
        .word   579                             # 0x243
        .word   584                             # 0x248
        .word   912                             # 0x390
        .word   385                             # 0x181
        .word   903                             # 0x387
        .word   486                             # 0x1e6
        .word   451                             # 0x1c3
        .word   35                              # 0x23
        .word   925                             # 0x39d
        .word   192                             # 0xc0
        .word   2                               # 0x2
        .word   599                             # 0x257
        .word   836                             # 0x344
        .word   849                             # 0x351
        .word   258                             # 0x102
        .word   26                              # 0x1a
        .word   752                             # 0x2f0
        .word   400                             # 0x190
        .word   149                             # 0x95
        .word   912                             # 0x390
        .word   737                             # 0x2e1
        .word   873                             # 0x369
        .word   274                             # 0x112
        .word   507                             # 0x1fb
        .word   928                             # 0x3a0
        .word   196                             # 0xc4
        .word   30                              # 0x1e
        .word   207                             # 0xcf
        .word   863                             # 0x35f
        .word   915                             # 0x393
        .word   250                             # 0xfa
        .word   479                             # 0x1df
        .word   602                             # 0x25a
        .word   475                             # 0x1db
        .word   366                             # 0x16e
        .word   13                              # 0xd
        .word   755                             # 0x2f3
        .word   571                             # 0x23b
        .word   972                             # 0x3cc
        .word   662                             # 0x296
        .word   359                             # 0x167
        .word   364                             # 0x16c
        .word   7                               # 0x7
        .word   440                             # 0x1b8
        .word   74                              # 0x4a
        .word   432                             # 0x1b0
        .word   918                             # 0x396
        .word   651                             # 0x28b
        .word   26                              # 0x1a
        .word   19                              # 0x13
        .word   217                             # 0xd9
        .word   470                             # 0x1d6
        .word   250                             # 0xfa
        .word   279                             # 0x117
        .word   516                             # 0x204
        .word   509                             # 0x1fd
        .word   590                             # 0x24e
        .word   755                             # 0x2f3
        .word   731                             # 0x2db
        .word   630                             # 0x276
        .word   529                             # 0x211
        .word   356                             # 0x164
        .word   525                             # 0x20d
        .word   962                             # 0x3c2
        .word   332                             # 0x14c
        .word   850                             # 0x352
        .word   716                             # 0x2cc
        .word   171                             # 0xab
        .word   13                              # 0xd
        .word   206                             # 0xce
        .word   316                             # 0x13c
        .word   969                             # 0x3c9
        .word   125                             # 0x7d
        .word   890                             # 0x37a
        .word   488                             # 0x1e8
        .word   383                             # 0x17f
        .word   470                             # 0x1d6
        .word   222                             # 0xde
        .word   388                             # 0x184
        .word   487                             # 0x1e7
        .word   96                              # 0x60
        .word   419                             # 0x1a3
        .word   473                             # 0x1d9
        .word   636                             # 0x27c
        .word   735                             # 0x2df
        .word   639                             # 0x27f
        .word   745                             # 0x2e9
        .word   803                             # 0x323
        .word   189                             # 0xbd
        .word   94                              # 0x5e
        .word   679                             # 0x2a7
        .word   955                             # 0x3bb
        .word   891                             # 0x37b
        .word   653                             # 0x28d
        .word   906                             # 0x38a
        .word   267                             # 0x10b
        .word   432                             # 0x1b0
        .word   456                             # 0x1c8
        .word   925                             # 0x39d
        .word   629                             # 0x275
        .word   797                             # 0x31d
        .word   399                             # 0x18f
        .word   571                             # 0x23b
        .word   281                             # 0x119
        .word   232                             # 0xe8
        .word   165                             # 0xa5
        .word   865                             # 0x361
        .word   534                             # 0x216
        .word   536                             # 0x218
        .word   663                             # 0x297
        .word   43                              # 0x2b
        .word   449                             # 0x1c1
        .word   987                             # 0x3db
        .word   373                             # 0x175
        .word   996                             # 0x3e4
        .word   503                             # 0x1f7
        .word   564                             # 0x234
        .word   117                             # 0x75
        .word   168                             # 0xa8
        .word   347                             # 0x15b
        .word   271                             # 0x10f
        .word   965                             # 0x3c5
        .word   70                              # 0x46
        .word   811                             # 0x32b
        .word   372                             # 0x174
        .word   880                             # 0x370

matrix2:
        .word   283                             # 0x11b
        .word   141                             # 0x8d
        .word   62                              # 0x3e
        .word   366                             # 0x16e
        .word   185                             # 0xb9
        .word   91                              # 0x5b
        .word   971                             # 0x3cb
        .word   148                             # 0x94
        .word   382                             # 0x17e
        .word   779                             # 0x30b
        .word   804                             # 0x324
        .word   330                             # 0x14a
        .word   37                              # 0x25
        .word   142                             # 0x8e
        .word   142                             # 0x8e
        .word   404                             # 0x194
        .word   81                              # 0x51
        .word   795                             # 0x31b
        .word   23                              # 0x17
        .word   223                             # 0xdf
        .word   871                             # 0x367
        .word   781                             # 0x30d
        .word   614                             # 0x266
        .word   406                             # 0x196
        .word   476                             # 0x1dc
        .word   245                             # 0xf5
        .word   141                             # 0x8d
        .word   827                             # 0x33b
        .word   402                             # 0x192
        .word   5                               # 0x5
        .word   321                             # 0x141
        .word   155                             # 0x9b
        .word   660                             # 0x294
        .word   844                             # 0x34c
        .word   101                             # 0x65
        .word   721                             # 0x2d1
        .word   963                             # 0x3c3
        .word   103                             # 0x67
        .word   11                              # 0xb
        .word   53                              # 0x35
        .word   45                              # 0x2d
        .word   38                              # 0x26
        .word   738                             # 0x2e2
        .word   149                             # 0x95
        .word   302                             # 0x12e
        .word   95                              # 0x5f
        .word   603                             # 0x25b
        .word   938                             # 0x3aa
        .word   465                             # 0x1d1
        .word   454                             # 0x1c6
        .word   179                             # 0xb3
        .word   965                             # 0x3c5
        .word   672                             # 0x2a0
        .word   381                             # 0x17d
        .word   739                             # 0x2e3
        .word   371                             # 0x173
        .word   732                             # 0x2dc
        .word   4                               # 0x4
        .word   838                             # 0x346
        .word   486                             # 0x1e6
        .word   272                             # 0x110
        .word   550                             # 0x226
        .word   856                             # 0x358
        .word   636                             # 0x27c
        .word   233                             # 0xe9
        .word   553                             # 0x229
        .word   445                             # 0x1bd
        .word   230                             # 0xe6
        .word   334                             # 0x14e
        .word   32                              # 0x20
        .word   318                             # 0x13e
        .word   577                             # 0x241
        .word   74                              # 0x4a
        .word   474                             # 0x1da
        .word   916                             # 0x394
        .word   746                             # 0x2ea
        .word   676                             # 0x2a4
        .word   215                             # 0xd7
        .word   341                             # 0x155
        .word   944                             # 0x3b0
        .word   481                             # 0x1e1
        .word   41                              # 0x29
        .word   47                              # 0x2f
        .word   845                             # 0x34d
        .word   35                              # 0x23
        .word   973                             # 0x3cd
        .word   264                             # 0x108
        .word   0                               # 0x0
        .word   234                             # 0xea
        .word   872                             # 0x368
        .word   896                             # 0x380
        .word   807                             # 0x327
        .word   314                             # 0x13a
        .word   958                             # 0x3be
        .word   705                             # 0x2c1
        .word   227                             # 0xe3
        .word   634                             # 0x27a
        .word   488                             # 0x1e8
        .word   976                             # 0x3d0
        .word   426                             # 0x1aa
        .word   605                             # 0x25d
        .word   761                             # 0x2f9
        .word   174                             # 0xae
        .word   368                             # 0x170
        .word   15                              # 0xf
        .word   24                              # 0x18
        .word   532                             # 0x214
        .word   331                             # 0x14b
        .word   377                             # 0x179
        .word   816                             # 0x330
        .word   137                             # 0x89
        .word   244                             # 0xf4
        .word   949                             # 0x3b5
        .word   332                             # 0x14c
        .word   308                             # 0x134
        .word   395                             # 0x18b
        .word   149                             # 0x95
        .word   306                             # 0x132
        .word   422                             # 0x1a6
        .word   938                             # 0x3aa
        .word   20                              # 0x14
        .word   444                             # 0x1bc
        .word   126                             # 0x7e
        .word   6                               # 0x6
        .word   899                             # 0x383
        .word   773                             # 0x305
        .word   707                             # 0x2c3
        .word   962                             # 0x3c2
        .word   121                             # 0x79
        .word   698                             # 0x2ba
        .word   390                             # 0x186
        .word   623                             # 0x26f
        .word   35                              # 0x23
        .word   921                             # 0x399
        .word   206                             # 0xce
        .word   171                             # 0xab
        .word   246                             # 0xf6
        .word   64                              # 0x40
        .word   500                             # 0x1f4
        .word   273                             # 0x111
        .word   942                             # 0x3ae
        .word   632                             # 0x278
        .word   475                             # 0x1db
        .word   553                             # 0x229
        .word   411                             # 0x19b
        .word   701                             # 0x2bd
        .word   238                             # 0xee
        .word   645                             # 0x285
        .word   341                             # 0x155
        .word   923                             # 0x39b
        .word   278                             # 0x116
        .word   945                             # 0x3b1
        .word   831                             # 0x33f
        .word   366                             # 0x16e
        .word   870                             # 0x366
        .word   587                             # 0x24b
        .word   112                             # 0x70
        .word   860                             # 0x35c
        .word   266                             # 0x10a
        .word   900                             # 0x384
        .word   495                             # 0x1ef
        .word   812                             # 0x32c
        .word   399                             # 0x18f
        .word   413                             # 0x19d
        .word   6                               # 0x6
        .word   28                              # 0x1c
        .word   983                             # 0x3d7
        .word   342                             # 0x156
        .word   67                              # 0x43
        .word   447                             # 0x1bf
        .word   944                             # 0x3b0
        .word   265                             # 0x109
        .word   340                             # 0x154
        .word   309                             # 0x135
        .word   890                             # 0x37a
        .word   897                             # 0x381
        .word   690                             # 0x2b2
        .word   25                              # 0x19
        .word   976                             # 0x3d0
        .word   609                             # 0x261
        .word   702                             # 0x2be
        .word   364                             # 0x16c
        .word   500                             # 0x1f4
        .word   405                             # 0x195
        .word   348                             # 0x15c
        .word   734                             # 0x2de
        .word   773                             # 0x305
        .word   191                             # 0xbf
        .word   333                             # 0x14d
        .word   247                             # 0xf7
        .word   853                             # 0x355
        .word   682                             # 0x2aa
        .word   849                             # 0x351
        .word   740                             # 0x2e4
        .word   398                             # 0x18e
        .word   556                             # 0x22c
        .word   53                              # 0x35
        .word   760                             # 0x2f8
        .word   496                             # 0x1f0
        .word   292                             # 0x124
        .word   47                              # 0x2f
        .word   695                             # 0x2b7
        .word   713                             # 0x2c9
        .word   266                             # 0x10a
        .word   954                             # 0x3ba
        .word   124                             # 0x7c
        .word   96                              # 0x60
        .word   940                             # 0x3ac
        .word   627                             # 0x273
        .word   103                             # 0x67
        .word   427                             # 0x1ab
        .word   276                             # 0x114
        .word   289                             # 0x121
        .word   772                             # 0x304
        .word   875                             # 0x36b
        .word   300                             # 0x12c
        .word   115                             # 0x73
        .word   226                             # 0xe2
        .word   867                             # 0x363
        .word   171                             # 0xab
        .word   723                             # 0x2d3
        .word   905                             # 0x389
        .word   187                             # 0xbb
        .word   156                             # 0x9c
        .word   526                             # 0x20e
        .word   653                             # 0x28d
        .word   599                             # 0x257
        .word   319                             # 0x13f
        .word   207                             # 0xcf
        .word   732                             # 0x2dc
        .word   439                             # 0x1b7
        .word   495                             # 0x1ef
        .word   949                             # 0x3b5
        .word   98                              # 0x62
        .word   422                             # 0x1a6
        .word   461                             # 0x1cd
        .word   176                             # 0xb0
        .word   805                             # 0x325
        .word   174                             # 0xae
        .word   96                              # 0x60
        .word   79                              # 0x4f
        .word   775                             # 0x307
        .word   849                             # 0x351
        .word   994                             # 0x3e2
        .word   969                             # 0x3c9
        .word   847                             # 0x34f
        .word   337                             # 0x151
        .word   817                             # 0x331
        .word   830                             # 0x33e
        .word   890                             # 0x37a
        .word   216                             # 0xd8
        .word   683                             # 0x2ab
        .word   107                             # 0x6b
        .word   139                             # 0x8b
        .word   623                             # 0x26f
        .word   192                             # 0xc0

expect:
        .word   3804104                         # 0x3a0bc8
        .word   3902304                         # 0x3b8b60
        .word   3779679                         # 0x39ac5f
        .word   3993004                         # 0x3cedac
        .word   2912224                         # 0x2c6fe0
        .word   4108731                         # 0x3eb1bb
        .word   4155445                         # 0x3f6835
        .word   2829733                         # 0x2b2da5
        .word   2378477                         # 0x244aed
        .word   2684589                         # 0x28f6ad
        .word   5444621                         # 0x53140d
        .word   2837467                         # 0x2b4bdb
        .word   3853638                         # 0x3acd46
        .word   3683098                         # 0x38331a
        .word   3643867                         # 0x3799db
        .word   4272226                         # 0x413062
        .word   3607994                         # 0x370dba
        .word   4004729                         # 0x3d1b79
        .word   2183957                         # 0x215315
        .word   4098787                         # 0x3e8ae3
        .word   2539338                         # 0x26bf4a
        .word   3904249                         # 0x3b92f9
        .word   3862174                         # 0x3aee9e
        .word   2642161                         # 0x2850f1
        .word   2104514                         # 0x201cc2
        .word   3777337                         # 0x39a339
        .word   5350127                         # 0x51a2ef
        .word   3262057                         # 0x31c669
        .word   3087728                         # 0x2f1d70
        .word   3081154                         # 0x2f03c2
        .word   3325224                         # 0x32bd28
        .word   4526747                         # 0x45129b
        .word   3268022                         # 0x31ddb6
        .word   3681971                         # 0x382eb3
        .word   2204779                         # 0x21a46b
        .word   3581550                         # 0x36a66e
        .word   1959424                         # 0x1de600
        .word   4648140                         # 0x46eccc
        .word   3293344                         # 0x3240a0
        .word   2710422                         # 0x295b96
        .word   2251637                         # 0x225b75
        .word   3072042                         # 0x2ee02a
        .word   4794194                         # 0x492752
        .word   3228795                         # 0x31447b
        .word   3185635                         # 0x309be3
        .word   3614318                         # 0x37266e
        .word   2780075                         # 0x2a6bab
        .word   3797645                         # 0x39f28d
        .word   3284795                         # 0x321f3b
        .word   3692942                         # 0x38598e
        .word   2677123                         # 0x28d983
        .word   3590811                         # 0x36ca9b
        .word   3128955                         # 0x2fbe7b
        .word   4253422                         # 0x40e6ee
        .word   2808706                         # 0x2adb82
        .word   2924633                         # 0x2ca059
        .word   1989308                         # 0x1e5abc
        .word   2600124                         # 0x27acbc
        .word   4202298                         # 0x401f3a
        .word   2951533                         # 0x2d096d
        .word   2940240                         # 0x2cdd50
        .word   3409350                         # 0x3405c6
        .word   2730870                         # 0x29ab76
        .word   3576674                         # 0x369362
        .word   4673029                         # 0x474e05
        .word   4932889                         # 0x4b4519
        .word   4133143                         # 0x3f1117
        .word   4715696                         # 0x47f4b0
        .word   4226262                         # 0x407cd6
        .word   5399653                         # 0x526465
        .word   4784595                         # 0x4901d3
        .word   4237632                         # 0x40a940
        .word   3419203                         # 0x342c43
        .word   3390039                         # 0x33ba57
        .word   5618224                         # 0x55ba30
        .word   3618412                         # 0x37366c
        .word   3970520                         # 0x3c95d8
        .word   4857607                         # 0x4a1f07
        .word   4239834                         # 0x40b1da
        .word   4833858                         # 0x49c242
        .word   4418774                         # 0x436cd6
        .word   4704266                         # 0x47c80a
        .word   4136361                         # 0x3f1da9
        .word   5456556                         # 0x5342ac
        .word   4025738                         # 0x3d6d8a
        .word   5440520                         # 0x530408
        .word   3902919                         # 0x3b8dc7
        .word   4142582                         # 0x3f35f6
        .word   3349349                         # 0x331b65
        .word   4172823                         # 0x3fac17
        .word   5776558                         # 0x5824ae
        .word   4034093                         # 0x3d8e2d
        .word   3998001                         # 0x3d0131
        .word   4752008                         # 0x488288
        .word   4650432                         # 0x46f5c0
        .word   5232695                         # 0x4fd837
        .word   3735410                         # 0x38ff72
        .word   4394968                         # 0x430fd8
        .word   3192107                         # 0x30b52b
        .word   4665335                         # 0x472ff7
        .word   3561639                         # 0x3658a7
        .word   5170456                         # 0x4ee518
        .word   4190448                         # 0x3ff0f0
        .word   3617318                         # 0x373226
        .word   2879670                         # 0x2bf0b6
        .word   3398481                         # 0x33db51
        .word   4977791                         # 0x4bf47f
        .word   3710069                         # 0x389c75
        .word   4033182                         # 0x3d8a9e
        .word   3973484                         # 0x3ca16c
        .word   3948886                         # 0x3c4156
        .word   4247156                         # 0x40ce74
        .word   3105147                         # 0x2f617b
        .word   4121008                         # 0x3ee1b0
        .word   3083640                         # 0x2f0d78
        .word   3223334                         # 0x312f26
        .word   2629285                         # 0x281ea5
        .word   3344563                         # 0x3308b3
        .word   3530142                         # 0x35dd9e
        .word   2960323                         # 0x2d2bc3
        .word   2119186                         # 0x205612
        .word   2438360                         # 0x2534d8
        .word   4748964                         # 0x4876a4
        .word   2936554                         # 0x2cceea
        .word   3139257                         # 0x2fe6b9
        .word   3215368                         # 0x311008
        .word   2946802                         # 0x2cf6f2
        .word   4118382                         # 0x3ed76e
        .word   3880347                         # 0x3b359b
        .word   4956877                         # 0x4ba2cd
        .word   3896095                         # 0x3b731f
        .word   4590947                         # 0x460d63
        .word   4031472                         # 0x3d83f0
        .word   4534677                         # 0x453195
        .word   4606279                         # 0x464947
        .word   3771326                         # 0x398bbe
        .word   3098387                         # 0x2f4713
        .word   3310786                         # 0x3284c2
        .word   5618665                         # 0x55bbe9
        .word   4026112                         # 0x3d6f00
        .word   3669192                         # 0x37fcc8
        .word   4133716                         # 0x3f1354
        .word   4242664                         # 0x40bce8
        .word   4521363                         # 0x44fd93
        .word   4044177                         # 0x3db591
        .word   4263897                         # 0x410fd9
        .word   3444706                         # 0x348fe2
        .word   4751089                         # 0x487ef1
        .word   3173326                         # 0x306bce
        .word   4400747                         # 0x43266b
        .word   3445979                         # 0x3494db
        .word   3581384                         # 0x36a5c8
        .word   2913278                         # 0x2c73fe
        .word   3237052                         # 0x3164bc
        .word   4925307                         # 0x4b277b
        .word   3231345                         # 0x314e71
        .word   2929424                         # 0x2cb310
        .word   4467465                         # 0x442b09
        .word   4272703                         # 0x41323f
        .word   4328302                         # 0x420b6e
        .word   3013258                         # 0x2dfa8a
        .word   3777484                         # 0x39a3cc
        .word   2885474                         # 0x2c0762
        .word   3713909                         # 0x38ab75
        .word   3105839                         # 0x2f642f
        .word   3827330                         # 0x3a6682
        .word   2872362                         # 0x2bd42a
        .word   3049843                         # 0x2e8973
        .word   2170839                         # 0x211fd7
        .word   2021531                         # 0x1ed89b
        .word   4124594                         # 0x3eefb2
        .word   2560920                         # 0x271398
        .word   3179360                         # 0x308360
        .word   3408091                         # 0x3400db
        .word   3232726                         # 0x3153d6
        .word   3992853                         # 0x3ced15
        .word   3445064                         # 0x349148
        .word   3473551                         # 0x35008f
        .word   3000238                         # 0x2dc7ae
        .word   3638176                         # 0x3783a0
        .word   2456865                         # 0x257d21
        .word   4308827                         # 0x41bf5b
        .word   4131040                         # 0x3f08e0
        .word   2919463                         # 0x2c8c27
        .word   2567491                         # 0x272d43
        .word   3574580                         # 0x368b34
        .word   4861971                         # 0x4a3013
        .word   3009420                         # 0x2deb8c
        .word   3227186                         # 0x313e32
        .word   3331883                         # 0x32d72b
        .word   3059548                         # 0x2eaf5c
        .word   3841329                         # 0x3a9d31
        .word   3325363                         # 0x32bdb3
        .word   3885734                         # 0x3b4aa6
        .word   2743301                         # 0x29dc05
        .word   4025523                         # 0x3d6cb3
        .word   3525609                         # 0x35cbe9
        .word   4130880                         # 0x3f0840
        .word   3854941                         # 0x3ad25d
        .word   3456723                         # 0x34bed3
        .word   3291256                         # 0x323878
        .word   2994324                         # 0x2db094
        .word   5090299                         # 0x4dabfb
        .word   3530847                         # 0x35e05f
        .word   3059423                         # 0x2eaedf
        .word   3173846                         # 0x306dd6
        .word   3440111                         # 0x347def
        .word   4501456                         # 0x44afd0
        .word   4170074                         # 0x3fa15a
        .word   4499050                         # 0x44a66a
        .word   3689455                         # 0x384bef
        .word   4627673                         # 0x469cd9
        .word   3086297                         # 0x2f17d9
        .word   5899440                         # 0x5a04b0
        .word   4095439                         # 0x3e7dcf
        .word   4006718                         # 0x3d233e
        .word   3323912                         # 0x32b808
        .word   3358321                         # 0x333e71
        .word   5428597                         # 0x52d575
        .word   3805410                         # 0x3a10e2
        .word   4176304                         # 0x3fb9b0
        .word   5101323                         # 0x4dd70b
        .word   3411603                         # 0x340e93
        .word   4340189                         # 0x4239dd
        .word   3993996                         # 0x3cf18c
        .word   4317344                         # 0x41e0a0
        .word   3528936                         # 0x35d8e8
        .word   4575640                         # 0x45d198
        .word   3181814                         # 0x308cf6
        .word   4754804                         # 0x488d74
        .word   4013987                         # 0x3d3fa3
        .word   3364971                         # 0x33586b
        .word   2669947                         # 0x28bd7b
        .word   3701312                         # 0x387a40
        .word   5677823                         # 0x56a2ff
        .word   3704781                         # 0x3887cd
        .word   3957076                         # 0x3c6154
        .word   4011205                         # 0x3d34c5
        .word   3397750                         # 0x33d876
        .word   4661383                         # 0x472087
        .word   3612082                         # 0x371db2
        .word   3915812                         # 0x3bc024
        .word   3774988                         # 0x399a0c
        .word   4412262                         # 0x435366
        .word   4280169                         # 0x414f69
        .word   4115466                         # 0x3ecc0a
        .word   3285153                         # 0x3220a1
        .word   3278332                         # 0x3205fc
        .word   2613452                         # 0x27e0cc
        .word   3177497                         # 0x307c19
        .word   5304445                         # 0x50f07d
        .word   3485693                         # 0x352ffd
        .word   3154038                         # 0x302076
        .word   3445050                         # 0x34913a
        .word   3926704                         # 0x3beab0
        .word   4257985                         # 0x40f8c1

result:
        .zero   1024

stack:
        .zero   4096
endstack:

RVTEST_DATA_END
