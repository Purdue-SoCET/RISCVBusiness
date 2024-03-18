# See LICENSE for license details.

#*****************************************************************************
# Test load/store strided, e16, vl64
#-----------------------------------------------------------------------------
#
# Generated using gen_ldst_test.py
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN
# Setup tasks
    li x7, 64
    vsetvli x8, x7, e16, m8

    la x1, in_data
    la x2, out_data
# Vector load/store instructions
    li x3, 6

    vlse16.v v8, (x1), x3

    vsse16.v v8, (x2), x3

# Check data at byte offset 0
    lb x11, 0(x1)
    lb x12, 0(x2)
    li TESTNUM, 0
    bne x11, x12, fail
# Check data at byte offset 1
    lb x11, 1(x1)
    lb x12, 1(x2)
    li TESTNUM, 1
    bne x11, x12, fail
# Check data at byte offset 6
    lb x11, 6(x1)
    lb x12, 6(x2)
    li TESTNUM, 6
    bne x11, x12, fail
# Check data at byte offset 7
    lb x11, 7(x1)
    lb x12, 7(x2)
    li TESTNUM, 7
    bne x11, x12, fail
# Check data at byte offset 12
    lb x11, 12(x1)
    lb x12, 12(x2)
    li TESTNUM, 12
    bne x11, x12, fail
# Check data at byte offset 13
    lb x11, 13(x1)
    lb x12, 13(x2)
    li TESTNUM, 13
    bne x11, x12, fail
# Check data at byte offset 18
    lb x11, 18(x1)
    lb x12, 18(x2)
    li TESTNUM, 18
    bne x11, x12, fail
# Check data at byte offset 19
    lb x11, 19(x1)
    lb x12, 19(x2)
    li TESTNUM, 19
    bne x11, x12, fail
# Check data at byte offset 24
    lb x11, 24(x1)
    lb x12, 24(x2)
    li TESTNUM, 24
    bne x11, x12, fail
# Check data at byte offset 25
    lb x11, 25(x1)
    lb x12, 25(x2)
    li TESTNUM, 25
    bne x11, x12, fail
# Check data at byte offset 30
    lb x11, 30(x1)
    lb x12, 30(x2)
    li TESTNUM, 30
    bne x11, x12, fail
# Check data at byte offset 31
    lb x11, 31(x1)
    lb x12, 31(x2)
    li TESTNUM, 31
    bne x11, x12, fail
# Check data at byte offset 36
    lb x11, 36(x1)
    lb x12, 36(x2)
    li TESTNUM, 36
    bne x11, x12, fail
# Check data at byte offset 37
    lb x11, 37(x1)
    lb x12, 37(x2)
    li TESTNUM, 37
    bne x11, x12, fail
# Check data at byte offset 42
    lb x11, 42(x1)
    lb x12, 42(x2)
    li TESTNUM, 42
    bne x11, x12, fail
# Check data at byte offset 43
    lb x11, 43(x1)
    lb x12, 43(x2)
    li TESTNUM, 43
    bne x11, x12, fail
# Check data at byte offset 48
    lb x11, 48(x1)
    lb x12, 48(x2)
    li TESTNUM, 48
    bne x11, x12, fail
# Check data at byte offset 49
    lb x11, 49(x1)
    lb x12, 49(x2)
    li TESTNUM, 49
    bne x11, x12, fail
# Check data at byte offset 54
    lb x11, 54(x1)
    lb x12, 54(x2)
    li TESTNUM, 54
    bne x11, x12, fail
# Check data at byte offset 55
    lb x11, 55(x1)
    lb x12, 55(x2)
    li TESTNUM, 55
    bne x11, x12, fail
# Check data at byte offset 60
    lb x11, 60(x1)
    lb x12, 60(x2)
    li TESTNUM, 60
    bne x11, x12, fail
# Check data at byte offset 61
    lb x11, 61(x1)
    lb x12, 61(x2)
    li TESTNUM, 61
    bne x11, x12, fail
# Check data at byte offset 66
    lb x11, 66(x1)
    lb x12, 66(x2)
    li TESTNUM, 66
    bne x11, x12, fail
# Check data at byte offset 67
    lb x11, 67(x1)
    lb x12, 67(x2)
    li TESTNUM, 67
    bne x11, x12, fail
# Check data at byte offset 72
    lb x11, 72(x1)
    lb x12, 72(x2)
    li TESTNUM, 72
    bne x11, x12, fail
# Check data at byte offset 73
    lb x11, 73(x1)
    lb x12, 73(x2)
    li TESTNUM, 73
    bne x11, x12, fail
# Check data at byte offset 78
    lb x11, 78(x1)
    lb x12, 78(x2)
    li TESTNUM, 78
    bne x11, x12, fail
# Check data at byte offset 79
    lb x11, 79(x1)
    lb x12, 79(x2)
    li TESTNUM, 79
    bne x11, x12, fail
# Check data at byte offset 84
    lb x11, 84(x1)
    lb x12, 84(x2)
    li TESTNUM, 84
    bne x11, x12, fail
# Check data at byte offset 85
    lb x11, 85(x1)
    lb x12, 85(x2)
    li TESTNUM, 85
    bne x11, x12, fail
# Check data at byte offset 90
    lb x11, 90(x1)
    lb x12, 90(x2)
    li TESTNUM, 90
    bne x11, x12, fail
# Check data at byte offset 91
    lb x11, 91(x1)
    lb x12, 91(x2)
    li TESTNUM, 91
    bne x11, x12, fail
# Check data at byte offset 96
    lb x11, 96(x1)
    lb x12, 96(x2)
    li TESTNUM, 96
    bne x11, x12, fail
# Check data at byte offset 97
    lb x11, 97(x1)
    lb x12, 97(x2)
    li TESTNUM, 97
    bne x11, x12, fail
