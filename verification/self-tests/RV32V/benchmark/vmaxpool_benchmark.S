# See LICENSE for license details.

#*****************************************************************************
# vmaxpool.S
#-----------------------------------------------------------------------------
#
# Max pool of 16x16 matrix with 2x2 window, compiled using LLVM
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
        // Jump to main (will halt there)
        la      sp, endstack
        j       main

maxpool:
        addi    sp,sp,-32
        sw      s0,28(sp)
        div     s0,a2,a4
        sw      s4,12(sp)
        div     s4,a3,a4
        ble     s0,zero,.L17
        sw      s1,24(sp)
        sw      s2,20(sp)
        sw      s3,16(sp)
        sw      s5,8(sp)
        mv      a6,a4
        mv      s3,a0
        mv      s2,a1
        slli    t1,a3,1
        slli    t6,a4,1
        li      s1,0
        li      t2,0
        mul     t0,a4,a3
.L3:
        bgt     s4,zero,.L24
        addi    t2,t2,1
        add     s1,s1,t0
        bne     s0,t2,.L3
        lw      s1,24(sp)
        lw      s2,20(sp)
        lw      s3,16(sp)
        lw      s5,8(sp)
.L17:
        lw      s0,28(sp)
        lw      s4,12(sp)
        addi    sp,sp,32
        jr      ra
.L24:
        li      a5,-32768
        vsetvli a7,zero,e16,m1,ta,ma
        vmv.s.x v3,a5
        li      a5,0
.L10:
        add     s5,s4,a5
        slli    t4,s1,1
        slli    t3,a5,1
        add     t4,s3,t4
        slli    t5,s5,1
        lh      a5,0(t4)
        add     t3,s2,t3
        add     t5,s2,t5
        ble     a6,zero,.L4
.L9:
        mv      a0,t4
        li      a1,0
.L5:
        vsetvli a4,zero,e16,m1,ta,ma
        vmv.v.x v1,a5
        mv      a3,a0
        mv      a4,a6
.L6:
        vsetvli a5,a4,e16,m1,tu,ma
        vle16.v v2,0(a3)
        slli    a2,a5,1
        sub     a4,a4,a5
        add     a3,a3,a2
        vmax.vv v1,v2,v1
        bne     a4,zero,.L6
        vsetvli a7,zero,e16,m1,ta,ma
        vredmax.vs      v1,v1,v3
        addi    a1,a1,1
        add     a0,a0,t1
        vmv.x.s a4,v1
        slli    a5,a4,16
        srai    a5,a5,16
        bne     a6,a1,.L5
        sh      a4,0(t3)
        addi    t3,t3,2
        add     t4,t4,t6
        beq     t3,t5,.L8
        lh      a5,0(t4)
        j       .L9
.L25:
        lh      a5,0(t4)
.L4:
        sh      a5,0(t3)
        addi    t3,t3,2
        add     t4,t4,t6
        bne     t3,t5,.L25
.L8:
        addi    t2,t2,1
        mv      a5,s5
        add     s1,s1,t0
        bne     s0,t2,.L10
        lw      s1,24(sp)
        lw      s2,20(sp)
        lw      s3,16(sp)
        lw      s5,8(sp)
        j       .L17
main:                                   # @main
        addi    sp, sp, -16
        sw      ra, 12(sp)                      # 4-byte Folded Spill
        lui     a0, %hi(matrix)
        addi    a0, a0, %lo(matrix)
        lui     a1, %hi(result)
        addi    a1, a1, %lo(result)
        li      a2, 32
        li      a3, 32
        li      a4, 4
        call    maxpool
        li      a0, 0
        lw      ra, 12(sp)                      # 4-byte Folded Reload
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

