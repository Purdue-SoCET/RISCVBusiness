# Compiled on godbolt.org with rv32gc clang 18.1.0
# -march=rv32imac_zve32x_zicsr -mabi=ilp32 -mcmodel=medany -static -O2 -Tlink.ld -std=c11 -nostartfiles

matmul:
        beqz    a2, .LBB0_14
        addi    sp, sp, -32
        sw      s0, 28(sp)
        sw      s1, 24(sp)
        sw      s2, 20(sp)
        sw      s3, 16(sp)
        sw      s4, 12(sp)
        sw      s5, 8(sp)
        li      a6, 0
        divu    t0, a2, a1
        mul     a7, t0, a0
        add     t0, t0, a7
        andi    s2, a2, -4
        slli    t1, a2, 4
        slli    t2, a2, 3
        slli    s4, a2, 2
        li      t3, 4
        vsetivli        zero, 2, e32, m2, ta, ma
        vmv.v.i v8, 0
        j       .LBB0_3
.LBB0_2:
        addi    a6, a6, 1
        addi    a4, a4, 4
        beq     a6, a2, .LBB0_13
.LBB0_3:
        bgeu    a7, t0, .LBB0_2
        slli    t4, a6, 2
        add     t4, t4, a5
        mv      t5, a7
        j       .LBB0_6
.LBB0_5:
        add     t6, t6, t4
        addi    t5, t5, 1
        sw      s1, 0(t6)
        bgeu    t5, t0, .LBB0_2
.LBB0_6:
        mul     t6, t5, a2
        slli    t6, t6, 2
        add     s3, a3, t6
        bgeu    a2, t3, .LBB0_8
        li      s1, 0
        li      a0, 0
        j       .LBB0_11
.LBB0_8:
        li      a0, 0
        mv      s1, a4
        vmv2r.v v10, v8
        vmv2r.v v12, v8
.LBB0_9:
        slli    a1, a0, 2
        add     a1, a1, s3
        addi    s0, a1, 8
        vle32.v v14, (a1)
        vle32.v v16, (s0)
        add     a1, s1, t2
        vlse32.v        v18, (s1), s4
        vlse32.v        v20, (a1), s4
        vmacc.vv        v10, v18, v14
        vmacc.vv        v12, v20, v16
        addi    a0, a0, 4
        add     s1, s1, t1
        bne     a0, s2, .LBB0_9
        vadd.vv v10, v12, v10
        vmv.s.x v12, zero
        vredsum.vs      v10, v10, v12
        vmv.x.s s1, v10
        mv      a0, s2
        beq     s2, a2, .LBB0_5
.LBB0_11:
        mul     a1, s4, a0
        add     a1, a1, a4
.LBB0_12:
        slli    s0, a0, 2
        add     s0, s0, s3
        lw      s5, 0(s0)
        lw      s0, 0(a1)
        mul     s0, s0, s5
        add     s1, s1, s0
        addi    a0, a0, 1
        add     a1, a1, s4
        bne     a0, a2, .LBB0_12
        j       .LBB0_5
.LBB0_13:
        lw      s0, 28(sp)
        lw      s1, 24(sp)
        lw      s2, 20(sp)
        lw      s3, 16(sp)
        lw      s4, 12(sp)
        lw      s5, 8(sp)
        addi    sp, sp, 32
.LBB0_14:
        ret

hart0_main:
        addi    sp, sp, -64
        sw      ra, 60(sp)
        sw      s0, 56(sp)
        sw      s1, 52(sp)
        sw      s2, 48(sp)
        sw      s3, 44(sp)
        sw      s4, 40(sp)
        sw      s5, 36(sp)
        sw      s6, 32(sp)
        sw      s7, 28(sp)
        sw      s8, 24(sp)
        sw      s9, 20(sp)
        sw      s10, 16(sp)
        sw      s11, 12(sp)
        li      a1, 0
.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(results)
        addi    t6, a0, %pcrel_lo(.Lpcrel_hi0)
.Lpcrel_hi1:
        auipc   a0, %pcrel_hi(input2_data)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi1)
        sw      a0, 0(sp)
        vsetivli        zero, 2, e32, m2, ta, ma
        vid.v   v8