# Check data at byte offset 102
    lb x11, 102(x1)
    lb x12, 102(x2)
    li TESTNUM, 102
    bne x11, x12, fail
# Check data at byte offset 103
    lb x11, 103(x1)
    lb x12, 103(x2)
    li TESTNUM, 103
    bne x11, x12, fail
# Check data at byte offset 108
    lb x11, 108(x1)
    lb x12, 108(x2)
    li TESTNUM, 108
    bne x11, x12, fail
# Check data at byte offset 109
    lb x11, 109(x1)
    lb x12, 109(x2)
    li TESTNUM, 109
    bne x11, x12, fail
# Check data at byte offset 114
    lb x11, 114(x1)
    lb x12, 114(x2)
    li TESTNUM, 114
    bne x11, x12, fail
# Check data at byte offset 115
    lb x11, 115(x1)
    lb x12, 115(x2)
    li TESTNUM, 115
    bne x11, x12, fail
# Check data at byte offset 120
    lb x11, 120(x1)
    lb x12, 120(x2)
    li TESTNUM, 120
    bne x11, x12, fail
# Check data at byte offset 121
    lb x11, 121(x1)
    lb x12, 121(x2)
    li TESTNUM, 121
    bne x11, x12, fail
# Check data at byte offset 126
    lb x11, 126(x1)
    lb x12, 126(x2)
    li TESTNUM, 126
    bne x11, x12, fail
# Check data at byte offset 127
    lb x11, 127(x1)
    lb x12, 127(x2)
    li TESTNUM, 127
    bne x11, x12, fail
# Check data at byte offset 132
    lb x11, 132(x1)
    lb x12, 132(x2)
    li TESTNUM, 132
    bne x11, x12, fail
# Check data at byte offset 133
    lb x11, 133(x1)
    lb x12, 133(x2)
    li TESTNUM, 133
    bne x11, x12, fail
# Check data at byte offset 138
    lb x11, 138(x1)
    lb x12, 138(x2)
    li TESTNUM, 138
    bne x11, x12, fail
# Check data at byte offset 139
    lb x11, 139(x1)
    lb x12, 139(x2)
    li TESTNUM, 139
    bne x11, x12, fail
# Check data at byte offset 144
    lb x11, 144(x1)
    lb x12, 144(x2)
    li TESTNUM, 144
    bne x11, x12, fail
# Check data at byte offset 145
    lb x11, 145(x1)
    lb x12, 145(x2)
    li TESTNUM, 145
    bne x11, x12, fail
# Check data at byte offset 150
    lb x11, 150(x1)
    lb x12, 150(x2)
    li TESTNUM, 150
    bne x11, x12, fail
# Check data at byte offset 151
    lb x11, 151(x1)
    lb x12, 151(x2)
    li TESTNUM, 151
    bne x11, x12, fail
# Check data at byte offset 156
    lb x11, 156(x1)
    lb x12, 156(x2)
    li TESTNUM, 156
    bne x11, x12, fail
# Check data at byte offset 157
    lb x11, 157(x1)
    lb x12, 157(x2)
    li TESTNUM, 157
    bne x11, x12, fail
# Check data at byte offset 162
    lb x11, 162(x1)
    lb x12, 162(x2)
    li TESTNUM, 162
    bne x11, x12, fail
# Check data at byte offset 163
    lb x11, 163(x1)
    lb x12, 163(x2)
    li TESTNUM, 163
    bne x11, x12, fail
# Check data at byte offset 168
    lb x11, 168(x1)
    lb x12, 168(x2)
    li TESTNUM, 168
    bne x11, x12, fail
# Check data at byte offset 169
    lb x11, 169(x1)
    lb x12, 169(x2)
    li TESTNUM, 169
    bne x11, x12, fail
# Check data at byte offset 174
    lb x11, 174(x1)
    lb x12, 174(x2)
    li TESTNUM, 174
    bne x11, x12, fail
# Check data at byte offset 175
    lb x11, 175(x1)
    lb x12, 175(x2)
    li TESTNUM, 175
    bne x11, x12, fail
# Check data at byte offset 180
    lb x11, 180(x1)
    lb x12, 180(x2)
    li TESTNUM, 180
    bne x11, x12, fail
# Check data at byte offset 181
    lb x11, 181(x1)
    lb x12, 181(x2)
    li TESTNUM, 181
    bne x11, x12, fail
# Check data at byte offset 186
    lb x11, 186(x1)
    lb x12, 186(x2)
    li TESTNUM, 186
    bne x11, x12, fail
# Check data at byte offset 187
    lb x11, 187(x1)
    lb x12, 187(x2)
    li TESTNUM, 187
    bne x11, x12, fail
# Check data at byte offset 192
    lb x11, 192(x1)
    lb x12, 192(x2)
    li TESTNUM, 192
    bne x11, x12, fail
# Check data at byte offset 193
    lb x11, 193(x1)
    lb x12, 193(x2)
    li TESTNUM, 193
    bne x11, x12, fail
# Check data at byte offset 198
    lb x11, 198(x1)
    lb x12, 198(x2)
    li TESTNUM, 198
    bne x11, x12, fail
# Check data at byte offset 199
    lb x11, 199(x1)
    lb x12, 199(x2)
    li TESTNUM, 199
    bne x11, x12, fail
# Check data at byte offset 204
    lb x11, 204(x1)
    lb x12, 204(x2)
    li TESTNUM, 204
    bne x11, x12, fail
# Check data at byte offset 205
    lb x11, 205(x1)
    lb x12, 205(x2)
    li TESTNUM, 205
    bne x11, x12, fail
# Check data at byte offset 210
    lb x11, 210(x1)
    lb x12, 210(x2)
    li TESTNUM, 210
    bne x11, x12, fail
