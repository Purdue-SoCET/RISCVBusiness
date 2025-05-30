#include <stdint.h>

#define ILLEGAL_INSN 0x2
#define AMO_OPCODE 0x2F
#define AMO_ADD_FUNCT5 0x0
#define AMO_SWAP_FUNCT5 0x1
#define AMO_XOR_FUNCT5 0x4
#define AMO_OR_FUNCT5 0x8
#define AMO_AND_FUNCT5 0xC
#define AMO_MIN_FUNCT5 0x10
#define AMO_MAX_FUNCT5 0x14
#define AMO_MINU_FUNCT5 0x18
#define AMO_MAXU_FUNCT5 0x1C

// clang-format off
#define AMO_EMU_OP(op) \
void amo_emu_##op(uint32_t *dest, uint32_t src, uint32_t addr) {                                   \
    uint32_t d;                                                                                    \
    __asm__ volatile("1:\n"                                                                            \
                 "lr.w %[d], (%[addr])\n"                                                          \
                 #op " t0, %[d], %[src]\n"                                                         \
                 "sc.w t0, t0, (%[addr])\n"                                                        \
                 "bnez t0, 1b\n"                                                                   \
                 : [d] "=&r"(d)                                                                    \
                 : [addr] "r"(addr), [src] "r"(src)                                                \
                 : "memory", "t0");                                                                \
    *dest = d;                                                                                     \
}
// clang-format on

AMO_EMU_OP(add)
AMO_EMU_OP(xor)
AMO_EMU_OP(or)
AMO_EMU_OP(and)

void amo_emu_min(uint32_t *dest, uint32_t src, uint32_t addr) {
    uint32_t d;
    __asm__ volatile("1:\n"
                     "lr.w %[d], (%[addr])\n"
                     "mv t0, %[src]\n"
                     "blt t0, %[d], 2f\n"
                     "mv t0, %[d]\n"
                     "2:\n"
                     "sc.w t0, t0, (%[addr])\n"
                     "bnez t0, 1b\n"
                     : [d] "=&r"(d)
                     : [addr] "r"(addr), [src] "r"(src)
                     : "memory", "t0");
    *dest = d;
}

void amo_emu_minu(uint32_t *dest, uint32_t src, uint32_t addr) {
    uint32_t d;
    __asm__ volatile("1:\n"
                     "lr.w %[d], (%[addr])\n"
                     "mv t0, %[src]\n"
                     "bltu t0, %[d], 2f\n"
                     "mv t0, %[d]\n"
                     "2:\n"
                     "sc.w t0, t0, (%[addr])\n"
                     "bnez t0, 1b\n"
                     : [d] "=&r"(d)
                     : [addr] "r"(addr), [src] "r"(src)
                     : "memory", "t0");
    *dest = d;
}

void amo_emu_max(uint32_t *dest, uint32_t src, uint32_t addr) {
    uint32_t d;
    __asm__ volatile("1:\n"
                     "lr.w %[d], (%[addr])\n"
                     "mv t0, %[src]\n"
                     "bge t0, %[d], 2f\n"
                     "mv t0, %[d]\n"
                     "2:\n"
                     "sc.w t0, t0, (%[addr])\n"
                     "bnez t0, 1b\n"
                     : [d] "=&r"(d)
                     : [addr] "r"(addr), [src] "r"(src)
                     : "memory", "t0");
    *dest = d;
}

void amo_emu_maxu(uint32_t *dest, uint32_t src, uint32_t addr) {
    uint32_t d;
    __asm__ volatile("1:\n"
                     "lr.w %[d], (%[addr])\n"
                     "mv t0, %[src]\n"
                     "bgeu t0, %[d], 2f\n"
                     "mv t0, %[d]\n"
                     "2:\n"
                     "sc.w t0, t0, (%[addr])\n"
                     "bnez t0, 1b\n"
                     : [d] "=&r"(d)
                     : [addr] "r"(addr), [src] "r"(src)
                     : "memory", "t0");
    *dest = d;
}

void amo_emu_swap(uint32_t *dest, uint32_t src, uint32_t addr) {
    uint32_t d;
    __asm__ volatile("1:\n"
                     "mv t0, %[src]\n"
                     "lr.w %[d], (%[addr])\n"
                     "sc.w t0, t0, (%[addr])\n"
                     "bnez t0, 1b\n"
                     : [d] "=&r"(d)
                     : [addr] "r"(addr), [src] "r"(src)
                     : "memory", "t0");
    *dest = d;
}

static uint32_t get_mcause() {
    uint32_t ret;
    __asm__ volatile("csrr %0, mcause" : "=r"(ret) : :);
    return ret;
}

static uint32_t get_mepc() {
    uint32_t ret;
    __asm__ volatile("csrr %0, mepc" : "=r"(ret) : :);
    return ret;
}