.Lpcrel_hi2:
        auipc   a0, %pcrel_hi(input1_data)
        addi    s2, a0, %pcrel_lo(.Lpcrel_hi2)
        li      s11, 64
        li      s5, 40
        li      s6, 44
        li      s8, 48
        li      s9, 52
        li      s10, 56
        li      s7, 60
.LBB1_1:
        sw      a1, 8(sp)
        slli    a0, a1, 2
        lw      a1, 0(sp)
        add     a0, a0, a1
        lw      a1, 960(a0)
        lw      s0, 896(a0)
        lw      s1, 832(a0)
        lw      a5, 768(a0)
        lw      s4, 704(a0)
        lw      a2, 640(a0)
        lw      a4, 576(a0)
        lw      a3, 512(a0)
        lw      a6, 448(a0)
        lw      a7, 384(a0)
        lw      t0, 320(a0)
        lw      t1, 256(a0)
        lw      t2, 192(a0)
        lw      t3, 128(a0)
        lw      t4, 64(a0)
        lw      t5, 0(a0)
        sw      t6, 4(sp)
        mv      ra, s2
        li      s3, 16
        vmv2r.v v10, v8
.LBB1_2:
        vsll.vi v12, v10, 6
        vadd.vx v12, v12, s2
        li      a0, 4
        vluxei32.v      v14, (a0), v12
        vlse32.v        v16, (ra), s11
        li      a0, 8
        vluxei32.v      v18, (a0), v12
        li      a0, 12
        vluxei32.v      v20, (a0), v12
        vmul.vx v14, v14, t4
        vmacc.vx        v14, t5, v16
        vmadd.vx        v18, t3, v14
        vmadd.vx        v20, t2, v18
        li      a0, 16
        vluxei32.v      v14, (a0), v12
        li      a0, 20
        vluxei32.v      v16, (a0), v12
        li      a0, 24
        vluxei32.v      v18, (a0), v12
        li      a0, 28
        vluxei32.v      v22, (a0), v12
        vmadd.vx        v14, t1, v20
        vmadd.vx        v16, t0, v14
        vmadd.vx        v18, a7, v16
        vmadd.vx        v22, a6, v18
        li      a0, 32
        vluxei32.v      v14, (a0), v12
        li      a0, 36
        vluxei32.v      v16, (a0), v12
        vluxei32.v      v18, (s5), v12
        vluxei32.v      v20, (s6), v12
        vmadd.vx        v14, a3, v22
        vmadd.vx        v16, a4, v14
        vmadd.vx        v18, a2, v16
        vmadd.vx        v20, s4, v18
        vluxei32.v      v14, (s8), v12
        vluxei32.v      v16, (s9), v12
        vluxei32.v      v18, (s10), v12
        vluxei32.v      v12, (s7), v12
        vmadd.vx        v14, a5, v20
        vmadd.vx        v16, s1, v14
        vmadd.vx        v18, s0, v16
        vmadd.vx        v12, a1, v18
        vsse32.v        v12, (t6), s11
        vadd.vi v10, v10, 2
        addi    s3, s3, -2
        addi    ra, ra, 128
        addi    t6, t6, 128
        bnez    s3, .LBB1_2
        lw      a1, 8(sp)
        addi    a1, a1, 1
        lw      t6, 4(sp)
        addi    t6, t6, 4
        li      a0, 16
        bne     a1, a0, .LBB1_1
        call    wait_for_hart1_done
.Lpcrel_hi3:
        auipc   a0, %pcrel_hi(flag)
        li      a1, 1
        sw      a1, %pcrel_lo(.Lpcrel_hi3)(a0)
        li      a1, 256
.Lpcrel_hi4:
        auipc   a2, %pcrel_hi(verify_data)
        addi    a2, a2, %pcrel_lo(.Lpcrel_hi4)
.Lpcrel_hi5:
        auipc   a3, %pcrel_hi(results)
        addi    a3, a3, %pcrel_lo(.Lpcrel_hi5)
.LBB1_5:
        lw      a4, 0(a3)
        lw      a5, 0(a2)
        bne     a4, a5, .LBB1_7
        addi    a1, a1, -1
        addi    a2, a2, 4
        addi    a3, a3, 4
        bnez    a1, .LBB1_5
        j       .LBB1_8