# Check data at byte offset 211
    lb x11, 211(x1)
    lb x12, 211(x2)
    li TESTNUM, 211
    bne x11, x12, fail
# Check data at byte offset 216
    lb x11, 216(x1)
    lb x12, 216(x2)
    li TESTNUM, 216
    bne x11, x12, fail
# Check data at byte offset 217
    lb x11, 217(x1)
    lb x12, 217(x2)
    li TESTNUM, 217
    bne x11, x12, fail
# Check data at byte offset 222
    lb x11, 222(x1)
    lb x12, 222(x2)
    li TESTNUM, 222
    bne x11, x12, fail
# Check data at byte offset 223
    lb x11, 223(x1)
    lb x12, 223(x2)
    li TESTNUM, 223
    bne x11, x12, fail
# Check data at byte offset 228
    lb x11, 228(x1)
    lb x12, 228(x2)
    li TESTNUM, 228
    bne x11, x12, fail
# Check data at byte offset 229
    lb x11, 229(x1)
    lb x12, 229(x2)
    li TESTNUM, 229
    bne x11, x12, fail
# Check data at byte offset 234
    lb x11, 234(x1)
    lb x12, 234(x2)
    li TESTNUM, 234
    bne x11, x12, fail
# Check data at byte offset 235
    lb x11, 235(x1)
    lb x12, 235(x2)
    li TESTNUM, 235
    bne x11, x12, fail
# Check data at byte offset 240
    lb x11, 240(x1)
    lb x12, 240(x2)
    li TESTNUM, 240
    bne x11, x12, fail
# Check data at byte offset 241
    lb x11, 241(x1)
    lb x12, 241(x2)
    li TESTNUM, 241
    bne x11, x12, fail
# Check data at byte offset 246
    lb x11, 246(x1)
    lb x12, 246(x2)
    li TESTNUM, 246
    bne x11, x12, fail
# Check data at byte offset 247
    lb x11, 247(x1)
    lb x12, 247(x2)
    li TESTNUM, 247
    bne x11, x12, fail
# Check data at byte offset 252
    lb x11, 252(x1)
    lb x12, 252(x2)
    li TESTNUM, 252
    bne x11, x12, fail
# Check data at byte offset 253
    lb x11, 253(x1)
    lb x12, 253(x2)
    li TESTNUM, 253
    bne x11, x12, fail
# Check data at byte offset 258
    lb x11, 258(x1)
    lb x12, 258(x2)
    li TESTNUM, 258
    bne x11, x12, fail
# Check data at byte offset 259
    lb x11, 259(x1)
    lb x12, 259(x2)
    li TESTNUM, 259
    bne x11, x12, fail
# Check data at byte offset 264
    lb x11, 264(x1)
    lb x12, 264(x2)
    li TESTNUM, 264
    bne x11, x12, fail
# Check data at byte offset 265
    lb x11, 265(x1)
    lb x12, 265(x2)
    li TESTNUM, 265
    bne x11, x12, fail
# Check data at byte offset 270
    lb x11, 270(x1)
    lb x12, 270(x2)
    li TESTNUM, 270
    bne x11, x12, fail
# Check data at byte offset 271
    lb x11, 271(x1)
    lb x12, 271(x2)
    li TESTNUM, 271
    bne x11, x12, fail
# Check data at byte offset 276
    lb x11, 276(x1)
    lb x12, 276(x2)
    li TESTNUM, 276
    bne x11, x12, fail
# Check data at byte offset 277
    lb x11, 277(x1)
    lb x12, 277(x2)
    li TESTNUM, 277
    bne x11, x12, fail
# Check data at byte offset 282
    lb x11, 282(x1)
    lb x12, 282(x2)
    li TESTNUM, 282
    bne x11, x12, fail
# Check data at byte offset 283
    lb x11, 283(x1)
    lb x12, 283(x2)
    li TESTNUM, 283
    bne x11, x12, fail
# Check data at byte offset 288
    lb x11, 288(x1)
    lb x12, 288(x2)
    li TESTNUM, 288
    bne x11, x12, fail
# Check data at byte offset 289
    lb x11, 289(x1)
    lb x12, 289(x2)
    li TESTNUM, 289
    bne x11, x12, fail
# Check data at byte offset 294
    lb x11, 294(x1)
    lb x12, 294(x2)
    li TESTNUM, 294
    bne x11, x12, fail
# Check data at byte offset 295
    lb x11, 295(x1)
    lb x12, 295(x2)
    li TESTNUM, 295
    bne x11, x12, fail
# Check data at byte offset 300
    lb x11, 300(x1)
    lb x12, 300(x2)
    li TESTNUM, 300
    bne x11, x12, fail
# Check data at byte offset 301
    lb x11, 301(x1)
    lb x12, 301(x2)
    li TESTNUM, 301
    bne x11, x12, fail
# Check data at byte offset 306
    lb x11, 306(x1)
    lb x12, 306(x2)
    li TESTNUM, 306
    bne x11, x12, fail
# Check data at byte offset 307
    lb x11, 307(x1)
    lb x12, 307(x2)
    li TESTNUM, 307
    bne x11, x12, fail
# Check data at byte offset 312
    lb x11, 312(x1)
    lb x12, 312(x2)
    li TESTNUM, 312
    bne x11, x12, fail
# Check data at byte offset 313
    lb x11, 313(x1)
    lb x12, 313(x2)
    li TESTNUM, 313
    bne x11, x12, fail
# Check data at byte offset 318
    lb x11, 318(x1)
    lb x12, 318(x2)
    li TESTNUM, 318
    bne x11, x12, fail
# Check data at byte offset 319
    lb x11, 319(x1)
    lb x12, 319(x2)
    li TESTNUM, 319
    bne x11, x12, fail
