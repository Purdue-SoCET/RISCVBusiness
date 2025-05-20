#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdint.h>

#include "riscv-opcodes/encoding.out.h"
#include "gen_tests.h"

#define USE_ZCF (1)
#define USE_ZCD (1)

#define FULL_RD_OFFSET (7)
#define FULL_RS1_OFFSET (15)
#define FULL_RS2_OFFSET (20)

const char *registerNames[] = {
    "zero", "ra", "sp", "gp",
    "tp", "t0", "t1", "t2",
    "s0", "s1", "a0", "a1",
    "a2", "a3", "a4", "a5",
    "a6", "a7", "s2", "s3",
    "s4", "s5", "s6", "s7",
    "s8", "s9", "s10", "s11",
    "t3", "t4", "t5", "t6"
};

const char *fpRegisterNames[] = {
    "ft0", "ft1", "ft2", "ft3",
    "ft4", "ft5", "ft6", "ft7",
    "fs0", "fs1", "fa0", "fa1",
    "fa2", "fa3", "fa4", "fa5",
    "fa6", "fa7", "fs2", "fs3",
    "fs4", "fs5", "fs6", "fs7",
    "fs8", "fs9", "fs10", "fs11",
    "ft8", "ft9", "ft10", "ft11"
};



static inline
size_t cregToIdx(size_t creg) {
    assert(creg < 8);
    return creg + 8;
}

static inline
void unimplemented(const char *msg) {
    fprintf(stderr, "UNIMPLEMENTED: %s\n", msg);
    __builtin_unreachable();
}

static inline
void reserved_instruction(uint16_t compressed, const char *mnemonic_hint, InstructionEncoding *encodingOut) {
    encodingOut->compressedEncoding = compressed;
    sprintf(encodingOut->compressedMnemonic, "reserved %04x (%s)", compressed, mnemonic_hint);
    encodingOut->decompressedEncoding = 0;
    strcpy(encodingOut->decompressedMnemonic, "reserved");
}

static inline
int32_t sigext(uint32_t value, unsigned int bits) {
    // Validate input
    assert(bits > 0 && bits < 32);
    
    // Create a mask for the sign bit (most significant bit of the N-bit value)
    uint32_t sign_bit = 1u << (bits - 1);
    
    // Check if the sign bit is set
    if (value & sign_bit) {
        // Sign bit is 1, extend with 1s
        
        // Create a mask for all bits above the sign bit
        uint32_t mask = ~((1u << bits) - 1);
        
        // Apply the mask to set all higher bits to 1
        return (int32_t)(value | mask);
    } else {
        // Sign bit is 0, just return the value (already zero-extended)
        return (int32_t)value;
    }
}

uint32_t make_store(uint32_t base, uint32_t rs1, uint32_t rs2, uint32_t imm) {
    return base
        | (imm & 0xFE0) << 20
        | (imm & 0x1F) << 7
        | rs2 << FULL_RS2_OFFSET
        | rs1 << FULL_RS1_OFFSET;
}

uint32_t make_load(uint32_t base, uint32_t rs1, uint32_t rd, uint32_t imm) {
    return base 
            | imm << 20
            | rs1 << FULL_RS1_OFFSET
            | rd  << FULL_RD_OFFSET;
}