.LBB1_7:
        sw      zero, %pcrel_lo(.Lpcrel_hi3)(a0)
.LBB1_8:
        lw      ra, 60(sp)
        lw      s0, 56(sp)
        lw      s1, 52(sp)
        lw      s2, 48(sp)
        lw      s3, 44(sp)
        lw      s4, 40(sp)
        lw      s5, 36(sp)
        lw      s6, 32(sp)
        lw      s7, 28(sp)
        lw      s8, 24(sp)
        lw      s9, 20(sp)
        lw      s10, 16(sp)
        lw      s11, 12(sp)
        addi    sp, sp, 64
        ret

hart1_main:
.Lpcrel_hi6:
        auipc   a0, %pcrel_hi(hart1_done)
        li      a1, 1
        sw      a1, %pcrel_lo(.Lpcrel_hi6)(a0)
        ret

wait_for_hart1_done:
.Lpcrel_hi7:
        auipc   a0, %pcrel_hi(hart1_done)
        lw      a1, %pcrel_lo(.Lpcrel_hi7)(a0)
        bnez    a1, .LBB3_2
.LBB3_1:
        lw      a1, %pcrel_lo(.Lpcrel_hi7)(a0)
        beqz    a1, .LBB3_1
.LBB3_2:
        ret

input1_data:
        .word   0
        .word   3
        .word   2
        .word   0
        .word   3
        .word   1
        .word   0
        .word   3
        .word   2
        .word   3
        .word   2
        .word   0
        .word   3
        .word   3
        .word   1
        .word   2
        .word   3
        .word   0
        .word   0
        .word   1
        .word   1
        .word   1
        .word   2
        .word   3
        .word   1
        .word   2
        .word   3
        .word   1
        .word   1
        .word   3
        .word   2
        .word   2
        .word   0
        .word   1
        .word   3
        .word   2
        .word   2
        .word   2
        .word   0
        .word   0
        .word   1
        .word   0
        .word   1
        .word   3
        .word   3
        .word   0
        .word   3
        .word   3
        .word   3
        .word   3
        .word   0
        .word   3
        .word   2
        .word   1
        .word   2
        .word   2
        .word   0
        .word   0
        .word   3
        .word   0
        .word   1
        .word   1
        .word   0
        .word   3
        .word   3
        .word   1
        .word   2
        .word   3
        .word   3
        .word   0
        .word   1
        .word   2
        .word   1
        .word   0
        .word   1
        .word   2
        .word   2
        .word   1
        .word   0
        .word   3
        .word   1
        .word   0
        .word   2
        .word   2
        .word   1
        .word   1
        .word   1
        .word   1
        .word   1
        .word   1
        .word   2
        .word   0
        .word   3
        .word   1
        .word   1
        .word   2
        .word   2
        .word   3
        .word   3
        .word   1
        .word   3
        .word   2
        .word   0
        .word   0
        .word   0
        .word   3
        .word   3
        .word   3
        .word   2
        .word   1
        .word   2
        .word   3
        .word   1
        .word   0
        .word   0
        .word   0
        .word   0
        .word   1
        .word   2
        .word   2
        .word   1
        .word   1
        .word   3
        .word   3
        .word   3
        .word   1
        .word   1
        .word   2
        .word   3
        .word   1
        .word   3
        .word   3
        .word   2
        .word   3
        .word   2
        .word   1
        .word   2
        .word   3
        .word   0
        .word   2
        .word   2
        .word   1
        .word   1
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   1
        .word   3
        .word   3
        .word   1
        .word   1
        .word   1
        .word   2
        .word   2
        .word   3
        .word   2
        .word   1
        .word   1
        .word   1
        .word   1
        .word   3
        .word   0
        .word   2
        .word   2
        .word   1
        .word   3
        .word   2
        .word   1
        .word   2
        .word   2
        .word   1
        .word   3
        .word   1
        .word   3
        .word   1
        .word   3
        .word   2
        .word   3
        .word   1
        .word   2
        .word   1
        .word   3
        .word   2
        .word   2
        .word   0
        .word   1
        .word   0
        .word   0
        .word   1
        .word   2
        .word   3
        .word   3
        .word   1
        .word   0
        .word   0
        .word   0
        .word   3
        .word   1
        .word   2
        .word   3
        .word   2
        .word   3
        .word   2
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   3
        .word   1
        .word   3
        .word   0
        .word   0
        .word   0
        .word   3
        .word   1
        .word   1
        .word   1
        .word   1
        .word   2
        .word   1
        .word   2
        .word   3
        .word   2
        .word   0
        .word   0
        .word   2
        .word   2
        .word   3
        .word   0
        .word   3
        .word   0
        .word   0
        .word   3
        .word   0
        .word   3
        .word   1
        .word   3
        .word   3
        .word   1
        .word   1
        .word   1
        .word   2
        .word   2
        .word   1
        .word   3
        .word   0
        .word   3
        .word   3
        .word   1
        .word   0
        .word   0
        .word   3
        .word   2