# Check data at byte offset 324
    lb x11, 324(x1)
    lb x12, 324(x2)
    li TESTNUM, 324
    bne x11, x12, fail
# Check data at byte offset 325
    lb x11, 325(x1)
    lb x12, 325(x2)
    li TESTNUM, 325
    bne x11, x12, fail
# Check data at byte offset 330
    lb x11, 330(x1)
    lb x12, 330(x2)
    li TESTNUM, 330
    bne x11, x12, fail
# Check data at byte offset 331
    lb x11, 331(x1)
    lb x12, 331(x2)
    li TESTNUM, 331
    bne x11, x12, fail
# Check data at byte offset 336
    lb x11, 336(x1)
    lb x12, 336(x2)
    li TESTNUM, 336
    bne x11, x12, fail
# Check data at byte offset 337
    lb x11, 337(x1)
    lb x12, 337(x2)
    li TESTNUM, 337
    bne x11, x12, fail
# Check data at byte offset 342
    lb x11, 342(x1)
    lb x12, 342(x2)
    li TESTNUM, 342
    bne x11, x12, fail
# Check data at byte offset 343
    lb x11, 343(x1)
    lb x12, 343(x2)
    li TESTNUM, 343
    bne x11, x12, fail
# Check data at byte offset 348
    lb x11, 348(x1)
    lb x12, 348(x2)
    li TESTNUM, 348
    bne x11, x12, fail
# Check data at byte offset 349
    lb x11, 349(x1)
    lb x12, 349(x2)
    li TESTNUM, 349
    bne x11, x12, fail
# Check data at byte offset 354
    lb x11, 354(x1)
    lb x12, 354(x2)
    li TESTNUM, 354
    bne x11, x12, fail
# Check data at byte offset 355
    lb x11, 355(x1)
    lb x12, 355(x2)
    li TESTNUM, 355
    bne x11, x12, fail
# Check data at byte offset 360
    lb x11, 360(x1)
    lb x12, 360(x2)
    li TESTNUM, 360
    bne x11, x12, fail
# Check data at byte offset 361
    lb x11, 361(x1)
    lb x12, 361(x2)
    li TESTNUM, 361
    bne x11, x12, fail
# Check data at byte offset 366
    lb x11, 366(x1)
    lb x12, 366(x2)
    li TESTNUM, 366
    bne x11, x12, fail
# Check data at byte offset 367
    lb x11, 367(x1)
    lb x12, 367(x2)
    li TESTNUM, 367
    bne x11, x12, fail
# Check data at byte offset 372
    lb x11, 372(x1)
    lb x12, 372(x2)
    li TESTNUM, 372
    bne x11, x12, fail
# Check data at byte offset 373
    lb x11, 373(x1)
    lb x12, 373(x2)
    li TESTNUM, 373
    bne x11, x12, fail
# Check data at byte offset 378
    lb x11, 378(x1)
    lb x12, 378(x2)
    li TESTNUM, 378
    bne x11, x12, fail
# Check data at byte offset 379
    lb x11, 379(x1)
    lb x12, 379(x2)
    li TESTNUM, 379
    bne x11, x12, fail
# Check clean at byte offset 2
    li x11, 0x55
    lb x12, 2(x2)
    li TESTNUM, 2
    bne x11, x12, fail
# Check clean at byte offset 3
    li x11, 0x55
    lb x12, 3(x2)
    li TESTNUM, 3
    bne x11, x12, fail
# Check clean at byte offset 4
    li x11, 0x55
    lb x12, 4(x2)
    li TESTNUM, 4
    bne x11, x12, fail
# Check clean at byte offset 5
    li x11, 0x55
    lb x12, 5(x2)
    li TESTNUM, 5
    bne x11, x12, fail
# Check clean at byte offset 8
    li x11, 0x55
    lb x12, 8(x2)
    li TESTNUM, 8
    bne x11, x12, fail
# Check clean at byte offset 9
    li x11, 0x55
    lb x12, 9(x2)
    li TESTNUM, 9
    bne x11, x12, fail
# Check clean at byte offset 10
    li x11, 0x55
    lb x12, 10(x2)
    li TESTNUM, 10
    bne x11, x12, fail
# Check clean at byte offset 11
    li x11, 0x55
    lb x12, 11(x2)
    li TESTNUM, 11
    bne x11, x12, fail
# Check clean at byte offset 14
    li x11, 0x55
    lb x12, 14(x2)
    li TESTNUM, 14
    bne x11, x12, fail
# Check clean at byte offset 15
    li x11, 0x55
    lb x12, 15(x2)
    li TESTNUM, 15
    bne x11, x12, fail
# Check clean at byte offset 16
    li x11, 0x55
    lb x12, 16(x2)
    li TESTNUM, 16
    bne x11, x12, fail
# Check clean at byte offset 17
    li x11, 0x55
    lb x12, 17(x2)
    li TESTNUM, 17
    bne x11, x12, fail
# Check clean at byte offset 20
    li x11, 0x55
    lb x12, 20(x2)
    li TESTNUM, 20
    bne x11, x12, fail
# Check clean at byte offset 21
    li x11, 0x55
    lb x12, 21(x2)
    li TESTNUM, 21
    bne x11, x12, fail
# Check clean at byte offset 22
    li x11, 0x55
    lb x12, 22(x2)
    li TESTNUM, 22
    bne x11, x12, fail
# Check clean at byte offset 23
    li x11, 0x55
    lb x12, 23(x2)
    li TESTNUM, 23
    bne x11, x12, fail
# Check clean at byte offset 26
    li x11, 0x55
    lb x12, 26(x2)
    li TESTNUM, 26
    bne x11, x12, fail
