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
        li      a2, 16
        li      a3, 16
        li      a4, 2
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
        .half   780                             # 0x30c
        .half   9                               # 0x9
        .half   440                             # 0x1b8
        .half   895                             # 0x37f
        .half   405                             # 0x195
        .half   10                              # 0xa
        .half   962                             # 0x3c2
        .half   884                             # 0x374
        .half   450                             # 0x1c2
        .half   398                             # 0x18e
        .half   183                             # 0xb7
        .half   35                              # 0x23
        .half   107                             # 0x6b
        .half   789                             # 0x315
        .half   380                             # 0x17c
        .half   304                             # 0x130
        .half   719                             # 0x2cf
        .half   160                             # 0xa0
        .half   451                             # 0x1c3
        .half   422                             # 0x1a6
        .half   72                              # 0x48
        .half   716                             # 0x2cc
        .half   877                             # 0x36d
        .half   669                             # 0x29d
        .half   119                             # 0x77
        .half   916                             # 0x394
        .half   650                             # 0x28a
        .half   426                             # 0x1aa
        .half   845                             # 0x34d
        .half   131                             # 0x83
        .half   659                             # 0x293
        .half   926                             # 0x39e
        .half   531                             # 0x213
        .half   406                             # 0x196
        .half   490                             # 0x1ea
        .half   218                             # 0xda
        .half   300                             # 0x12c
        .half   6                               # 0x6
        .half   564                             # 0x234
        .half   839                             # 0x347
        .half   218                             # 0xda
        .half   814                             # 0x32e
        .half   800                             # 0x320
        .half   432                             # 0x1b0
        .half   913                             # 0x391
        .half   634                             # 0x27a
        .half   61                              # 0x3d
        .half   41                              # 0x29
        .half   751                             # 0x2ef
        .half   392                             # 0x188
        .half   374                             # 0x176
        .half   278                             # 0x116
        .half   154                             # 0x9a
        .half   55                              # 0x37
        .half   773                             # 0x305
        .half   910                             # 0x38e
        .half   967                             # 0x3c7
        .half   142                             # 0x8e
        .half   958                             # 0x3be
        .half   646                             # 0x286
        .half   310                             # 0x136
        .half   418                             # 0x1a2
        .half   898                             # 0x382
        .half   682                             # 0x2aa
        .half   947                             # 0x3b3
        .half   361                             # 0x169
        .half   967                             # 0x3c7
        .half   434                             # 0x1b2
        .half   206                             # 0xce
        .half   660                             # 0x294
        .half   628                             # 0x274
        .half   579                             # 0x243
        .half   266                             # 0x10a
        .half   733                             # 0x2dd
        .half   845                             # 0x34d
        .half   321                             # 0x141
        .half   206                             # 0xce
        .half   938                             # 0x3aa
        .half   859                             # 0x35b
        .half   505                             # 0x1f9
        .half   397                             # 0x18d
        .half   753                             # 0x2f1
        .half   461                             # 0x1cd
        .half   665                             # 0x299
        .half   727                             # 0x2d7
        .half   955                             # 0x3bb
        .half   615                             # 0x267
        .half   957                             # 0x3bd
        .half   844                             # 0x34c
        .half   245                             # 0xf5
        .half   438                             # 0x1b6
        .half   586                             # 0x24a
        .half   36                              # 0x24
        .half   358                             # 0x166
        .half   103                             # 0x67
        .half   496                             # 0x1f0
        .half   345                             # 0x159
        .half   517                             # 0x205
        .half   113                             # 0x71
        .half   783                             # 0x30f
        .half   946                             # 0x3b2
        .half   377                             # 0x179
        .half   700                             # 0x2bc
        .half   625                             # 0x271
        .half   641                             # 0x281
        .half   75                              # 0x4b
        .half   535                             # 0x217
        .half   241                             # 0xf1
        .half   17                              # 0x11
        .half   64                              # 0x40
        .half   563                             # 0x233
        .half   243                             # 0xf3
        .half   115                             # 0x73
        .half   636                             # 0x27c
        .half   543                             # 0x21f
        .half   894                             # 0x37e
        .half   515                             # 0x203
        .half   686                             # 0x2ae
        .half   522                             # 0x20a
        .half   673                             # 0x2a1
        .half   632                             # 0x278
        .half   244                             # 0xf4
        .half   585                             # 0x249
        .half   775                             # 0x307
        .half   115                             # 0x73
        .half   716                             # 0x2cc
        .half   516                             # 0x204
        .half   666                             # 0x29a
        .half   646                             # 0x286
        .half   794                             # 0x31a
        .half   956                             # 0x3bc
        .half   221                             # 0xdd
        .half   449                             # 0x1c1
        .half   223                             # 0xdf
        .half   377                             # 0x179
        .half   656                             # 0x290
        .half   296                             # 0x128
        .half   231                             # 0xe7
        .half   202                             # 0xca
        .half   204                             # 0xcc
        .half   933                             # 0x3a5
        .half   493                             # 0x1ed
        .half   443                             # 0x1bb
        .half   260                             # 0x104
        .half   515                             # 0x203
        .half   56                              # 0x38
        .half   26                              # 0x1a
        .half   885                             # 0x375
        .half   2                               # 0x2
        .half   967                             # 0x3c7
        .half   647                             # 0x287
        .half   293                             # 0x125
        .half   246                             # 0xf6
        .half   886                             # 0x376
        .half   830                             # 0x33e
        .half   465                             # 0x1d1
        .half   599                             # 0x257
        .half   750                             # 0x2ee
        .half   944                             # 0x3b0
        .half   27                              # 0x1b
        .half   913                             # 0x391
        .half   846                             # 0x34e
        .half   174                             # 0xae
        .half   745                             # 0x2e9
        .half   285                             # 0x11d
        .half   251                             # 0xfb
        .half   192                             # 0xc0
        .half   125                             # 0x7d
        .half   893                             # 0x37d
        .half   100                             # 0x64
        .half   971                             # 0x3cb
        .half   938                             # 0x3aa
        .half   428                             # 0x1ac
        .half   219                             # 0xdb
        .half   530                             # 0x212
        .half   79                              # 0x4f
        .half   268                             # 0x10c
        .half   534                             # 0x216
        .half   726                             # 0x2d6
        .half   483                             # 0x1e3
        .half   85                              # 0x55
        .half   850                             # 0x352
        .half   319                             # 0x13f
        .half   616                             # 0x268
        .half   882                             # 0x372
        .half   656                             # 0x290
        .half   194                             # 0xc2
        .half   990                             # 0x3de
        .half   690                             # 0x2b2
        .half   822                             # 0x336
        .half   322                             # 0x142
        .half   838                             # 0x346
        .half   3                               # 0x3
        .half   317                             # 0x13d
        .half   735                             # 0x2df
        .half   739                             # 0x2e3
        .half   968                             # 0x3c8
        .half   142                             # 0x8e
        .half   959                             # 0x3bf
        .half   771                             # 0x303
        .half   445                             # 0x1bd
        .half   569                             # 0x239
        .half   620                             # 0x26c
        .half   760                             # 0x2f8
        .half   510                             # 0x1fe
        .half   848                             # 0x350
        .half   115                             # 0x73
        .half   610                             # 0x262
        .half   960                             # 0x3c0
        .half   446                             # 0x1be
        .half   856                             # 0x358
        .half   403                             # 0x193
        .half   770                             # 0x302
        .half   431                             # 0x1af
        .half   705                             # 0x2c1
        .half   892                             # 0x37c
        .half   110                             # 0x6e
        .half   134                             # 0x86
        .half   653                             # 0x28d
        .half   206                             # 0xce
        .half   958                             # 0x3be
        .half   106                             # 0x6a
        .half   748                             # 0x2ec
        .half   323                             # 0x143
        .half   323                             # 0x143
        .half   981                             # 0x3d5
        .half   841                             # 0x349
        .half   143                             # 0x8f
        .half   243                             # 0xf3
        .half   368                             # 0x170
        .half   824                             # 0x338
        .half   580                             # 0x244
        .half   898                             # 0x382
        .half   981                             # 0x3d5
        .half   366                             # 0x16e
        .half   617                             # 0x269
        .half   692                             # 0x2b4
        .half   548                             # 0x224
        .half   970                             # 0x3ca
        .half   811                             # 0x32b
        .half   144                             # 0x90
        .half   588                             # 0x24c
        .half   682                             # 0x2aa
        .half   697                             # 0x2b9
        .half   46                              # 0x2e
        .half   796                             # 0x31c
        .half   485                             # 0x1e5
        .half   369                             # 0x171
        .half   332                             # 0x14c
        .half   188                             # 0xbc
        .half   724                             # 0x2d4
        .half   3                               # 0x3
        .half   353                             # 0x161
        .half   448                             # 0x1c0
        .half   375                             # 0x177
        .half   39                              # 0x27