input2_data:
        .word   1
        .word   1
        .word   0
        .word   3
        .word   1
        .word   2
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   2
        .word   1
        .word   2
        .word   3
        .word   0
        .word   0
        .word   3
        .word   3
        .word   2
        .word   2
        .word   1
        .word   2
        .word   3
        .word   3
        .word   0
        .word   2
        .word   2
        .word   1
        .word   1
        .word   2
        .word   2
        .word   0
        .word   2
        .word   2
        .word   1
        .word   2
        .word   3
        .word   2
        .word   2
        .word   3
        .word   3
        .word   2
        .word   2
        .word   1
        .word   1
        .word   1
        .word   1
        .word   2
        .word   1
        .word   2
        .word   2
        .word   3
        .word   3
        .word   3
        .word   0
        .word   0
        .word   3
        .word   2
        .word   3
        .word   2
        .word   3
        .word   1
        .word   2
        .word   1
        .word   1
        .word   2
        .word   2
        .word   0
        .word   1
        .word   0
        .word   3
        .word   2
        .word   1
        .word   1
        .word   1
        .word   2
        .word   0
        .word   1
        .word   2
        .word   2
        .word   0
        .word   2
        .word   1
        .word   3
        .word   3
        .word   2
        .word   3
        .word   2
        .word   0
        .word   3
        .word   1
        .word   3
        .word   3
        .word   2
        .word   0
        .word   1
        .word   0
        .word   1
        .word   1
        .word   2
        .word   2
        .word   1
        .word   1
        .word   2
        .word   2
        .word   1
        .word   2
        .word   3
        .word   3
        .word   1
        .word   3
        .word   2
        .word   2
        .word   2
        .word   3
        .word   3
        .word   1
        .word   0
        .word   2
        .word   1
        .word   0
        .word   0
        .word   0
        .word   1
        .word   1
        .word   2
        .word   0
        .word   3
        .word   2
        .word   3
        .word   3
        .word   0
        .word   2
        .word   3
        .word   1
        .word   0
        .word   0
        .word   2
        .word   1
        .word   2
        .word   0
        .word   2
        .word   1
        .word   1
        .word   2
        .word   3
        .word   1
        .word   3
        .word   2
        .word   1
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   2
        .word   2
        .word   0
        .word   2
        .word   1
        .word   2
        .word   0
        .word   3
        .word   2
        .word   2
        .word   0
        .word   0
        .word   3
        .word   2
        .word   1
        .word   1
        .word   3
        .word   0
        .word   2
        .word   0
        .word   0
        .word   1
        .word   0
        .word   2
        .word   3
        .word   3
        .word   1
        .word   3
        .word   3
        .word   0
        .word   0
        .word   2
        .word   2
        .word   0
        .word   0
        .word   0
        .word   1
        .word   0
        .word   0
        .word   1
        .word   3
        .word   0
        .word   2
        .word   1
        .word   3
        .word   2
        .word   2
        .word   1
        .word   3
        .word   2
        .word   0
        .word   1
        .word   2
        .word   2
        .word   3
        .word   2
        .word   1
        .word   1
        .word   1
        .word   1
        .word   3
        .word   0
        .word   1
        .word   3
        .word   2
        .word   2
        .word   3
        .word   1
        .word   1
        .word   2
        .word   0
        .word   2
        .word   1
        .word   1
        .word   2
        .word   3
        .word   1
        .word   0
        .word   1
        .word   0
        .word   1
        .word   1
        .word   0
        .word   0
        .word   2
        .word   0
        .word   3
        .word   0
        .word   3
        .word   0
        .word   3
        .word   2
        .word   2
        .word   3
        .word   3
        .word   2
        .word   1
        .word   0
        .word   2
        .word   2