# Check clean at byte offset 27
    li x11, 0x55
    lb x12, 27(x2)
    li TESTNUM, 27
    bne x11, x12, fail
# Check clean at byte offset 28
    li x11, 0x55
    lb x12, 28(x2)
    li TESTNUM, 28
    bne x11, x12, fail
# Check clean at byte offset 29
    li x11, 0x55
    lb x12, 29(x2)
    li TESTNUM, 29
    bne x11, x12, fail
# Check clean at byte offset 32
    li x11, 0x55
    lb x12, 32(x2)
    li TESTNUM, 32
    bne x11, x12, fail
# Check clean at byte offset 33
    li x11, 0x55
    lb x12, 33(x2)
    li TESTNUM, 33
    bne x11, x12, fail
# Check clean at byte offset 34
    li x11, 0x55
    lb x12, 34(x2)
    li TESTNUM, 34
    bne x11, x12, fail
# Check clean at byte offset 35
    li x11, 0x55
    lb x12, 35(x2)
    li TESTNUM, 35
    bne x11, x12, fail
# Check clean at byte offset 38
    li x11, 0x55
    lb x12, 38(x2)
    li TESTNUM, 38
    bne x11, x12, fail
# Check clean at byte offset 39
    li x11, 0x55
    lb x12, 39(x2)
    li TESTNUM, 39
    bne x11, x12, fail
# Check clean at byte offset 40
    li x11, 0x55
    lb x12, 40(x2)
    li TESTNUM, 40
    bne x11, x12, fail
# Check clean at byte offset 41
    li x11, 0x55
    lb x12, 41(x2)
    li TESTNUM, 41
    bne x11, x12, fail
# Check clean at byte offset 44
    li x11, 0x55
    lb x12, 44(x2)
    li TESTNUM, 44
    bne x11, x12, fail
# Check clean at byte offset 45
    li x11, 0x55
    lb x12, 45(x2)
    li TESTNUM, 45
    bne x11, x12, fail
# Check clean at byte offset 46
    li x11, 0x55
    lb x12, 46(x2)
    li TESTNUM, 46
    bne x11, x12, fail
# Check clean at byte offset 47
    li x11, 0x55
    lb x12, 47(x2)
    li TESTNUM, 47
    bne x11, x12, fail
# Check clean at byte offset 50
    li x11, 0x55
    lb x12, 50(x2)
    li TESTNUM, 50
    bne x11, x12, fail
# Check clean at byte offset 51
    li x11, 0x55
    lb x12, 51(x2)
    li TESTNUM, 51
    bne x11, x12, fail
# Check clean at byte offset 52
    li x11, 0x55
    lb x12, 52(x2)
    li TESTNUM, 52
    bne x11, x12, fail
# Check clean at byte offset 53
    li x11, 0x55
    lb x12, 53(x2)
    li TESTNUM, 53
    bne x11, x12, fail
# Check clean at byte offset 56
    li x11, 0x55
    lb x12, 56(x2)
    li TESTNUM, 56
    bne x11, x12, fail
# Check clean at byte offset 57
    li x11, 0x55
    lb x12, 57(x2)
    li TESTNUM, 57
    bne x11, x12, fail
# Check clean at byte offset 58
    li x11, 0x55
    lb x12, 58(x2)
    li TESTNUM, 58
    bne x11, x12, fail
# Check clean at byte offset 59
    li x11, 0x55
    lb x12, 59(x2)
    li TESTNUM, 59
    bne x11, x12, fail
# Check clean at byte offset 62
    li x11, 0x55
    lb x12, 62(x2)
    li TESTNUM, 62
    bne x11, x12, fail
# Check clean at byte offset 63
    li x11, 0x55
    lb x12, 63(x2)
    li TESTNUM, 63
    bne x11, x12, fail
# Check clean at byte offset 64
    li x11, 0x55
    lb x12, 64(x2)
    li TESTNUM, 64
    bne x11, x12, fail
# Check clean at byte offset 65
    li x11, 0x55
    lb x12, 65(x2)
    li TESTNUM, 65
    bne x11, x12, fail
# Check clean at byte offset 68
    li x11, 0x55
    lb x12, 68(x2)
    li TESTNUM, 68
    bne x11, x12, fail
# Check clean at byte offset 69
    li x11, 0x55
    lb x12, 69(x2)
    li TESTNUM, 69
    bne x11, x12, fail
# Check clean at byte offset 70
    li x11, 0x55
    lb x12, 70(x2)
    li TESTNUM, 70
    bne x11, x12, fail
# Check clean at byte offset 71
    li x11, 0x55
    lb x12, 71(x2)
    li TESTNUM, 71
    bne x11, x12, fail
# Check clean at byte offset 74
    li x11, 0x55
    lb x12, 74(x2)
    li TESTNUM, 74
    bne x11, x12, fail
# Check clean at byte offset 75
    li x11, 0x55
    lb x12, 75(x2)
    li TESTNUM, 75
    bne x11, x12, fail
# Check clean at byte offset 76
    li x11, 0x55
    lb x12, 76(x2)
    li TESTNUM, 76
    bne x11, x12, fail
# Check clean at byte offset 77
    li x11, 0x55
    lb x12, 77(x2)
    li TESTNUM, 77
    bne x11, x12, fail
# Check clean at byte offset 80
    li x11, 0x55
    lb x12, 80(x2)
    li TESTNUM, 80
    bne x11, x12, fail
# Check clean at byte offset 81
    li x11, 0x55
    lb x12, 81(x2)
    li TESTNUM, 81
    bne x11, x12, fail
# Check clean at byte offset 82
    li x11, 0x55
    lb x12, 82(x2)
    li TESTNUM, 82
    bne x11, x12, fail