__attribute__((noreturn, aligned(4))) void exception_handler() {
    __asm__ volatile("addi sp, sp, -128\n"
                     "sw x31, 124(sp)\n"
                     "sw x30, 120(sp)\n"
                     "sw x29, 116(sp)\n"
                     "sw x28, 112(sp)\n"
                     "sw x27, 108(sp)\n"
                     "sw x26, 104(sp)\n"
                     "sw x25, 100(sp)\n"
                     "sw x24, 96(sp)\n"
                     "sw x23, 92(sp)\n"
                     "sw x22, 88(sp)\n"
                     "sw x21, 84(sp)\n"
                     "sw x20, 80(sp)\n"
                     "sw x19, 76(sp)\n"
                     "sw x18, 72(sp)\n"
                     "sw x17, 68(sp)\n"
                     "sw x16, 64(sp)\n"
                     "sw x15, 60(sp)\n"
                     "sw x14, 56(sp)\n"
                     "sw x13, 52(sp)\n"
                     "sw x12, 48(sp)\n"
                     "sw x11, 44(sp)\n"
                     "sw x10, 40(sp)\n"
                     "sw x9, 36(sp)\n"
                     "sw x8, 32(sp)\n"
                     "sw x7, 28(sp)\n"
                     "sw x6, 24(sp)\n"
                     "sw x5, 20(sp)\n"
                     "sw x4, 16(sp)\n"
                     "sw x3, 12(sp)\n"
                     "sw x1, 4(sp)\n");
    uint32_t *regs;
    __asm__ volatile("mv %0, sp" : "=r"(regs)::);
    uint32_t cause = get_mcause();
    uint32_t epc = get_mepc();
    if (cause == ILLEGAL_INSN) {
        uint32_t instr, opcode, rd, rs1, rs2, funct3, funct7;
        // Good case: instruction 32 bit aligned
        if (!__builtin_expect(epc & 0x3, 0x00)) {
            instr = *(uint32_t *)epc;
        } else {
            // Bad case: instruction on 16 bit boundary
            uint16_t first = *(uint16_t *)epc;
            uint16_t second = *((uint16_t *)epc + 1);
            instr = second << 16 | first;
        }
        opcode = instr & 0x0000007F;
        rd = (instr & 0x00000F80) >> 7;
        rs1 = regs[(instr & 0x000F8000) >> 15];
        rs2 = regs[(instr & 0x01F00000) >> 20];
        funct3 = (instr & 0x00007000) >> 12;
        funct7 = (instr & 0xFE000000) >> 25;

        if (opcode == AMO_OPCODE && funct3 == 0x2) {
            switch (funct7 >> 2) {
            case AMO_ADD_FUNCT5:
                amo_emu_add(&regs[rd], rs2, rs1);
                break;
            case AMO_SWAP_FUNCT5:
                amo_emu_swap(&regs[rd], rs2, rs1);
                break;
            case AMO_XOR_FUNCT5:
                amo_emu_xor(&regs[rd], rs2, rs1);
                break;
            case AMO_OR_FUNCT5:
                amo_emu_or(&regs[rd], rs2, rs1);
                break;
            case AMO_AND_FUNCT5:
                amo_emu_and(&regs[rd], rs2, rs1);
                break;
            case AMO_MIN_FUNCT5:
                amo_emu_min(&regs[rd], rs2, rs1);
                break;
            case AMO_MAX_FUNCT5:
                amo_emu_max(&regs[rd], rs2, rs1);
                break;
            case AMO_MINU_FUNCT5:
                amo_emu_minu(&regs[rd], rs2, rs1);
                break;
            case AMO_MAXU_FUNCT5:
                amo_emu_maxu(&regs[rd], rs2, rs1);
                break;
            }
        }
        __asm__ volatile("csrr t0, mepc\n"
                         "addi t0, t0, 4\n" // Skip past the emulated instruction
                         "csrw mepc, t0\n"
                         "lw x31, 124(sp)\n"
                         "lw x30, 120(sp)\n"
                         "lw x29, 116(sp)\n"
                         "lw x28, 112(sp)\n"
                         "lw x27, 108(sp)\n"
                         "lw x26, 104(sp)\n"
                         "lw x25, 100(sp)\n"
                         "lw x24, 96(sp)\n"
                         "lw x23, 92(sp)\n"
                         "lw x22, 88(sp)\n"
                         "lw x21, 84(sp)\n"
                         "lw x20, 80(sp)\n"
                         "lw x19, 76(sp)\n"
                         "lw x18, 72(sp)\n"
                         "lw x17, 68(sp)\n"
                         "lw x16, 64(sp)\n"
                         "lw x15, 60(sp)\n"
                         "lw x14, 56(sp)\n"
                         "lw x13, 52(sp)\n"
                         "lw x12, 48(sp)\n"
                         "lw x11, 44(sp)\n"
                         "lw x10, 40(sp)\n"
                         "lw x9, 36(sp)\n"
                         "lw x8, 32(sp)\n"
                         "lw x7, 28(sp)\n"
                         "lw x6, 24(sp)\n"
                         "lw x5, 20(sp)\n"
                         "lw x4, 16(sp)\n"
                         "lw x3, 12(sp)\n"
                         "lw x1, 4(sp)\n"
                         "addi sp, sp, 128\n"
                         "mret");
    }
}
