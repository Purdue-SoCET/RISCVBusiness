# See LICENSE for license details.

#*****************************************************************************
# lininterp.S
#-----------------------------------------------------------------------------
#
# Linear interpolation by a factor of two of a sine wave
#

#include "riscv_test.h"
#include "test_macros.h"


RVTEST_RV32U

RVTEST_CODE_BEGIN
        // Jump to main (will halt there)
        la      sp, endstack
        j       main

lininterp:                              # @lininterp
        li      a3, 2
        blt     a2, a3, .LBB0_3
        lhu     a4, 0(a0)
        addi    a3, a0, 2
        addi    a1, a1, 2
        slli    a2, a2, 1
        add     a0, a0, a2
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
        sh      a4, -2(a1)
        slli    a2, a4, 16
        lhu     a4, 0(a3)
        srai    a2, a2, 16
        slli    a5, a4, 16
        srai    a5, a5, 16
        add     a2, a2, a5
        srli    a5, a2, 31
        add     a2, a2, a5
        srli    a2, a2, 1
        sh      a2, 0(a1)
        addi    a3, a3, 2
        addi    a1, a1, 4
        bne     a3, a0, .LBB0_2
.LBB0_3:
        ret
main:                                   # @main
        addi    sp, sp, -16
        sw      ra, 12(sp)                      # 4-byte Folded Spill
        lui     a0, %hi(input)
        addi    a0, a0, %lo(input)
        lui     a1, %hi(output)
        addi    a1, a1, %lo(output)
        li      a2, 256
        call    lininterp
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