# Check clean at byte offset 83
    li x11, 0x55
    lb x12, 83(x2)
    li TESTNUM, 83
    bne x11, x12, fail
# Check clean at byte offset 86
    li x11, 0x55
    lb x12, 86(x2)
    li TESTNUM, 86
    bne x11, x12, fail
# Check clean at byte offset 87
    li x11, 0x55
    lb x12, 87(x2)
    li TESTNUM, 87
    bne x11, x12, fail
# Check clean at byte offset 88
    li x11, 0x55
    lb x12, 88(x2)
    li TESTNUM, 88
    bne x11, x12, fail
# Check clean at byte offset 89
    li x11, 0x55
    lb x12, 89(x2)
    li TESTNUM, 89
    bne x11, x12, fail
# Check clean at byte offset 92
    li x11, 0x55
    lb x12, 92(x2)
    li TESTNUM, 92
    bne x11, x12, fail
# Check clean at byte offset 93
    li x11, 0x55
    lb x12, 93(x2)
    li TESTNUM, 93
    bne x11, x12, fail
# Check clean at byte offset 94
    li x11, 0x55
    lb x12, 94(x2)
    li TESTNUM, 94
    bne x11, x12, fail
# Check clean at byte offset 95
    li x11, 0x55
    lb x12, 95(x2)
    li TESTNUM, 95
    bne x11, x12, fail
# Check clean at byte offset 98
    li x11, 0x55
    lb x12, 98(x2)
    li TESTNUM, 98
    bne x11, x12, fail
# Check clean at byte offset 99
    li x11, 0x55
    lb x12, 99(x2)
    li TESTNUM, 99
    bne x11, x12, fail
# Check clean at byte offset 100
    li x11, 0x55
    lb x12, 100(x2)
    li TESTNUM, 100
    bne x11, x12, fail
# Check clean at byte offset 101
    li x11, 0x55
    lb x12, 101(x2)
    li TESTNUM, 101
    bne x11, x12, fail
# Check clean at byte offset 104
    li x11, 0x55
    lb x12, 104(x2)
    li TESTNUM, 104
    bne x11, x12, fail
# Check clean at byte offset 105
    li x11, 0x55
    lb x12, 105(x2)
    li TESTNUM, 105
    bne x11, x12, fail
# Check clean at byte offset 106
    li x11, 0x55
    lb x12, 106(x2)
    li TESTNUM, 106
    bne x11, x12, fail
# Check clean at byte offset 107
    li x11, 0x55
    lb x12, 107(x2)
    li TESTNUM, 107
    bne x11, x12, fail
# Check clean at byte offset 110
    li x11, 0x55
    lb x12, 110(x2)
    li TESTNUM, 110
    bne x11, x12, fail
# Check clean at byte offset 111
    li x11, 0x55
    lb x12, 111(x2)
    li TESTNUM, 111
    bne x11, x12, fail
# Check clean at byte offset 112
    li x11, 0x55
    lb x12, 112(x2)
    li TESTNUM, 112
    bne x11, x12, fail
# Check clean at byte offset 113
    li x11, 0x55
    lb x12, 113(x2)
    li TESTNUM, 113
    bne x11, x12, fail
# Check clean at byte offset 116
    li x11, 0x55
    lb x12, 116(x2)
    li TESTNUM, 116
    bne x11, x12, fail
# Check clean at byte offset 117
    li x11, 0x55
    lb x12, 117(x2)
    li TESTNUM, 117
    bne x11, x12, fail
# Check clean at byte offset 118
    li x11, 0x55
    lb x12, 118(x2)
    li TESTNUM, 118
    bne x11, x12, fail
# Check clean at byte offset 119
    li x11, 0x55
    lb x12, 119(x2)
    li TESTNUM, 119
    bne x11, x12, fail
# Check clean at byte offset 122
    li x11, 0x55
    lb x12, 122(x2)
    li TESTNUM, 122
    bne x11, x12, fail
# Check clean at byte offset 123
    li x11, 0x55
    lb x12, 123(x2)
    li TESTNUM, 123
    bne x11, x12, fail
# Check clean at byte offset 124
    li x11, 0x55
    lb x12, 124(x2)
    li TESTNUM, 124
    bne x11, x12, fail
# Check clean at byte offset 125
    li x11, 0x55
    lb x12, 125(x2)
    li TESTNUM, 125
    bne x11, x12, fail
# Check clean at byte offset 128
    li x11, 0x55
    lb x12, 128(x2)
    li TESTNUM, 128
    bne x11, x12, fail
# Check clean at byte offset 129
    li x11, 0x55
    lb x12, 129(x2)
    li TESTNUM, 129
    bne x11, x12, fail
# Check clean at byte offset 130
    li x11, 0x55
    lb x12, 130(x2)
    li TESTNUM, 130
    bne x11, x12, fail
# Check clean at byte offset 131
    li x11, 0x55
    lb x12, 131(x2)
    li TESTNUM, 131
    bne x11, x12, fail
# Check clean at byte offset 134
    li x11, 0x55
    lb x12, 134(x2)
    li TESTNUM, 134
    bne x11, x12, fail
# Check clean at byte offset 135
    li x11, 0x55
    lb x12, 135(x2)
    li TESTNUM, 135
    bne x11, x12, fail
# Check clean at byte offset 136
    li x11, 0x55
    lb x12, 136(x2)
    li TESTNUM, 136
    bne x11, x12, fail
# Check clean at byte offset 137
    li x11, 0x55
    lb x12, 137(x2)
    li TESTNUM, 137
    bne x11, x12, fail
# Check clean at byte offset 140
    li x11, 0x55
    lb x12, 140(x2)
    li TESTNUM, 140
    bne x11, x12, fail