void decompressC0(uint16_t insn, InstructionEncoding *encodingOut) {
    unsigned funct3 = (insn >> 13) & 0x7;
    assert(funct3 < 8);
    switch(funct3) {
        case 0b000: {
            if(insn == 0) {
                // illegal insn
                encodingOut->compressedEncoding = insn;
                encodingOut->decompressedEncoding = 0;
                strcpy(encodingOut->compressedMnemonic, "unimp");
                strcpy(encodingOut->decompressedMnemonic, "unimp");
            } else {
                // c.addi4spn rd, nzuimm -> addi rd', x2, nzuim[9:2]
                // insn[12:5] = nzuimm[5:4|9:6|2|3]
                uint32_t imm = ((insn >> 4) & 0b100)
                                | ((insn >> 2) & 0b1000)
                                | ((insn >> 7) & 0b110000)
                                | ((insn >> 1) & 0b1111000000);
                uint32_t rdp = (insn & INSN_FIELD_RD_P) >> 2;
                uint32_t rd = cregToIdx(rdp);
                uint32_t decompressed = MATCH_ADDI
                                | (imm << 20)
                                | (0x2 << FULL_RS1_OFFSET)
                                | (rd << FULL_RD_OFFSET);
                        
                encodingOut->compressedEncoding = insn;
                encodingOut->decompressedEncoding = decompressed;
                sprintf(encodingOut->compressedMnemonic, "c.addi4spn %s", registerNames[rd]);
                sprintf(encodingOut->decompressedMnemonic, "addi %s, %s, %d", registerNames[rd], registerNames[2], sigext(imm, 12));
            }
        } break;

#ifdef RV64C_MODE
        // In RV64C, this funct is LD instead of FLW
        case 0b011:
#endif
        case 0b001: {
            // c.fld rd', imm(rs1') -> fld rd, offset(rs1)
            // c.ld rd', imm(rs1') -> ld, rd, offset(rs1)
            // imm3 = offset[5:3], imm2 = offset[7:6]
            uint32_t rs1 = cregToIdx((insn & INSN_FIELD_RS1_P) >> 7);
            uint32_t rd  = cregToIdx((insn & INSN_FIELD_RD_P) >> 2);
            uint32_t imm = (insn & INSN_FIELD_C_UIMM7HI) >> 7
                            | (insn & INSN_FIELD_C_UIMM7LO) << 1;
            uint32_t base = (funct3 == 0b011) ? MATCH_LD : MATCH_FLD;
            uint32_t decompressed = make_load(base, rs1, rd, imm);
            encodingOut->compressedEncoding = insn;
            encodingOut->decompressedEncoding = decompressed;
            sprintf(encodingOut->compressedMnemonic, "%s %s, %d(%s)", funct3 == 0b011 ? "c.ld" : "c.fld",
                funct3 == 0b011 ? registerNames[rd] : fpRegisterNames[rd],
                sigext(imm, 12), registerNames[rs1]);
            sprintf(encodingOut->decompressedMnemonic, "%s %s, %d(%s)", funct3 == 0b011 ? "ld" : "fld",
                funct3 == 0b011 ? registerNames[rd] : fpRegisterNames[rd],
                sigext(imm, 12), registerNames[rs1]);
        } break;
#ifndef RV64C_MODE
        // In RV32C, this is c.flw instead of c.ld
        case 0b011:
#endif
        case 0b010: {
            uint32_t rs1 = cregToIdx((insn & INSN_FIELD_RS1_P) >> 7);
            uint32_t rd  = cregToIdx((insn & INSN_FIELD_RD_P) >> 2);
            uint32_t imm = (insn & INSN_FIELD_C_UIMM7HI) >> 7
                            | (((insn & INSN_FIELD_C_UIMM7LO) << 1) & 0b1000000)
                            | (((insn & INSN_FIELD_C_UIMM7LO) >> 4) & 0b100);
            uint32_t base = (funct3 == 0b011) ? MATCH_FLW : MATCH_LW;
            uint32_t decompressed = make_load(base, rs1, rd, imm);
            encodingOut->compressedEncoding = insn;
            encodingOut->decompressedEncoding = decompressed;
            sprintf(encodingOut->compressedMnemonic, "%s %s, %d(%s)", funct3 == 0b011 ? "c.flw" : "c.lw",
                funct3 == 0b011 ? fpRegisterNames[rd] : registerNames[rd],
                sigext(imm, 12), registerNames[rs1]);
            sprintf(encodingOut->decompressedMnemonic, "%s %s, %d(%s)", funct3 == 0b011 ? "flw" : "lw",
                funct3 == 0b011 ? fpRegisterNames[rd] : registerNames[rd],
                sigext(imm, 12), registerNames[rs1]);
        } break;

        case 0b100: {
#ifdef USE_ZCB

#else
            reserved_instruction(insn, "zcb space", encodingOut);
#endif
        } break;

#ifdef RV64C_MODE
        // In RV64C, funct3 0b111 is c.sd
        case 0b111:
#endif
        case 0b101: {
            uint32_t rs1 = cregToIdx((insn & INSN_FIELD_RS1_P) >> 7);
            uint32_t rs2 = cregToIdx((insn & INSN_FIELD_RS2_P) >> 2);
            uint32_t imm = (insn & INSN_FIELD_C_UIMM7HI) >> 7
                | ((insn & INSN_FIELD_C_UIMM7LO) << 1);
            uint32_t base = (funct3 == 0b111) ? MATCH_SD : MATCH_FSD;
            uint32_t decompressed = make_store(base, rs1, rs2, imm);
            encodingOut->compressedEncoding = insn;
            encodingOut->decompressedEncoding = decompressed;
            sprintf(encodingOut->compressedMnemonic, "%s %s, %d(%s)", funct3 == 0b111 ? "c.sd" : "c.fsd",
                funct3 == 0b111 ? fpRegisterNames[rs2] : registerNames[rs2],
                sigext(imm, 12), registerNames[rs1]);
            sprintf(encodingOut->decompressedMnemonic, "%s %s, %d(%s)", funct3 == 0b111 ? "sd" : "fsd",
                funct3 == 0b111 ? fpRegisterNames[rs2] : registerNames[rs2],
                sigext(imm, 12), registerNames[rs1]);
        } break;

#ifndef RV64C_MODE
        // In RV32C, funct3 0b111 is c.fsw
        case 0b111:
#endif
        case 0b110: {
            uint32_t rs1 = cregToIdx((insn & INSN_FIELD_RS1_P) >> 7);
            uint32_t rs2 = cregToIdx((insn & INSN_FIELD_RS2_P) >> 2);
            uint32_t imm = (insn & INSN_FIELD_C_UIMM7HI) >> 7
                | (((insn & INSN_FIELD_C_UIMM7LO) << 1) & 0b1000000)
                | (((insn & INSN_FIELD_C_UIMM7LO) >> 4) & 0b100);
            uint32_t base = (funct3 == 0b111) ? MATCH_FSW : MATCH_SW;
            uint32_t decompressed = make_store(base, rs1, rs2, imm);
            encodingOut->compressedEncoding = insn;
            encodingOut->decompressedEncoding = decompressed;
            sprintf(encodingOut->compressedMnemonic, "%s %s, %d(%s)", funct3 == 0b111 ? "c.fsw" : "c.sw",
                funct3 == 0b111 ? fpRegisterNames[rs2] : registerNames[rs2],
                sigext(imm, 12), registerNames[rs1]);
            sprintf(encodingOut->decompressedMnemonic, "%s %s, %d(%s)", funct3 == 0b111 ? "fsw" : "sw",
                funct3 == 0b111 ? fpRegisterNames[rs2] : registerNames[rs2],
                sigext(imm, 12), registerNames[rs1]);
        } break;

        default: __builtin_unreachable();
    }
}

void decompressC1(uint16_t insn, InstructionEncoding *encodingOut) {
    unimplemented("Quadrant C1");
}

void decompressC2(uint16_t insn, InstructionEncoding *encodingOut) {
    unimplemented("Quadrant C2");
}

void decompress(uint16_t insn, InstructionEncoding *encodingOut) {
    switch(insn & 0x3) {
        case 0b00: decompressC0(insn, encodingOut);
            break;
        case 0b01: decompressC1(insn, encodingOut);
            break;
        case 0b10: decompressC2(insn, encodingOut);
            break;
        case 0b11: __builtin_unreachable();
    }
}