matrix:
        .half   425                             # 0x1a9
        .half   543                             # 0x21f
        .half   123                             # 0x7b
        .half   42                              # 0x2a
        .half   993                             # 0x3e1
        .half   516                             # 0x204
        .half   456                             # 0x1c8
        .half   359                             # 0x167
        .half   102                             # 0x66
        .half   567                             # 0x237
        .half   953                             # 0x3b9
        .half   370                             # 0x172
        .half   300                             # 0x12c
        .half   500                             # 0x1f4
        .half   742                             # 0x2e6
        .half   282                             # 0x11a
        .half   434                             # 0x1b2
        .half   991                             # 0x3df
        .half   757                             # 0x2f5
        .half   423                             # 0x1a7
        .half   123                             # 0x7b
        .half   42                              # 0x2a
        .half   793                             # 0x319
        .half   571                             # 0x23b
        .half   734                             # 0x2de
        .half   116                             # 0x74
        .half   310                             # 0x136
        .half   909                             # 0x38d
        .half   162                             # 0xa2
        .half   693                             # 0x2b5
        .half   880                             # 0x370
        .half   848                             # 0x350
        .half   199                             # 0xc7
        .half   530                             # 0x212
        .half   561                             # 0x231
        .half   81                              # 0x51
        .half   389                             # 0x185
        .half   806                             # 0x326
        .half   170                             # 0xaa
        .half   823                             # 0x337
        .half   540                             # 0x21c
        .half   734                             # 0x2de
        .half   142                             # 0x8e
        .half   366                             # 0x16e
        .half   190                             # 0xbe
        .half   459                             # 0x1cb
        .half   437                             # 0x1b5
        .half   631                             # 0x277
        .half   972                             # 0x3cc
        .half   970                             # 0x3ca
        .half   447                             # 0x1bf
        .half   645                             # 0x285
        .half   515                             # 0x203
        .half   37                              # 0x25
        .half   132                             # 0x84
        .half   161                             # 0xa1
        .half   103                             # 0x67
        .half   514                             # 0x202
        .half   930                             # 0x3a2
        .half   483                             # 0x1e3
        .half   899                             # 0x383
        .half   789                             # 0x315
        .half   630                             # 0x276
        .half   519                             # 0x207
        .half   242                             # 0xf2
        .half   53                              # 0x35
        .half   138                             # 0x8a
        .half   403                             # 0x193
        .half   503                             # 0x1f7
        .half   923                             # 0x39b
        .half   17                              # 0x11
        .half   409                             # 0x199
        .half   864                             # 0x360
        .half   955                             # 0x3bb
        .half   460                             # 0x1cc
        .half   334                             # 0x14e
        .half   236                             # 0xec
        .half   833                             # 0x341
        .half   277                             # 0x115
        .half   474                             # 0x1da
        .half   309                             # 0x135
        .half   333                             # 0x14d
        .half   362                             # 0x16a
        .half   126                             # 0x7e
        .half   395                             # 0x18b
        .half   154                             # 0x9a
        .half   561                             # 0x231
        .half   892                             # 0x37c
        .half   453                             # 0x1c5
        .half   909                             # 0x38d
        .half   206                             # 0xce
        .half   997                             # 0x3e5
        .half   423                             # 0x1a7
        .half   342                             # 0x156
        .half   519                             # 0x207
        .half   941                             # 0x3ad
        .half   821                             # 0x335
        .half   128                             # 0x80
        .half   51                              # 0x33
        .half   523                             # 0x20b
        .half   585                             # 0x249
        .half   320                             # 0x140
        .half   76                              # 0x4c
        .half   728                             # 0x2d8
        .half   899                             # 0x383
        .half   186                             # 0xba
        .half   754                             # 0x2f2
        .half   38                              # 0x26
        .half   25                              # 0x19
        .half   176                             # 0xb0
        .half   319                             # 0x13f
        .half   708                             # 0x2c4
        .half   18                              # 0x12
        .half   381                             # 0x17d
        .half   200                             # 0xc8
        .half   168                             # 0xa8
        .half   761                             # 0x2f9
        .half   589                             # 0x24d
        .half   937                             # 0x3a9
        .half   223                             # 0xdf
        .half   566                             # 0x236
        .half   655                             # 0x28f
        .half   14                              # 0xe
        .half   174                             # 0xae
        .half   684                             # 0x2ac
        .half   859                             # 0x35b
        .half   462                             # 0x1ce
        .half   369                             # 0x171
        .half   195                             # 0xc3
        .half   983                             # 0x3d7
        .half   723                             # 0x2d3
        .half   210                             # 0xd2
        .half   975                             # 0x3cf
        .half   986                             # 0x3da
        .half   501                             # 0x1f5
        .half   378                             # 0x17a
        .half   800                             # 0x320
        .half   749                             # 0x2ed
        .half   483                             # 0x1e3
        .half   789                             # 0x315
        .half   653                             # 0x28d
        .half   240                             # 0xf0
        .half   698                             # 0x2ba
        .half   26                              # 0x1a
        .half   403                             # 0x193
        .half   308                             # 0x134
        .half   680                             # 0x2a8
        .half   114                             # 0x72
        .half   190                             # 0xbe
        .half   134                             # 0x86
        .half   998                             # 0x3e6
        .half   4                               # 0x4
        .half   566                             # 0x236
        .half   997                             # 0x3e5
        .half   998                             # 0x3e6
        .half   400                             # 0x190
        .half   895                             # 0x37f
        .half   506                             # 0x1fa
        .half   605                             # 0x25d
        .half   602                             # 0x25a
        .half   645                             # 0x285
        .half   662                             # 0x296
        .half   844                             # 0x34c
        .half   514                             # 0x202
        .half   767                             # 0x2ff
        .half   613                             # 0x265
        .half   825                             # 0x339
        .half   688                             # 0x2b0
        .half   308                             # 0x134
        .half   23                              # 0x17
        .half   807                             # 0x327
        .half   837                             # 0x345
        .half   464                             # 0x1d0
        .half   920                             # 0x398
        .half   142                             # 0x8e
        .half   498                             # 0x1f2
        .half   661                             # 0x295
        .half   226                             # 0xe2
        .half   549                             # 0x225
        .half   719                             # 0x2cf
        .half   962                             # 0x3c2
        .half   427                             # 0x1ab
        .half   538                             # 0x21a
        .half   166                             # 0xa6
        .half   408                             # 0x198
        .half   508                             # 0x1fc
        .half   869                             # 0x365
        .half   393                             # 0x189
        .half   323                             # 0x143
        .half   330                             # 0x14a
        .half   813                             # 0x32d
        .half   215                             # 0xd7
        .half   565                             # 0x235
        .half   262                             # 0x106
        .half   347                             # 0x15b
        .half   606                             # 0x25e
        .half   624                             # 0x270
        .half   395                             # 0x18b
        .half   738                             # 0x2e2
        .half   86                              # 0x56
        .half   503                             # 0x1f7
        .half   639                             # 0x27f
        .half   386                             # 0x182
        .half   309                             # 0x135
        .half   426                             # 0x1aa
        .half   206                             # 0xce
        .half   753                             # 0x2f1
        .half   610                             # 0x262
        .half   821                             # 0x335
        .half   762                             # 0x2fa
        .half   852                             # 0x354
        .half   193                             # 0xc1
        .half   517                             # 0x205
        .half   56                              # 0x38
        .half   924                             # 0x39c
        .half   17                              # 0x11
        .half   2                               # 0x2
        .half   381                             # 0x17d
        .half   878                             # 0x36e
        .half   148                             # 0x94
        .half   865                             # 0x361
        .half   736                             # 0x2e0
        .half   342                             # 0x156
        .half   167                             # 0xa7
        .half   886                             # 0x376
        .half   959                             # 0x3bf
        .half   637                             # 0x27d
        .half   348                             # 0x15c
        .half   125                             # 0x7d
        .half   232                             # 0xe8
        .half   844                             # 0x34c
        .half   616                             # 0x268
        .half   336                             # 0x150
        .half   376                             # 0x178
        .half   880                             # 0x370
        .half   80                              # 0x50
        .half   647                             # 0x287
        .half   802                             # 0x322
        .half   43                              # 0x2b
        .half   904                             # 0x388
        .half   281                             # 0x119
        .half   124                             # 0x7c
        .half   983                             # 0x3d7
        .half   774                             # 0x306
        .half   668                             # 0x29c
        .half   707                             # 0x2c3
        .half   91                              # 0x5b
        .half   234                             # 0xea
        .half   330                             # 0x14a
        .half   80                              # 0x50
        .half   85                              # 0x55
        .half   558                             # 0x22e
        .half   301                             # 0x12d
        .half   937                             # 0x3a9
        .half   559                             # 0x22f
        .half   907                             # 0x38b
        .half   747                             # 0x2eb
        .half   72                              # 0x48
        .half   926                             # 0x39e
        .half   869                             # 0x365
        .half   551                             # 0x227
        .half   605                             # 0x25d
        .half   648                             # 0x288
        .half   397                             # 0x18d
        .half   952                             # 0x3b8
        .half   121                             # 0x79
        .half   695                             # 0x2b7
        .half   785                             # 0x311
        .half   895                             # 0x37f
        .half   417                             # 0x1a1
        .half   410                             # 0x19a
        .half   873                             # 0x369
        .half   781                             # 0x30d
        .half   204                             # 0xcc
        .half   941                             # 0x3ad
        .half   802                             # 0x322
        .half   110                             # 0x6e
        .half   659                             # 0x293
        .half   578                             # 0x242
        .half   544                             # 0x220
        .half   458                             # 0x1ca
        .half   260                             # 0x104
        .half   994                             # 0x3e2
        .half   514                             # 0x202
        .half   332                             # 0x14c
        .half   897                             # 0x381
        .half   300                             # 0x12c
        .half   452                             # 0x1c4
        .half   289                             # 0x121
        .half   58                              # 0x3a
        .half   889                             # 0x379
        .half   321                             # 0x141
        .half   143                             # 0x8f
        .half   589                             # 0x24d
        .half   238                             # 0xee
        .half   67                              # 0x43
        .half   742                             # 0x2e6
        .half   203                             # 0xcb
        .half   800                             # 0x320
        .half   511                             # 0x1ff
        .half   663                             # 0x297
        .half   678                             # 0x2a6
        .half   811                             # 0x32b
        .half   347                             # 0x15b
        .half   428                             # 0x1ac
        .half   863                             # 0x35f
        .half   380                             # 0x17c
        .half   987                             # 0x3db
        .half   229                             # 0xe5
        .half   973                             # 0x3cd
        .half   405                             # 0x195
        .half   776                             # 0x308
        .half   409                             # 0x199
        .half   100                             # 0x64
        .half   806                             # 0x326
        .half   534                             # 0x216
        .half   325                             # 0x145
        .half   59                              # 0x3b
        .half   153                             # 0x99
        .half   621                             # 0x26d
        .half   567                             # 0x237
        .half   433                             # 0x1b1
        .half   163                             # 0xa3
        .half   87                              # 0x57
        .half   935                             # 0x3a7
        .half   718                             # 0x2ce
        .half   736                             # 0x2e0
        .half   92                              # 0x5c
        .half   866                             # 0x362
        .half   179                             # 0xb3
        .half   811                             # 0x32b
        .half   665                             # 0x299
        .half   751                             # 0x2ef
        .half   517                             # 0x205
        .half   316                             # 0x13c
        .half   733                             # 0x2dd
        .half   575                             # 0x23f
        .half   881                             # 0x371
        .half   857                             # 0x359
        .half   394                             # 0x18a
        .half   839                             # 0x347
        .half   498                             # 0x1f2
        .half   41                              # 0x29
        .half   40                              # 0x28
        .half   942                             # 0x3ae
        .half   217                             # 0xd9
        .half   255                             # 0xff
        .half   564                             # 0x234
        .half   656                             # 0x290
        .half   660                             # 0x294
        .half   967                             # 0x3c7
        .half   5                               # 0x5
        .half   544                             # 0x220
        .half   256                             # 0x100
        .half   240                             # 0xf0
        .half   795                             # 0x31b
        .half   762                             # 0x2fa
        .half   58                              # 0x3a
        .half   66                              # 0x42
        .half   344                             # 0x158
        .half   137                             # 0x89
        .half   279                             # 0x117
        .half   585                             # 0x249
        .half   528                             # 0x210
        .half   724                             # 0x2d4
        .half   44                              # 0x2c
        .half   633                             # 0x279
        .half   519                             # 0x207
        .half   530                             # 0x212
        .half   923                             # 0x39b
        .half   112                             # 0x70
        .half   162                             # 0xa2
        .half   837                             # 0x345
        .half   79                              # 0x4f
        .half   966                             # 0x3c6
        .half   878                             # 0x36e
        .half   528                             # 0x210
        .half   612                             # 0x264
        .half   148                             # 0x94
        .half   945                             # 0x3b1
        .half   630                             # 0x276
        .half   838                             # 0x346
        .half   804                             # 0x324
        .half   685                             # 0x2ad
        .half   248                             # 0xf8
        .half   720                             # 0x2d0
        .half   655                             # 0x28f
        .half   438                             # 0x1b6
        .half   12                              # 0xc
        .half   434                             # 0x1b2
        .half   645                             # 0x285
        .half   513                             # 0x201
        .half   651                             # 0x28b
        .half   125                             # 0x7d
        .half   824                             # 0x338
        .half   233                             # 0xe9
        .half   305                             # 0x131
        .half   925                             # 0x39d
        .half   729                             # 0x2d9
        .half   75                              # 0x4b
        .half   10                              # 0xa
        .half   619                             # 0x26b
        .half   409                             # 0x199
        .half   696                             # 0x2b8
        .half   309                             # 0x135
        .half   370                             # 0x172
        .half   952                             # 0x3b8
        .half   763                             # 0x2fb
        .half   822                             # 0x336
        .half   200                             # 0xc8
        .half   919                             # 0x397
        .half   100                             # 0x64
        .half   420                             # 0x1a4
        .half   182                             # 0xb6
        .half   444                             # 0x1bc
        .half   643                             # 0x283
        .half   559                             # 0x22f
        .half   835                             # 0x343
        .half   952                             # 0x3b8
        .half   594                             # 0x252
        .half   61                              # 0x3d
        .half   538                             # 0x21a
        .half   263                             # 0x107
        .half   142                             # 0x8e
        .half   875                             # 0x36b
        .half   247                             # 0xf7
        .half   834                             # 0x342
        .half   431                             # 0x1af
        .half   845                             # 0x34d
        .half   920                             # 0x398
        .half   835                             # 0x343
        .half   740                             # 0x2e4
        .half   72                              # 0x48
        .half   694                             # 0x2b6
        .half   336                             # 0x150
        .half   747                             # 0x2eb
        .half   918                             # 0x396
        .half   186                             # 0xba
        .half   221                             # 0xdd
        .half   749                             # 0x2ed
        .half   892                             # 0x37c
        .half   414                             # 0x19e
        .half   753                             # 0x2f1
        .half   969                             # 0x3c9
        .half   832                             # 0x340
        .half   335                             # 0x14f
        .half   632                             # 0x278
        .half   405                             # 0x195
        .half   521                             # 0x209
        .half   55                              # 0x37
        .half   669                             # 0x29d
        .half   986                             # 0x3da
        .half   612                             # 0x264
        .half   228                             # 0xe4
        .half   138                             # 0x8a
        .half   949                             # 0x3b5
        .half   602                             # 0x25a
        .half   440                             # 0x1b8
        .half   685                             # 0x2ad
        .half   393                             # 0x189
        .half   992                             # 0x3e0
        .half   643                             # 0x283
        .half   926                             # 0x39e
        .half   353                             # 0x161
        .half   983                             # 0x3d7
        .half   886                             # 0x376
        .half   343                             # 0x157
        .half   752                             # 0x2f0
        .half   782                             # 0x30e
        .half   469                             # 0x1d5
        .half   552                             # 0x228
        .half   670                             # 0x29e
        .half   748                             # 0x2ec
        .half   199                             # 0xc7
        .half   707                             # 0x2c3
        .half   88                              # 0x58
        .half   195                             # 0xc3
        .half   519                             # 0x207
        .half   306                             # 0x132
        .half   154                             # 0x9a
        .half   376                             # 0x178
        .half   858                             # 0x35a
        .half   213                             # 0xd5
        .half   36                              # 0x24
        .half   603                             # 0x25b
        .half   956                             # 0x3bc
        .half   952                             # 0x3b8
        .half   931                             # 0x3a3
        .half   994                             # 0x3e2
        .half   883                             # 0x373
        .half   862                             # 0x35e
        .half   633                             # 0x279
        .half   103                             # 0x67
        .half   670                             # 0x29e
        .half   770                             # 0x302
        .half   559                             # 0x22f
        .half   510                             # 0x1fe
        .half   634                             # 0x27a
        .half   129                             # 0x81
        .half   34                              # 0x22
        .half   576                             # 0x240
        .half   822                             # 0x336
        .half   923                             # 0x39b
        .half   177                             # 0xb1
        .half   493                             # 0x1ed
        .half   412                             # 0x19c
        .half   211                             # 0xd3
        .half   38                              # 0x26
        .half   467                             # 0x1d3
        .half   961                             # 0x3c1
        .half   538                             # 0x21a
        .half   431                             # 0x1af
        .half   390                             # 0x186
        .half   744                             # 0x2e8
        .half   207                             # 0xcf
        .half   576                             # 0x240
        .half   38                              # 0x26
        .half   715                             # 0x2cb
        .half   223                             # 0xdf
        .half   947                             # 0x3b3
        .half   116                             # 0x74
        .half   225                             # 0xe1
        .half   135                             # 0x87
        .half   162                             # 0xa2
        .half   513                             # 0x201
        .half   459                             # 0x1cb
        .half   359                             # 0x167
        .half   850                             # 0x352
        .half   434                             # 0x1b2
        .half   662                             # 0x296
        .half   254                             # 0xfe
        .half   808                             # 0x328
        .half   65                              # 0x41
        .half   469                             # 0x1d5
        .half   701                             # 0x2bd
        .half   532                             # 0x214
        .half   627                             # 0x273
        .half   245                             # 0xf5
        .half   918                             # 0x396
        .half   242                             # 0xf2
        .half   420                             # 0x1a4
        .half   525                             # 0x20d
        .half   456                             # 0x1c8
        .half   921                             # 0x399
        .half   922                             # 0x39a
        .half   813                             # 0x32d
        .half   847                             # 0x34f
        .half   204                             # 0xcc
        .half   736                             # 0x2e0
        .half   154                             # 0x9a
        .half   357                             # 0x165
        .half   204                             # 0xcc
        .half   253                             # 0xfd
        .half   928                             # 0x3a0
        .half   484                             # 0x1e4
        .half   387                             # 0x183
        .half   129                             # 0x81
        .half   335                             # 0x14f
        .half   691                             # 0x2b3
        .half   904                             # 0x388
        .half   524                             # 0x20c
        .half   174                             # 0xae
        .half   77                              # 0x4d
        .half   771                             # 0x303
        .half   857                             # 0x359
        .half   392                             # 0x188
        .half   704                             # 0x2c0
        .half   313                             # 0x139
        .half   934                             # 0x3a6
        .half   953                             # 0x3b9
        .half   51                              # 0x33
        .half   973                             # 0x3cd
        .half   180                             # 0xb4
        .half   420                             # 0x1a4
        .half   34                              # 0x22
        .half   34                              # 0x22
        .half   921                             # 0x399
        .half   172                             # 0xac
        .half   106                             # 0x6a
        .half   962                             # 0x3c2
        .half   510                             # 0x1fe
        .half   194                             # 0xc2
        .half   687                             # 0x2af
        .half   770                             # 0x302
        .half   12                              # 0xc
        .half   431                             # 0x1af
        .half   883                             # 0x373
        .half   812                             # 0x32c
        .half   161                             # 0xa1
        .half   573                             # 0x23d
        .half   483                             # 0x1e3
        .half   603                             # 0x25b
        .half   787                             # 0x313
        .half   273                             # 0x111
        .half   213                             # 0xd5
        .half   74                              # 0x4a
        .half   311                             # 0x137
        .half   560                             # 0x230
        .half   291                             # 0x123
        .half   628                             # 0x274
        .half   977                             # 0x3d1
        .half   708                             # 0x2c4
        .half   925                             # 0x39d
        .half   144                             # 0x90
        .half   626                             # 0x272
        .half   915                             # 0x393
        .half   311                             # 0x137
        .half   330                             # 0x14a
        .half   843                             # 0x34b
        .half   782                             # 0x30e
        .half   969                             # 0x3c9
        .half   981                             # 0x3d5
        .half   810                             # 0x32a
        .half   901                             # 0x385
        .half   154                             # 0x9a
        .half   123                             # 0x7b
        .half   543                             # 0x21f
        .half   968                             # 0x3c8
        .half   812                             # 0x32c
        .half   631                             # 0x277
        .half   51                              # 0x33
        .half   550                             # 0x226
        .half   364                             # 0x16c
        .half   339                             # 0x153
        .half   173                             # 0xad
        .half   813                             # 0x32d
        .half   826                             # 0x33a
        .half   753                             # 0x2f1
        .half   863                             # 0x35f
        .half   529                             # 0x211
        .half   388                             # 0x184
        .half   699                             # 0x2bb
        .half   205                             # 0xcd
        .half   1                               # 0x1
        .half   467                             # 0x1d3
        .half   588                             # 0x24c
        .half   830                             # 0x33e
        .half   65                              # 0x41
        .half   211                             # 0xd3
        .half   378                             # 0x17a
        .half   29                              # 0x1d
        .half   843                             # 0x34b
        .half   96                              # 0x60
        .half   179                             # 0xb3
        .half   977                             # 0x3d1
        .half   635                             # 0x27b
        .half   789                             # 0x315
        .half   498                             # 0x1f2
        .half   638                             # 0x27e
        .half   819                             # 0x333
        .half   502                             # 0x1f6
        .half   212                             # 0xd4
        .half   380                             # 0x17c
        .half   136                             # 0x88
        .half   721                             # 0x2d1
        .half   427                             # 0x1ab
        .half   831                             # 0x33f
        .half   679                             # 0x2a7
        .half   790                             # 0x316
        .half   696                             # 0x2b8
        .half   666                             # 0x29a
        .half   189                             # 0xbd
        .half   363                             # 0x16b
        .half   534                             # 0x216
        .half   80                              # 0x50
        .half   932                             # 0x3a4
        .half   334                             # 0x14e
        .half   30                              # 0x1e
        .half   256                             # 0x100
        .half   973                             # 0x3cd
        .half   290                             # 0x122
        .half   696                             # 0x2b8
        .half   885                             # 0x375
        .half   600                             # 0x258
        .half   172                             # 0xac
        .half   991                             # 0x3df
        .half   433                             # 0x1b1
        .half   429                             # 0x1ad
        .half   296                             # 0x128
        .half   689                             # 0x2b1
        .half   267                             # 0x10b
        .half   873                             # 0x369
        .half   700                             # 0x2bc
        .half   395                             # 0x18b
        .half   931                             # 0x3a3
        .half   878                             # 0x36e
        .half   550                             # 0x226
        .half   389                             # 0x185
        .half   534                             # 0x216
        .half   65                              # 0x41
        .half   270                             # 0x10e
        .half   924                             # 0x39c
        .half   670                             # 0x29e
        .half   166                             # 0xa6
        .half   330                             # 0x14a
        .half   853                             # 0x355
        .half   312                             # 0x138
        .half   132                             # 0x84
        .half   508                             # 0x1fc
        .half   729                             # 0x2d9
        .half   168                             # 0xa8
        .half   908                             # 0x38c
        .half   733                             # 0x2dd
        .half   328                             # 0x148
        .half   799                             # 0x31f
        .half   832                             # 0x340
        .half   963                             # 0x3c3
        .half   802                             # 0x322
        .half   311                             # 0x137
        .half   536                             # 0x218
        .half   930                             # 0x3a2
        .half   796                             # 0x31c
        .half   458                             # 0x1ca
        .half   383                             # 0x17f
        .half   134                             # 0x86
        .half   158                             # 0x9e
        .half   737                             # 0x2e1
        .half   937                             # 0x3a9
        .half   869                             # 0x365
        .half   683                             # 0x2ab
        .half   154                             # 0x9a
        .half   1                               # 0x1
        .half   634                             # 0x27a
        .half   435                             # 0x1b3
        .half   663                             # 0x297
        .half   300                             # 0x12c
        .half   626                             # 0x272
        .half   285                             # 0x11d
        .half   774                             # 0x306
        .half   686                             # 0x2ae
        .half   401                             # 0x191
        .half   340                             # 0x154
        .half   251                             # 0xfb
        .half   83                              # 0x53
        .half   50                              # 0x32
        .half   411                             # 0x19b
        .half   430                             # 0x1ae
        .half   775                             # 0x307
        .half   27                              # 0x1b
        .half   838                             # 0x346
        .half   905                             # 0x389
        .half   523                             # 0x20b
        .half   456                             # 0x1c8
        .half   853                             # 0x355
        .half   280                             # 0x118
        .half   877                             # 0x36d
        .half   858                             # 0x35a
        .half   16                              # 0x10
        .half   427                             # 0x1ab
        .half   621                             # 0x26d
        .half   772                             # 0x304
        .half   839                             # 0x347
        .half   485                             # 0x1e5
        .half   734                             # 0x2de
        .half   552                             # 0x228
        .half   756                             # 0x2f4
        .half   122                             # 0x7a
        .half   8                               # 0x8
        .half   333                             # 0x14d
        .half   222                             # 0xde
        .half   497                             # 0x1f1
        .half   236                             # 0xec
        .half   301                             # 0x12d
        .half   802                             # 0x322
        .half   607                             # 0x25f
        .half   323                             # 0x143
        .half   181                             # 0xb5
        .half   603                             # 0x25b
        .half   808                             # 0x328
        .half   154                             # 0x9a
        .half   553                             # 0x229
        .half   313                             # 0x139
        .half   946                             # 0x3b2
        .half   725                             # 0x2d5
        .half   589                             # 0x24d
        .half   858                             # 0x35a
        .half   692                             # 0x2b4
        .half   45                              # 0x2d
        .half   691                             # 0x2b3
        .half   296                             # 0x128
        .half   315                             # 0x13b
        .half   259                             # 0x103
        .half   109                             # 0x6d
        .half   243                             # 0xf3
        .half   376                             # 0x178
        .half   829                             # 0x33d
        .half   382                             # 0x17e
        .half   84                              # 0x54
        .half   611                             # 0x263
        .half   540                             # 0x21c
        .half   752                             # 0x2f0
        .half   281                             # 0x119
        .half   690                             # 0x2b2
        .half   157                             # 0x9d
        .half   297                             # 0x129
        .half   211                             # 0xd3
        .half   774                             # 0x306
        .half   399                             # 0x18f
        .half   207                             # 0xcf
        .half   658                             # 0x292
        .half   375                             # 0x177
        .half   962                             # 0x3c2
        .half   847                             # 0x34f
        .half   166                             # 0xa6
        .half   37                              # 0x25
        .half   223                             # 0xdf
        .half   117                             # 0x75
        .half   885                             # 0x375
        .half   644                             # 0x284
        .half   670                             # 0x29e
        .half   806                             # 0x326
        .half   682                             # 0x2aa
        .half   7                               # 0x7
        .half   861                             # 0x35d
        .half   945                             # 0x3b1
        .half   236                             # 0xec
        .half   461                             # 0x1cd
        .half   784                             # 0x310
        .half   460                             # 0x1cc
        .half   591                             # 0x24f
        .half   952                             # 0x3b8
        .half   338                             # 0x152
        .half   292                             # 0x124
        .half   318                             # 0x13e
        .half   881                             # 0x371
        .half   23                              # 0x17
        .half   910                             # 0x38e
        .half   167                             # 0xa7
        .half   907                             # 0x38b
        .half   23                              # 0x17
        .half   772                             # 0x304
        .half   432                             # 0x1b0
        .half   628                             # 0x274
        .half   902                             # 0x386
        .half   995                             # 0x3e3
        .half   557                             # 0x22d
        .half   407                             # 0x197
        .half   232                             # 0xe8
        .half   606                             # 0x25e
        .half   523                             # 0x20b
        .half   335                             # 0x14f
        .half   595                             # 0x253
        .half   62                              # 0x3e
        .half   936                             # 0x3a8
        .half   958                             # 0x3be
        .half   913                             # 0x391
        .half   338                             # 0x152
        .half   440                             # 0x1b8
        .half   598                             # 0x256
        .half   124                             # 0x7c
        .half   391                             # 0x187
        .half   123                             # 0x7b
        .half   884                             # 0x374
        .half   422                             # 0x1a6
        .half   569                             # 0x239
        .half   136                             # 0x88
        .half   479                             # 0x1df
        .half   205                             # 0xcd
        .half   134                             # 0x86
        .half   271                             # 0x10f
        .half   232                             # 0xe8
        .half   148                             # 0x94
        .half   351                             # 0x15f
        .half   703                             # 0x2bf
        .half   42                              # 0x2a
        .half   592                             # 0x250
        .half   958                             # 0x3be
        .half   778                             # 0x30a
        .half   692                             # 0x2b4
        .half   724                             # 0x2d4
        .half   943                             # 0x3af
        .half   439                             # 0x1b7
        .half   584                             # 0x248
        .half   578                             # 0x242
        .half   185                             # 0xb9
        .half   214                             # 0xd6
        .half   672                             # 0x2a0
        .half   619                             # 0x26b
        .half   918                             # 0x396
        .half   560                             # 0x230
        .half   866                             # 0x362
        .half   136                             # 0x88
        .half   390                             # 0x186
        .half   795                             # 0x31b
        .half   988                             # 0x3dc
        .half   229                             # 0xe5
        .half   103                             # 0x67
        .half   65                              # 0x41
        .half   352                             # 0x160
        .half   598                             # 0x256
        .half   728                             # 0x2d8
        .half   753                             # 0x2f1
        .half   210                             # 0xd2
        .half   670                             # 0x29e
        .half   240                             # 0xf0
        .half   612                             # 0x264
        .half   698                             # 0x2ba
        .half   155                             # 0x9b
        .half   793                             # 0x319
        .half   307                             # 0x133
        .half   390                             # 0x186
        .half   534                             # 0x216
        .half   484                             # 0x1e4
        .half   476                             # 0x1dc
        .half   835                             # 0x343
        .half   786                             # 0x312
        .half   564                             # 0x234
        .half   337                             # 0x151
        .half   160                             # 0xa0
        .half   2                               # 0x2
        .half   783                             # 0x30f
        .half   222                             # 0xde
        .half   379                             # 0x17b
        .half   237                             # 0xed
        .half   349                             # 0x15d
        .half   434                             # 0x1b2
        .half   488                             # 0x1e8
        .half   381                             # 0x17d
        .half   888                             # 0x378
        .half   335                             # 0x14f
        .half   229                             # 0xe5
        .half   100                             # 0x64
        .half   442                             # 0x1ba
        .half   324                             # 0x144
        .half   828                             # 0x33c
        .half   237                             # 0xed
        .half   833                             # 0x341
        .half   716                             # 0x2cc
        .half   969                             # 0x3c9
        .half   179                             # 0xb3
        .half   350                             # 0x15e
        .half   603                             # 0x25b
        .half   784                             # 0x310
        .half   878                             # 0x36e
        .half   454                             # 0x1c6
        .half   127                             # 0x7f
        .half   519                             # 0x207
        .half   955                             # 0x3bb
        .half   168                             # 0xa8
        .half   6                               # 0x6
        .half   31                              # 0x1f
        .half   509                             # 0x1fd
        .half   192                             # 0xc0
        .half   721                             # 0x2d1
        .half   817                             # 0x331
        .half   364                             # 0x16c
        .half   287                             # 0x11f
        .half   839                             # 0x347
        .half   166                             # 0xa6
        .half   168                             # 0xa8
        .half   55                              # 0x37
        .half   919                             # 0x397
        .half   741                             # 0x2e5
        .half   101                             # 0x65
        .half   784                             # 0x310
        .half   320                             # 0x140
        .half   598                             # 0x256
        .half   482                             # 0x1e2
        .half   455                             # 0x1c7
        .half   865                             # 0x361
        .half   917                             # 0x395
        .half   122                             # 0x7a
        .half   279                             # 0x117
        .half   581                             # 0x245
        .half   380                             # 0x17c
        .half   36                              # 0x24
        .half   134                             # 0x86
        .half   764                             # 0x2fc
        .half   769                             # 0x301
        .half   666                             # 0x29a
        .half   628                             # 0x274
        .half   860                             # 0x35c
        .half   555                             # 0x22b
        .half   91                              # 0x5b
        .half   669                             # 0x29d
        .half   248                             # 0xf8
        .half   49                              # 0x31
        .half   836                             # 0x344
        .half   652                             # 0x28c
        .half   628                             # 0x274
        .half   213                             # 0xd5
        .half   636                             # 0x27c
        .half   896                             # 0x380
        .half   760                             # 0x2f8
        .half   298                             # 0x12a
        .half   569                             # 0x239
        .half   389                             # 0x185
        .half   755                             # 0x2f3
        .half   926                             # 0x39e
        .half   385                             # 0x181
        .half   847                             # 0x34f
        .half   456                             # 0x1c8
        .half   62                              # 0x3e
        .half   905                             # 0x389
        .half   510                             # 0x1fe
        .half   277                             # 0x115
        .half   707                             # 0x2c3
        .half   146                             # 0x92
        .half   371                             # 0x173
        .half   270                             # 0x10e
        .half   683                             # 0x2ab
        .half   991                             # 0x3df
        .half   670                             # 0x29e
        .half   208                             # 0xd0
        .half   591                             # 0x24f
        .half   477                             # 0x1dd
        .half   830                             # 0x33e
        .half   344                             # 0x158
        .half   124                             # 0x7c
        .half   420                             # 0x1a4
        .half   919                             # 0x397
        .half   784                             # 0x310
        .half   496                             # 0x1f0
        .half   992                             # 0x3e0
        .half   445                             # 0x1bd
        .half   276                             # 0x114
        .half   515                             # 0x203
        .half   363                             # 0x16b
        .half   177                             # 0xb1
        .half   233                             # 0xe9
        .half   297                             # 0x129
        .half   154                             # 0x9a
        .half   683                             # 0x2ab
        .half   423                             # 0x1a7