# Check clean at byte offset 141
    li x11, 0x55
    lb x12, 141(x2)
    li TESTNUM, 141
    bne x11, x12, fail
# Check clean at byte offset 142
    li x11, 0x55
    lb x12, 142(x2)
    li TESTNUM, 142
    bne x11, x12, fail
# Check clean at byte offset 143
    li x11, 0x55
    lb x12, 143(x2)
    li TESTNUM, 143
    bne x11, x12, fail
# Check clean at byte offset 146
    li x11, 0x55
    lb x12, 146(x2)
    li TESTNUM, 146
    bne x11, x12, fail
# Check clean at byte offset 147
    li x11, 0x55
    lb x12, 147(x2)
    li TESTNUM, 147
    bne x11, x12, fail
# Check clean at byte offset 148
    li x11, 0x55
    lb x12, 148(x2)
    li TESTNUM, 148
    bne x11, x12, fail
# Check clean at byte offset 149
    li x11, 0x55
    lb x12, 149(x2)
    li TESTNUM, 149
    bne x11, x12, fail
# Check clean at byte offset 152
    li x11, 0x55
    lb x12, 152(x2)
    li TESTNUM, 152
    bne x11, x12, fail
# Check clean at byte offset 153
    li x11, 0x55
    lb x12, 153(x2)
    li TESTNUM, 153
    bne x11, x12, fail
# Check clean at byte offset 154
    li x11, 0x55
    lb x12, 154(x2)
    li TESTNUM, 154
    bne x11, x12, fail
# Check clean at byte offset 155
    li x11, 0x55
    lb x12, 155(x2)
    li TESTNUM, 155
    bne x11, x12, fail
# Check clean at byte offset 158
    li x11, 0x55
    lb x12, 158(x2)
    li TESTNUM, 158
    bne x11, x12, fail
# Check clean at byte offset 159
    li x11, 0x55
    lb x12, 159(x2)
    li TESTNUM, 159
    bne x11, x12, fail
# Check clean at byte offset 160
    li x11, 0x55
    lb x12, 160(x2)
    li TESTNUM, 160
    bne x11, x12, fail
# Check clean at byte offset 161
    li x11, 0x55
    lb x12, 161(x2)
    li TESTNUM, 161
    bne x11, x12, fail
# Check clean at byte offset 164
    li x11, 0x55
    lb x12, 164(x2)
    li TESTNUM, 164
    bne x11, x12, fail
# Check clean at byte offset 165
    li x11, 0x55
    lb x12, 165(x2)
    li TESTNUM, 165
    bne x11, x12, fail
# Check clean at byte offset 166
    li x11, 0x55
    lb x12, 166(x2)
    li TESTNUM, 166
    bne x11, x12, fail
# Check clean at byte offset 167
    li x11, 0x55
    lb x12, 167(x2)
    li TESTNUM, 167
    bne x11, x12, fail
# Check clean at byte offset 170
    li x11, 0x55
    lb x12, 170(x2)
    li TESTNUM, 170
    bne x11, x12, fail
# Check clean at byte offset 171
    li x11, 0x55
    lb x12, 171(x2)
    li TESTNUM, 171
    bne x11, x12, fail
# Check clean at byte offset 172
    li x11, 0x55
    lb x12, 172(x2)
    li TESTNUM, 172
    bne x11, x12, fail
# Check clean at byte offset 173
    li x11, 0x55
    lb x12, 173(x2)
    li TESTNUM, 173
    bne x11, x12, fail
# Check clean at byte offset 176
    li x11, 0x55
    lb x12, 176(x2)
    li TESTNUM, 176
    bne x11, x12, fail
# Check clean at byte offset 177
    li x11, 0x55
    lb x12, 177(x2)
    li TESTNUM, 177
    bne x11, x12, fail
# Check clean at byte offset 178
    li x11, 0x55
    lb x12, 178(x2)
    li TESTNUM, 178
    bne x11, x12, fail
# Check clean at byte offset 179
    li x11, 0x55
    lb x12, 179(x2)
    li TESTNUM, 179
    bne x11, x12, fail
# Check clean at byte offset 182
    li x11, 0x55
    lb x12, 182(x2)
    li TESTNUM, 182
    bne x11, x12, fail
# Check clean at byte offset 183
    li x11, 0x55
    lb x12, 183(x2)
    li TESTNUM, 183
    bne x11, x12, fail
# Check clean at byte offset 184
    li x11, 0x55
    lb x12, 184(x2)
    li TESTNUM, 184
    bne x11, x12, fail
# Check clean at byte offset 185
    li x11, 0x55
    lb x12, 185(x2)
    li TESTNUM, 185
    bne x11, x12, fail
# Check clean at byte offset 188
    li x11, 0x55
    lb x12, 188(x2)
    li TESTNUM, 188
    bne x11, x12, fail
# Check clean at byte offset 189
    li x11, 0x55
    lb x12, 189(x2)
    li TESTNUM, 189
    bne x11, x12, fail
# Check clean at byte offset 190
    li x11, 0x55
    lb x12, 190(x2)
    li TESTNUM, 190
    bne x11, x12, fail
# Check clean at byte offset 191
    li x11, 0x55
    lb x12, 191(x2)
    li TESTNUM, 191
    bne x11, x12, fail
# Check clean at byte offset 194
    li x11, 0x55
    lb x12, 194(x2)
    li TESTNUM, 194
    bne x11, x12, fail
# Check clean at byte offset 195
    li x11, 0x55
    lb x12, 195(x2)
    li TESTNUM, 195
    bne x11, x12, fail
# Check clean at byte offset 196
    li x11, 0x55
    lb x12, 196(x2)
    li TESTNUM, 196
    bne x11, x12, fail
# Check clean at byte offset 197
    li x11, 0x55
    lb x12, 197(x2)
    li TESTNUM, 197
    bne x11, x12, fail