results:
        .zero   1024

flag:
        .word   0

verify_data:
        .word   36
        .word   44
        .word   57
        .word   50
        .word   54
        .word   36
        .word   38
        .word   46
        .word   55
        .word   25
        .word   38
        .word   34
        .word   51
        .word   30
        .word   40
        .word   32
        .word   37
        .word   34
        .word   38
        .word   52
        .word   51
        .word   40
        .word   28
        .word   32
        .word   41
        .word   22
        .word   26
        .word   35
        .word   49
        .word   35
        .word   42
        .word   23
        .word   26
        .word   26
        .word   33
        .word   36
        .word   52
        .word   40
        .word   45
        .word   49
        .word   50
        .word   34
        .word   41
        .word   35
        .word   44
        .word   25
        .word   23
        .word   23
        .word   31
        .word   29
        .word   39
        .word   46
        .word   50
        .word   36
        .word   31
        .word   32
        .word   42
        .word   32
        .word   34
        .word   41
        .word   44
        .word   33
        .word   43
        .word   30
        .word   31
        .word   28
        .word   39
        .word   46
        .word   50
        .word   40
        .word   35
        .word   37
        .word   43
        .word   35
        .word   33
        .word   43
        .word   43
        .word   29
        .word   37
        .word   29
        .word   27
        .word   22
        .word   30
        .word   33
        .word   43
        .word   31
        .word   32
        .word   25
        .word   36
        .word   31
        .word   31
        .word   29
        .word   40
        .word   28
        .word   26
        .word   22
        .word   29
        .word   42
        .word   48
        .word   51
        .word   65
        .word   52
        .word   43
        .word   54
        .word   63
        .word   34
        .word   42
        .word   44
        .word   56
        .word   33
        .word   38
        .word   32
        .word   26
        .word   22
        .word   23
        .word   38
        .word   49
        .word   32
        .word   26
        .word   30
        .word   43
        .word   22
        .word   24
        .word   27
        .word   45
        .word   24
        .word   26
        .word   17
        .word   35
        .word   35
        .word   47
        .word   51
        .word   59
        .word   59
        .word   43
        .word   42
        .word   43
        .word   28
        .word   37
        .word   43
        .word   56
        .word   48
        .word   36
        .word   32
        .word   28
        .word   19
        .word   28
        .word   34
        .word   46
        .word   34
        .word   28
        .word   34
        .word   45
        .word   20
        .word   29
        .word   28
        .word   50
        .word   32
        .word   26
        .word   21
        .word   37
        .word   38
        .word   51
        .word   50
        .word   55
        .word   45
        .word   38
        .word   49
        .word   56
        .word   28
        .word   38
        .word   40
        .word   50
        .word   29
        .word   44
        .word   26
        .word   32
        .word   35
        .word   50
        .word   43
        .word   53
        .word   44
        .word   41
        .word   41
        .word   34
        .word   24
        .word   35
        .word   34
        .word   39
        .word   33
        .word   34
        .word   29
        .word   21
        .word   33
        .word   31
        .word   45
        .word   48
        .word   42
        .word   27
        .word   29
        .word   40
        .word   17
        .word   21
        .word   32
        .word   45
        .word   30
        .word   29
        .word   26
        .word   26
        .word   27
        .word   38
        .word   33
        .word   29
        .word   31
        .word   32
        .word   31
        .word   35
        .word   25
        .word   29
        .word   29
        .word   34
        .word   15
        .word   25
        .word   23
        .word   34
        .word   28
        .word   44
        .word   45
        .word   41
        .word   41
        .word   37
        .word   45
        .word   45
        .word   17
        .word   34
        .word   44
        .word   46
        .word   30
        .word   43
        .word   29
        .word   31
        .word   36
        .word   37
        .word   50
        .word   54
        .word   44
        .word   28
        .word   40
        .word   38
        .word   22
        .word   27
        .word   28
        .word   45
        .word   32
        .word   36
        .word   22

hart1_done:
        .word   0