expect:
        .half   821                             # 0x335
        .half   993                             # 0x3e1
        .half   955                             # 0x3bb
        .half   833                             # 0x341
        .half   991                             # 0x3df
        .half   937                             # 0x3a9
        .half   997                             # 0x3e5
        .half   941                             # 0x3ad
        .half   983                             # 0x3d7
        .half   986                             # 0x3da
        .half   880                             # 0x370
        .half   920                             # 0x398
        .half   983                             # 0x3d7
        .half   998                             # 0x3e6
        .half   998                             # 0x3e6
        .half   937                             # 0x3a9
        .half   926                             # 0x39e
        .half   935                             # 0x3a7
        .half   952                             # 0x3b8
        .half   895                             # 0x37f
        .half   987                             # 0x3db
        .half   973                             # 0x3cd
        .half   994                             # 0x3e2
        .half   967                             # 0x3c7
        .half   986                             # 0x3da
        .half   956                             # 0x3bc
        .half   994                             # 0x3e2
        .half   992                             # 0x3e0
        .half   983                             # 0x3d7
        .half   952                             # 0x3b8
        .half   969                             # 0x3c9
        .half   961                             # 0x3c1
        .half   981                             # 0x3d5
        .half   947                             # 0x3b3
        .half   968                             # 0x3c8
        .half   904                             # 0x388
        .half   826                             # 0x33a
        .half   863                             # 0x35f
        .half   977                             # 0x3d1
        .half   921                             # 0x399
        .half   991                             # 0x3df
        .half   977                             # 0x3d1
        .half   877                             # 0x36d
        .half   937                             # 0x3a9
        .half   924                             # 0x39c
        .half   853                             # 0x355
        .half   932                             # 0x3a4
        .half   973                             # 0x3cd
        .half   995                             # 0x3e3
        .half   946                             # 0x3b2
        .half   936                             # 0x3a8
        .half   958                             # 0x3be
        .half   866                             # 0x362
        .half   988                             # 0x3dc
        .half   910                             # 0x38e
        .half   907                             # 0x38b
        .half   969                             # 0x3c9
        .half   878                             # 0x36e
        .half   991                             # 0x3df
        .half   830                             # 0x33e
        .half   919                             # 0x397
        .half   992                             # 0x3e0
        .half   784                             # 0x310
        .half   926                             # 0x39e

result:
        .zero   128

stack:
        .zero   4096
endstack:

errors:
        .word   0xffffffff

RVTEST_DATA_END