expect:
        .half   780                             # 0x30c
        .half   895                             # 0x37f
        .half   716                             # 0x2cc
        .half   962                             # 0x3c2
        .half   916                             # 0x394
        .half   650                             # 0x28a
        .half   845                             # 0x34d
        .half   926                             # 0x39e
        .half   751                             # 0x2ef
        .half   490                             # 0x1ea
        .half   300                             # 0x12c
        .half   910                             # 0x38e
        .half   967                             # 0x3c7
        .half   958                             # 0x3be
        .half   913                             # 0x391
        .half   898                             # 0x382
        .half   947                             # 0x3b3
        .half   967                             # 0x3c7
        .half   955                             # 0x3bb
        .half   957                             # 0x3bd
        .half   844                             # 0x34c
        .half   845                             # 0x34d
        .half   938                             # 0x3aa
        .half   859                             # 0x35b
        .half   636                             # 0x27c
        .half   894                             # 0x37e
        .half   946                             # 0x3b2
        .half   700                             # 0x2bc
        .half   641                             # 0x281
        .half   775                             # 0x307
        .half   716                             # 0x2cc
        .half   666                             # 0x29a
        .half   794                             # 0x31a
        .half   956                             # 0x3bc
        .half   967                             # 0x3c7
        .half   656                             # 0x290
        .half   886                             # 0x376
        .half   830                             # 0x33e
        .half   933                             # 0x3a5
        .half   944                             # 0x3b0
        .half   913                             # 0x391
        .half   745                             # 0x2e9
        .half   850                             # 0x352
        .half   616                             # 0x268
        .half   893                             # 0x37d
        .half   990                             # 0x3de
        .half   822                             # 0x336
        .half   838                             # 0x346
        .half   960                             # 0x3c0
        .half   856                             # 0x358
        .half   968                             # 0x3c8
        .half   959                             # 0x3bf
        .half   569                             # 0x239
        .half   760                             # 0x2f8
        .half   958                             # 0x3be
        .half   748                             # 0x2ec
        .half   981                             # 0x3d5
        .half   841                             # 0x349
        .half   796                             # 0x31c
        .half   824                             # 0x338
        .half   981                             # 0x3d5
        .half   724                             # 0x2d4
        .half   692                             # 0x2b4
        .half   970                             # 0x3ca

result:
        .zero   128

stack:
        .zero   4096
endstack:

errors:
        .word   0xffffffff

RVTEST_DATA_END