input:
        .half   0                               # 0x0
        .half   1284                            # 0x504
        .half   2567                            # 0xa07
        .half   3846                            # 0xf06
        .half   5119                            # 0x13ff
        .half   6384                            # 0x18f0
        .half   7639                            # 0x1dd7
        .half   8882                            # 0x22b2
        .half   10112                           # 0x2780
        .half   11326                           # 0x2c3e
        .half   12523                           # 0x30eb
        .half   13700                           # 0x3584
        .half   14857                           # 0x3a09
        .half   15990                           # 0x3e76
        .half   17100                           # 0x42cc
        .half   18182                           # 0x4706
        .half   19237                           # 0x4b25
        .half   20262                           # 0x4f26
        .half   21256                           # 0x5308
        .half   22218                           # 0x56ca
        .half   23145                           # 0x5a69
        .half   24036                           # 0x5de4
        .half   24891                           # 0x613b
        .half   25707                           # 0x646b
        .half   26484                           # 0x6774
        .half   27220                           # 0x6a54
        .half   27915                           # 0x6d0b
        .half   28566                           # 0x6f96
        .half   29173                           # 0x71f5
        .half   29736                           # 0x7428
        .half   30253                           # 0x762d
        .half   30723                           # 0x7803
        .half   31146                           # 0x79aa
        .half   31521                           # 0x7b21
        .half   31848                           # 0x7c68
        .half   32126                           # 0x7d7e
        .half   32354                           # 0x7e62
        .half   32533                           # 0x7f15
        .half   32661                           # 0x7f95
        .half   32739                           # 0x7fe3
        .half   32767                           # 0x7fff
        .half   32745                           # 0x7fe9
        .half   32672                           # 0x7fa0
        .half   32549                           # 0x7f25
        .half   32376                           # 0x7e78
        .half   32153                           # 0x7d99
        .half   31881                           # 0x7c89
        .half   31560                           # 0x7b48
        .half   31190                           # 0x79d6
        .half   30772                           # 0x7834
        .half   30307                           # 0x7663
        .half   29795                           # 0x7463
        .half   29238                           # 0x7236
        .half   28635                           # 0x6fdb
        .half   27989                           # 0x6d55
        .half   27299                           # 0x6aa3
        .half   26568                           # 0x67c8
        .half   25795                           # 0x64c3
        .half   24983                           # 0x6197
        .half   24133                           # 0x5e45
        .half   23245                           # 0x5acd
        .half   22322                           # 0x5732
        .half   21364                           # 0x5374
        .half   20374                           # 0x4f96
        .half   19352                           # 0x4b98
        .half   18300                           # 0x477c
        .half   17221                           # 0x4345
        .half   16114                           # 0x3ef2
        .half   14983                           # 0x3a87
        .half   13829                           # 0x3605
        .half   12654                           # 0x316e
        .half   11459                           # 0x2cc3
        .half   10247                           # 0x2807
        .half   9019                            # 0x233b
        .half   7777                            # 0x1e61
        .half   6523                            # 0x197b
        .half   5259                            # 0x148b
        .half   3987                            # 0xf93
        .half   2709                            # 0xa95
        .half   1426                            # 0x592
        .half   142                             # 0x8e
        .half   64394                           # 0xfb8a
        .half   63111                           # 0xf687
        .half   61832                           # 0xf188
        .half   60558                           # 0xec8e
        .half   59292                           # 0xe79c
        .half   58036                           # 0xe2b4
        .half   56791                           # 0xddd7
        .half   55559                           # 0xd907
        .half   54343                           # 0xd447
        .half   53145                           # 0xcf99
        .half   51965                           # 0xcafd
        .half   50806                           # 0xc676
        .half   49670                           # 0xc206
        .half   48558                           # 0xbdae
        .half   47472                           # 0xb970
        .half   46414                           # 0xb54e
        .half   45386                           # 0xb14a
        .half   44388                           # 0xad64
        .half   43423                           # 0xa99f
        .half   42492                           # 0xa5fc
        .half   41596                           # 0xa27c
        .half   40738                           # 0x9f22
        .half   39917                           # 0x9bed
        .half   39136                           # 0x98e0
        .half   38395                           # 0x95fb
        .half   37696                           # 0x9340
        .half   37040                           # 0x90b0
        .half   36428                           # 0x8e4c
        .half   35860                           # 0x8c14
        .half   35338                           # 0x8a0a
        .half   34863                           # 0x882f
        .half   34434                           # 0x8682
        .half   34054                           # 0x8506
        .half   33722                           # 0x83ba
        .half   33439                           # 0x829f
        .half   33205                           # 0x81b5
        .half   33021                           # 0x80fd
        .half   32887                           # 0x8077
        .half   32803                           # 0x8023
        .half   32769                           # 0x8001
        .half   32786                           # 0x8012
        .half   32853                           # 0x8055
        .half   32971                           # 0x80cb
        .half   33138                           # 0x8172
        .half   33356                           # 0x824c
        .half   33622                           # 0x8356
        .half   33938                           # 0x8492
        .half   34303                           # 0x85ff
        .half   34715                           # 0x879b
        .half   35175                           # 0x8967
        .half   35682                           # 0x8b62
        .half   36234                           # 0x8d8a
        .half   36832                           # 0x8fe0
        .half   37474                           # 0x9262
        .half   38158                           # 0x950e
        .half   38885                           # 0x97e5
        .half   39653                           # 0x9ae5
        .half   40461                           # 0x9e0d
        .half   41307                           # 0xa15b
        .half   42191                           # 0xa4cf
        .half   43110                           # 0xa866
        .half   44064                           # 0xac20
        .half   45051                           # 0xaffb
        .half   46070                           # 0xb3f6
        .half   47118                           # 0xb80e
        .half   48195                           # 0xbc43
        .half   49298                           # 0xc092
        .half   50426                           # 0xc4fa
        .half   51578                           # 0xc97a
        .half   52751                           # 0xce0f
        .half   53944                           # 0xd2b8
        .half   55154                           # 0xd772
        .half   56381                           # 0xdc3d
        .half   57621                           # 0xe115
        .half   58874                           # 0xe5fa
        .half   60137                           # 0xeae9
        .half   61408                           # 0xefe0
        .half   62686                           # 0xf4de
        .half   63968                           # 0xf9e0
        .half   65252                           # 0xfee4
        .half   1000                            # 0x3e8
        .half   2283                            # 0x8eb
        .half   3563                            # 0xdeb
        .half   4838                            # 0x12e6
        .half   6104                            # 0x17d8
        .half   7362                            # 0x1cc2
        .half   8608                            # 0x21a0
        .half   9841                            # 0x2671
        .half   11059                           # 0x2b33
        .half   12260                           # 0x2fe4
        .half   13442                           # 0x3482
        .half   14603                           # 0x390b
        .half   15742                           # 0x3d7e
        .half   16856                           # 0x41d8
        .half   17945                           # 0x4619
        .half   19006                           # 0x4a3e
        .half   20038                           # 0x4e46
        .half   21039                           # 0x522f
        .half   22008                           # 0x55f8
        .half   22943                           # 0x599f
        .half   23842                           # 0x5d22
        .half   24705                           # 0x6081
        .half   25530                           # 0x63ba
        .half   26316                           # 0x66cc
        .half   27061                           # 0x69b5
        .half   27765                           # 0x6c75
        .half   28426                           # 0x6f0a
        .half   29043                           # 0x7173
        .half   29615                           # 0x73af
        .half   30142                           # 0x75be
        .half   30623                           # 0x779f
        .half   31057                           # 0x7951
        .half   31442                           # 0x7ad2
        .half   31780                           # 0x7c24
        .half   32068                           # 0x7d44
        .half   32308                           # 0x7e34
        .half   32497                           # 0x7ef1
        .half   32637                           # 0x7f7d
        .half   32726                           # 0x7fd6
        .half   32766                           # 0x7ffe
        .half   32754                           # 0x7ff2
        .half   32693                           # 0x7fb5
        .half   32581                           # 0x7f45
        .half   32419                           # 0x7ea3
        .half   32207                           # 0x7dcf
        .half   31946                           # 0x7cca
        .half   31635                           # 0x7b93
        .half   31276                           # 0x7a2c
        .half   30869                           # 0x7895
        .half   30414                           # 0x76ce
        .half   29913                           # 0x74d9
        .half   29365                           # 0x72b5
        .half   28772                           # 0x7064
        .half   28136                           # 0x6de8
        .half   27455                           # 0x6b3f
        .half   26733                           # 0x686d
        .half   25970                           # 0x6572
        .half   25166                           # 0x624e
        .half   24324                           # 0x5f04
        .half   23445                           # 0x5b95
        .half   22529                           # 0x5801
        .half   21579                           # 0x544b
        .half   20596                           # 0x5074
        .half   19581                           # 0x4c7d
        .half   18535                           # 0x4867
        .half   17462                           # 0x4436
        .half   16361                           # 0x3fe9
        .half   15236                           # 0x3b84
        .half   14087                           # 0x3707
        .half   12916                           # 0x3274
        .half   11725                           # 0x2dcd
        .half   10517                           # 0x2915
        .half   9292                            # 0x244c
        .half   8053                            # 0x1f75
        .half   6801                            # 0x1a91
        .half   5539                            # 0x15a3
        .half   4269                            # 0x10ad
        .half   2992                            # 0xbb0
        .half   1710                            # 0x6ae
        .half   426                             # 0x1aa
        .half   64678                           # 0xfca6
        .half   63394                           # 0xf7a2
        .half   62114                           # 0xf2a2
        .half   60839                           # 0xeda7
        .half   59571                           # 0xe8b3
        .half   58313                           # 0xe3c9
        .half   57065                           # 0xdee9
        .half   55831                           # 0xda17
        .half   54611                           # 0xd553
        .half   53408                           # 0xd0a0
        .half   52224                           # 0xcc00
        .half   51060                           # 0xc774
        .half   49919                           # 0xc2ff
        .half   48802                           # 0xbea2
        .half   47710                           # 0xba5e

output:
        .zero   1024

        .align 4
stack:
        .zero   4096
endstack:

errors:
        .word   0xffffffff

RVTEST_DATA_END