# Check clean at byte offset 200
    li x11, 0x55
    lb x12, 200(x2)
    li TESTNUM, 200
    bne x11, x12, fail
# Check clean at byte offset 201
    li x11, 0x55
    lb x12, 201(x2)
    li TESTNUM, 201
    bne x11, x12, fail
# Check clean at byte offset 202
    li x11, 0x55
    lb x12, 202(x2)
    li TESTNUM, 202
    bne x11, x12, fail
# Check clean at byte offset 203
    li x11, 0x55
    lb x12, 203(x2)
    li TESTNUM, 203
    bne x11, x12, fail
# Check clean at byte offset 206
    li x11, 0x55
    lb x12, 206(x2)
    li TESTNUM, 206
    bne x11, x12, fail
# Check clean at byte offset 207
    li x11, 0x55
    lb x12, 207(x2)
    li TESTNUM, 207
    bne x11, x12, fail
# Check clean at byte offset 208
    li x11, 0x55
    lb x12, 208(x2)
    li TESTNUM, 208
    bne x11, x12, fail
# Check clean at byte offset 209
    li x11, 0x55
    lb x12, 209(x2)
    li TESTNUM, 209
    bne x11, x12, fail
# Check clean at byte offset 212
    li x11, 0x55
    lb x12, 212(x2)
    li TESTNUM, 212
    bne x11, x12, fail
# Check clean at byte offset 213
    li x11, 0x55
    lb x12, 213(x2)
    li TESTNUM, 213
    bne x11, x12, fail
# Check clean at byte offset 214
    li x11, 0x55
    lb x12, 214(x2)
    li TESTNUM, 214
    bne x11, x12, fail
# Check clean at byte offset 215
    li x11, 0x55
    lb x12, 215(x2)
    li TESTNUM, 215
    bne x11, x12, fail
# Check clean at byte offset 218
    li x11, 0x55
    lb x12, 218(x2)
    li TESTNUM, 218
    bne x11, x12, fail
# Check clean at byte offset 219
    li x11, 0x55
    lb x12, 219(x2)
    li TESTNUM, 219
    bne x11, x12, fail
# Check clean at byte offset 220
    li x11, 0x55
    lb x12, 220(x2)
    li TESTNUM, 220
    bne x11, x12, fail
# Check clean at byte offset 221
    li x11, 0x55
    lb x12, 221(x2)
    li TESTNUM, 221
    bne x11, x12, fail
# Check clean at byte offset 224
    li x11, 0x55
    lb x12, 224(x2)
    li TESTNUM, 224
    bne x11, x12, fail
# Check clean at byte offset 225
    li x11, 0x55
    lb x12, 225(x2)
    li TESTNUM, 225
    bne x11, x12, fail
# Check clean at byte offset 226
    li x11, 0x55
    lb x12, 226(x2)
    li TESTNUM, 226
    bne x11, x12, fail
# Check clean at byte offset 227
    li x11, 0x55
    lb x12, 227(x2)
    li TESTNUM, 227
    bne x11, x12, fail
# Check clean at byte offset 230
    li x11, 0x55
    lb x12, 230(x2)
    li TESTNUM, 230
    bne x11, x12, fail
# Check clean at byte offset 231
    li x11, 0x55
    lb x12, 231(x2)
    li TESTNUM, 231
    bne x11, x12, fail
# Check clean at byte offset 232
    li x11, 0x55
    lb x12, 232(x2)
    li TESTNUM, 232
    bne x11, x12, fail
# Check clean at byte offset 233
    li x11, 0x55
    lb x12, 233(x2)
    li TESTNUM, 233
    bne x11, x12, fail
# Check clean at byte offset 236
    li x11, 0x55
    lb x12, 236(x2)
    li TESTNUM, 236
    bne x11, x12, fail
# Check clean at byte offset 237
    li x11, 0x55
    lb x12, 237(x2)
    li TESTNUM, 237
    bne x11, x12, fail
# Check clean at byte offset 238
    li x11, 0x55
    lb x12, 238(x2)
    li TESTNUM, 238
    bne x11, x12, fail
# Check clean at byte offset 239
    li x11, 0x55
    lb x12, 239(x2)
    li TESTNUM, 239
    bne x11, x12, fail
# Check clean at byte offset 242
    li x11, 0x55
    lb x12, 242(x2)
    li TESTNUM, 242
    bne x11, x12, fail
# Check clean at byte offset 243
    li x11, 0x55
    lb x12, 243(x2)
    li TESTNUM, 243
    bne x11, x12, fail
# Check clean at byte offset 244
    li x11, 0x55
    lb x12, 244(x2)
    li TESTNUM, 244
    bne x11, x12, fail
# Check clean at byte offset 245
    li x11, 0x55
    lb x12, 245(x2)
    li TESTNUM, 245
    bne x11, x12, fail
# Check clean at byte offset 248
    li x11, 0x55
    lb x12, 248(x2)
    li TESTNUM, 248
    bne x11, x12, fail
# Check clean at byte offset 249
    li x11, 0x55
    lb x12, 249(x2)
    li TESTNUM, 249
    bne x11, x12, fail
# Check clean at byte offset 250
    li x11, 0x55
    lb x12, 250(x2)
    li TESTNUM, 250
    bne x11, x12, fail
# Check clean at byte offset 251
    li x11, 0x55
    lb x12, 251(x2)
    li TESTNUM, 251
    bne x11, x12, fail
# Check clean at byte offset 254
    li x11, 0x55
    lb x12, 254(x2)
    li TESTNUM, 254
    bne x11, x12, fail
# Check clean at byte offset 255
    li x11, 0x55
    lb x12, 255(x2)
    li TESTNUM, 255
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
