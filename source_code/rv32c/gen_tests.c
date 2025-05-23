#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdint.h>

#include "encoding.out.h"
#include "gen_tests.h"

#define USE_ZCF (1)
#define USE_ZCD (1)

#define FULL_RD_OFFSET (7)
#define FULL_RS1_OFFSET (15)
#define FULL_RS2_OFFSET (20)
#define FULL_ITYPE_IMM_OFFSET (20)

#define REG_ZERO (0)
#define REG_RA (1)
#define REG_SP (2)

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
void hint_instruction(uint16_t compressed, const char *mnemonic_hint, InstructionEncoding *encodingOut) {
    encodingOut->compressedEncoding = compressed;
    sprintf(encodingOut->compressedMnemonic, "hint %04x (%s)", compressed, mnemonic_hint);
    encodingOut->decompressedEncoding = 0x1; // canonical nop; in TB ignore completely
    strcpy(encodingOut->decompressedMnemonic, "hint");
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

static inline
uint32_t make_itype(uint32_t base, uint32_t rs1, uint32_t rd, uint32_t imm) {
        return base 
            | imm << FULL_ITYPE_IMM_OFFSET
            | rs1 << FULL_RS1_OFFSET
            | rd  << FULL_RD_OFFSET;
}

static inline
uint32_t make_rtype(uint32_t base, uint32_t rs1, uint32_t rs2, uint32_t rd) {
    return base
        | rs1 << FULL_RS1_OFFSET
        | rs2 << FULL_RS2_OFFSET
        | rd << FULL_RD_OFFSET;
}

static inline
uint32_t make_store(uint32_t base, uint32_t rs1, uint32_t rs2, uint32_t imm) {
    return base
        | (imm & 0xFE0) << 20
        | (imm & 0x1F) << 7
        | rs2 << FULL_RS2_OFFSET
        | rs1 << FULL_RS1_OFFSET;
}

static inline
uint32_t make_load(uint32_t base, uint32_t rs1, uint32_t rd, uint32_t imm) {
    return make_itype(base, rs1, rd, imm);
}

static inline
uint32_t make_jal(uint32_t rd, uint32_t imm) {
    return MATCH_JAL
            | (rd << FULL_RD_OFFSET)
            | (imm & 0x100000) << 11
            | (imm & 0x7FE) << 20
            | (imm & 0x800) << 9
            | (imm & 0xFF000);
}

static inline
uint32_t make_branch(uint32_t base, uint32_t rs1, uint32_t imm) {
    // branch format
    // imm_hi is imm[12|10:5]
    // imm_lo is imm[4:1|11]
    return base
        | (rs1 << FULL_RS1_OFFSET)
        | (REG_ZERO << FULL_RS2_OFFSET)
        | (imm & 0x1000) << 19
        | (imm & 0x7E0) << 20
        | (imm & 0x1E) << 7
        | (imm & 0x800) >> 4;
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
            unimplemented("Zcb extension");
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
    uint16_t funct3 = (insn >> 13) & 0x7;
    switch(funct3) {
        case 0b000: {
            // ADDI, NOP if rd = 0, HINT if imm = 0
            // c.addi rd, imm -> addi rd, rd, imm
            uint32_t rs1 = (insn & INSN_FIELD_C_RS1_N0) >> 7;
            uint32_t imm = (insn & INSN_FIELD_C_NZIMM6HI) >> 7
                            | (insn & INSN_FIELD_C_NZIMM6LO) >> 2;
            imm = sigext(imm, 6);
            if(rs1 == 0 && imm != 0) {
                hint_instruction(insn, "nop imm != 0", encodingOut);
            } else if(rs1 != 0 && imm == 0) {
                hint_instruction(insn, "addi zero, imm", encodingOut);
            } else {
                uint32_t decompressed = make_itype(MATCH_ADDI, rs1, rs1, imm);
                encodingOut->compressedEncoding = insn;
                encodingOut->decompressedEncoding = decompressed;
                if(rs1 == 0 && imm == 0) {
                    strcpy(encodingOut->compressedMnemonic, "c.nop");
                    strcpy(encodingOut->decompressedMnemonic, "nop");
                } else {
                    sprintf(encodingOut->compressedMnemonic, "c.addi %s, %d", registerNames[rs1], sigext(imm, 12));
                    sprintf(encodingOut->decompressedMnemonic, "addi %s, %s, %d", registerNames[rs1], registerNames[rs1], sigext(imm, 12));
                }
            }
        } break;

#ifdef RV64C_MODE
        case 0b001: {
            // For RV64C, 001 is c.addiw
            uint32_t rs1 = (insn & INSN_FIELD_C_RS1_N0) >> 7;
            uint32_t imm = (insn & INSN_FIELD_C_NZIMM6HI) >> 7
                            | (insn & INSN_FIELD_C_NZIMM6LO) >> 2;
            
            if(rs1 == 0) {
                reserved_instruction(insn, "c.addiw x0, imm");
            } else {
                uint32_t decompressed = make_itype(MATCH_ADDIW, rs1, rs1, imm);
                encodingOut->compressedEncoding = insn;
                encodingOut->decompressedEncoding = decompressed;
                sprintf(encodingOut->compressedMnemonic, "c.addiw %s, %d", registerNames[rs1], sigext(imm, 12));
                sprintf(encodingOut->decompressedMnemonic, "addiw %s, %s, %d", registerNames[rs1], registerNames[rs1], sigext(imm, 12));
            }
        } break;
#endif

        case 0b010: {
            // c.li rd, imm -> addi rd, x0, imm
            // note: c.li *sign extends* its imm!
            uint32_t rd = (insn & INSN_FIELD_C_RS1_N0) >> 7;
            uint32_t imm = (insn & INSN_FIELD_C_IMM6HI) >> 7
                            | (insn & INSN_FIELD_C_IMM6LO) >> 2;
            imm = sigext(imm, 6);
            uint32_t decompressed = make_itype(MATCH_ADDI, REG_ZERO, rd, imm);
            encodingOut->compressedEncoding = insn;
            encodingOut->decompressedEncoding = decompressed;
            sprintf(encodingOut->compressedMnemonic, "c.li %s, %d", registerNames[rd], imm);
            sprintf(encodingOut->decompressedMnemonic, "addi %s, %s, %d", registerNames[rd], registerNames[REG_ZERO], imm);
        } break;

        case 0b011: {
            // c.lui rd, imm -> lui rd, imm; rd != 0 and rd != 2
            // c.lui is reserved if imm = 0
            // c.lui is hint if rd = 0
            // addi16sp if rd = 2
            uint32_t rd = (insn & INSN_FIELD_C_RS1_N0) >> 7;
            if(rd == 2) {
                // addi16sp imm -> addi x2, x2, imm
                // hi field is imm[9]
                // lo field is imm[4|6|8:7|5]
                uint32_t imm_field = (insn & INSN_FIELD_C_NZIMM10LO) >> 2;
                uint32_t imm = (imm_field & 0b10000)
                            | (imm_field & 0b1) << 5
                            | (imm_field & 0b1000) << 3
                            | (imm_field & 0b110) << 6
                            | (insn & INSN_FIELD_C_NZIMM10HI) >> 3;
                imm = sigext(imm, 10);
                if(imm == 0) {
                    reserved_instruction(insn, "c.addi16sp 0", encodingOut);
                } else {
                    uint32_t decompressed = make_itype(MATCH_ADDI, REG_SP, REG_SP, imm);
                    encodingOut->compressedEncoding = insn;
                    encodingOut->decompressedEncoding = decompressed;
                    sprintf(encodingOut->compressedMnemonic, "c.addi16sp %d", imm);
                    sprintf(encodingOut->decompressedMnemonic, "addi sp, sp, %d", imm);
                }
            } else {
                // c.lui rd, imm -> lui rd, imm
                uint32_t imm = (insn & INSN_FIELD_C_NZIMM6HI) >> 7
                                | (insn & INSN_FIELD_C_NZIMM6LO) >> 2;
                imm = sigext(imm, 6);
                if(rd == 0) {
                    hint_instruction(insn, "c.lui x0, imm", encodingOut);
                } else if(imm == 0) {
                    reserved_instruction(insn, "c.lui rd, 0", encodingOut);
                } else {
                    uint32_t decompressed = MATCH_LUI
                                        | rd << FULL_RD_OFFSET
                                        | imm << 12;
                    encodingOut->compressedEncoding = insn;
                    encodingOut->decompressedEncoding = decompressed;
                    sprintf(encodingOut->compressedMnemonic, "c.lui %s, %d", registerNames[rd], imm);
                    sprintf(encodingOut->decompressedMnemonic, "lui %s, %d", registerNames[rd], imm);
                }
            }
        } break;

        case 0b100: {
            uint16_t minor_opcode = (insn >> 10) & 0x3;
            uint32_t rs1 = cregToIdx((insn & INSN_FIELD_RS1_P) >> 7);
            switch(minor_opcode) {
                case 0b00: 
                case 0b01: {
                    uint32_t base = minor_opcode == 0b00 ? MATCH_SRLI : MATCH_SRAI;
                    uint32_t imm = (insn & INSN_FIELD_C_IMM6HI) >> 7
                                | (insn & INSN_FIELD_C_IMM6LO) >> 2;
                    if(imm == 0) {
                        hint_instruction(insn, minor_opcode == 0b00 ? "srli64" : "srai64", encodingOut);
                    } else if(imm >= 32) {
                        hint_instruction(insn, minor_opcode == 0b00 ? "srli rd, imm >= 32" : "srai rd, imm >= 32", encodingOut);
                    } else {
                        uint32_t decompress = make_itype(base, rs1, rs1, imm);
                        encodingOut->compressedEncoding = insn;
                        encodingOut->decompressedEncoding = decompress;
                        sprintf(encodingOut->compressedMnemonic, "%s %s, %d", minor_opcode == 0b00 ? "c.srli" : "c.srai", registerNames[rs1], imm);
                        sprintf(encodingOut->compressedMnemonic, "%s %s, %s, %d", minor_opcode == 0b00 ? "c.srli" : "c.srai", registerNames[rs1], registerNames[rs1], imm);
                    }
                } break;
                case 0b10: {
                    uint32_t imm = (insn & INSN_FIELD_C_IMM6HI) >> 7
                                | (insn & INSN_FIELD_C_IMM6LO) >> 2;
                    imm = sigext(imm, 6);
                    uint32_t decompress = make_itype(MATCH_ANDI, rs1, rs1, imm);
                    encodingOut->compressedEncoding = insn;
                    encodingOut->decompressedEncoding = decompress;
                    sprintf(encodingOut->compressedMnemonic, "c.andi %s, %d", registerNames[rs1], imm);
                    sprintf(encodingOut->decompressedMnemonic, "andi %s, %s, %d", registerNames[rs1], registerNames[rs1], imm);
                } break;

                case 0b11: {
                    uint16_t sub_funct = (insn & 0x1000) >> 10
                                        | (insn & 0x60) >> 5;
                    uint32_t op_lookup[] = {
                        MATCH_SUB, MATCH_XOR, MATCH_OR, MATCH_AND,
                        MATCH_SUBW, MATCH_ADDW, 0, 0
                    };
                    const char *compressed_mnemonic_lookup[] = {
                        "c.sub", "c.xor", "c.or", "c.and",
                        "c.subw", "c.addw", "", ""
                    };

                    const char *decompressed_mnemonic_lookup[] = {
                        "sub", "xor", "or", "and",
                        "subw", "addw", "", ""
                    };
                    uint32_t rs2 = cregToIdx((insn & INSN_FIELD_RS2_P) >> 2);

                    if(sub_funct >= 6) {
                        reserved_instruction(insn, "arithmetic funct 6/7", encodingOut);
                    } else {
                        uint32_t decompressed = make_rtype(op_lookup[sub_funct], rs1, rs2, rs1);
                        encodingOut->compressedEncoding = insn;
                        encodingOut->decompressedEncoding = decompressed;
                        sprintf(encodingOut->compressedMnemonic, "%s %s, %s",
                                compressed_mnemonic_lookup[sub_funct], registerNames[rs1], registerNames[rs2]);
                        sprintf(encodingOut->decompressedMnemonic, "%s %s, %s, %s",
                                decompressed_mnemonic_lookup[sub_funct], registerNames[rs1], registerNames[rs1], registerNames[rs2]);
                    }
                } break;
            }
        } break;

#ifndef RV64C_MODE
        case 0b001:
#endif
        case 0b101: {
            // For RV32C, 001 is c.jal
            // c.jal imm -> jal ra, imm
            // c.j imm -> jal x0, imm
            // imm order: [11|4|9:8|10|6|7|3:1|5]
            uint32_t rd = funct3 == 0b001 ? REG_RA : REG_ZERO;
            uint32_t imm_field = (insn & INSN_FIELD_C_IMM12) >> 2;
            uint32_t imm = (imm_field & 0b1110)
                        | (imm_field & 0b1000000000) >> 5
                        | (imm_field & 0b1) << 5
                        | (imm_field & 0b100000) << 1
                        | (imm_field & 0b10000) << 3
                        | (imm_field & 0b110000000) << 1
                        | (imm_field & 0b1000000) << 4
                        | (imm_field & 0b10000000000) << 1;
            imm = sigext(imm, 12);
            uint32_t decompressed = make_jal(rd, imm);
            encodingOut->compressedEncoding = insn;
            encodingOut->decompressedEncoding = decompressed;
            sprintf(encodingOut->compressedMnemonic, "%s %d", funct3 == 0b001 ? "c.jal" : "c.j", imm);
            sprintf(encodingOut->decompressedMnemonic, "jal %s, %d", registerNames[rd], imm);
        } break;

        case 0b110: 
        case 0b111: {
            // branches
            // imm_lo has imm[7:6|2:1|5]
            // imm_hi has imm[8|4:3]
            uint32_t rs1 = cregToIdx((insn & INSN_FIELD_RS1_P) >> 7);
            uint32_t imm_lo = (insn & INSN_FIELD_C_BIMM9LO) >> 2;
            uint32_t imm_hi = (insn & INSN_FIELD_C_BIMM9HI) >> 10;
            uint32_t imm = (imm_lo & 0b110)
                            | (imm_hi & 0b11) << 3
                            | (imm_lo & 0b1) << 5
                            | (imm_lo & 0b11000) << 3
                            | (imm_hi & 0b100) << 6;
            imm = sigext(imm, 9);
            uint32_t decompress = make_branch(funct3 == 0b110 ? MATCH_BEQ : MATCH_BNE, rs1, imm);
            encodingOut->compressedEncoding = insn;
            encodingOut->decompressedEncoding = decompress;
            sprintf(encodingOut->compressedMnemonic, "%s %s, %d",
                funct3 == 0b110 ? "c.beqz" : "c.bnez", registerNames[rs1], imm);
            sprintf(encodingOut->decompressedMnemonic, "%s %s, %s, %d",
                funct3 == 0b110 ? "beq" : "bne", registerNames[rs1], registerNames[REG_ZERO], imm);
        } break;

        default: __builtin_unreachable();
    }
}

void decompressC2(uint16_t insn, InstructionEncoding *encodingOut) {
    uint16_t funct3 = (insn >> 13) & 0b111;
    switch(funct3) {
        case 0b000: {
            uint32_t rs1 = (insn & INSN_FIELD_C_RS1_N0) >> 7;
            uint32_t imm = (insn & INSN_FIELD_C_NZIMM6HI) >> 7
                            | (insn & INSN_FIELD_C_NZIMM6LO) >> 2;
            if(imm == 0) {
                hint_instruction(insn, "c.slli64", encodingOut);
            } else if(rs1 == 0) {
                char buf[40];
                sprintf(buf, "c.slli x0, %d", imm);
                hint_instruction(insn, "c.slli x0, n", encodingOut);
            } else {
                uint32_t decompressed = MATCH_SLLI
                        | imm << 20
                        | rs1 << FULL_RS1_OFFSET
                        | rs1 << FULL_RD_OFFSET;
                encodingOut->compressedEncoding = insn;
                encodingOut->decompressedEncoding = decompressed;
                sprintf(encodingOut->compressedMnemonic, "c.slli %s, %d", registerNames[rs1], imm);
                sprintf(encodingOut->decompressedMnemonic, "slli %s, %s, %d", registerNames[rs1], registerNames[rs1], imm);
            }
        } break;

#ifdef RV64C_MODE
        case 0b011:
#endif
        case 0b001: {
            // c.fldsp rd, imm -> fld rd, imm(sp)
            uint32_t rd = (insn & INSN_FIELD_C_RS1_N0) >> 7;
            uint32_t imm = (insn & INSN_FIELD_C_UIMM9SPHI) >> 7
                            | (((insn & INSN_FIELD_C_UIMM9SPLO) >> 2) & 0b11000)
                            | (((insn & INSN_FIELD_C_UIMM9SPLO) << 4) & 0b111000000);
            uint32_t base = funct3 == 0b011 ? MATCH_LD : MATCH_FLD;
            uint32_t decompressed = make_load(base, REG_SP, rd, imm);
            if(funct3 == 0b011 && rd == 0) {
                // c.ldsp x0, imm is reserved
                reserved_instruction(insn, "c.ldsp zero, imm", encodingOut);
            } else {
                encodingOut->compressedEncoding = insn;
                encodingOut->decompressedEncoding = decompressed;
                sprintf(encodingOut->compressedMnemonic, "%s %s, %d", funct3 == 0b011 ? "c.ldsp" : "c.fldsp",
                    funct3 == 0b011 ? registerNames[rd] : fpRegisterNames[rd],
                    sigext(imm, 12));
                sprintf(encodingOut->decompressedMnemonic, "%s %s, %s, %d", funct3 == 0b011 ? "ld" : "fld",
                    funct3 == 0b011 ? registerNames[rd] : fpRegisterNames[rd],
                    registerNames[REG_SP],
                    sigext(imm, 12));
            }
        } break;

#ifndef RV64C_MODE
        case 0b011:
#endif
        case 0b010: {
            // c.fldsp rd, imm -> fld rd, imm(sp)
            uint32_t rd = (insn & INSN_FIELD_C_RS1_N0) >> 7;
            uint32_t imm = (insn & INSN_FIELD_C_UIMM9SPHI) >> 7
                            | (((insn & INSN_FIELD_C_UIMM9SPLO) >> 2) & 0b11100)
                            | (((insn & INSN_FIELD_C_UIMM9SPLO) << 4) & 0b11000000);
            uint32_t base = funct3 == 0b011 ? MATCH_FLW : MATCH_LW;
            uint32_t decompressed = make_load(base, REG_SP, rd, imm);
            if(funct3 == 0b010 && rd == 0) {
                // c.lwsp x0, imm is reserved
                reserved_instruction(insn, "c.lw zero, imm", encodingOut);
            } else {
                encodingOut->compressedEncoding = insn;
                encodingOut->decompressedEncoding = decompressed;
                sprintf(encodingOut->compressedMnemonic, "%s %s, %d", funct3 == 0b011 ? "c.flwsp" : "c.lwsp",
                    funct3 == 0b011 ? fpRegisterNames[rd] : registerNames[rd],
                    sigext(imm, 12));
                sprintf(encodingOut->decompressedMnemonic, "%s %s, %s, %d", funct3 == 0b011 ? "flw" : "lw",
                    funct3 == 0b011 ? fpRegisterNames[rd] : registerNames[rd],
                    registerNames[REG_SP],
                    sigext(imm, 12));
            }
        } break;

        case 0b100: {
            uint32_t rs1 = (insn & INSN_FIELD_C_RS1_N0) >> 7;
            uint32_t rs2 = (insn & INSN_FIELD_C_RS2) >> 2;
            uint32_t determine_bit = (insn & INSN_FIELD_C_NZIMM6HI) >> 12;
            encodingOut->compressedEncoding = insn; // TODO: Pull this out

            if(!determine_bit && rs1 == 0 && rs2 == 0) {
                // RESERVED encoding: c.jr x0
                reserved_instruction(insn, "c.jr x0", encodingOut);
            } else if(rs1 == 0 && rs2 != 0) {
                // HINT encodings: c.add r0, ... and c.mv r0, ...
                hint_instruction(insn, determine_bit ? "c.add x0, rs2" : "c.mv x0, rs2", encodingOut);
            } else if(determine_bit == 1 && rs1 == 0 && rs2 == 0) {
                // c.ebreak
                encodingOut->decompressedEncoding = MATCH_EBREAK;
                strcpy(encodingOut->compressedMnemonic, "c.ebreak");
                strcpy(encodingOut->decompressedMnemonic, "ebreak");
            } else if(rs1 != 0 && rs2 == 0) {
                // c.jr rs1 -> jalr zero, 0(rs1)
                // c.jalr rs1 -> jalr ra, 0(rs1)
                // TODO: Reserved if jr with rs1 == 0
                uint32_t rd = determine_bit ? REG_RA : REG_ZERO;
                uint32_t decompressed = MATCH_JALR
                                | (rd << FULL_RD_OFFSET)
                                | (rs1 << FULL_RS1_OFFSET);
                encodingOut->decompressedEncoding = decompressed;
                sprintf(encodingOut->compressedMnemonic, "%s %s", determine_bit ? "c.jalr" : "c.jr", registerNames[rs1]);
                sprintf(encodingOut->decompressedMnemonic, "jalr %s, 0(%s)", registerNames[rd], registerNames[rs1]);
            } else {
                // c.mv rs1, rs2 -> add rs1, x0, rs2
                // c.add rs1, rs2 -> add rs1, rs1, rs2
                uint32_t rd = rs1;
                rs1 = determine_bit ? rs1 : REG_ZERO;
                uint32_t decompressed = MATCH_ADD
                                | (rd << FULL_RD_OFFSET)
                                | (rs1 << FULL_RS1_OFFSET)
                                | (rs2 << FULL_RS2_OFFSET);
                encodingOut->decompressedEncoding = decompressed;
                sprintf(encodingOut->compressedMnemonic, "%s %s, %s",
                    determine_bit ? "c.add" : "c.mv",
                    registerNames[rs1], registerNames[rs2]);
                sprintf(encodingOut->decompressedMnemonic, "add %s, %s, %s",
                    registerNames[rd], registerNames[rs1], registerNames[rs2]);
            }
        } break;

#ifdef RV64C_MODE
        // RV64C: c.sdsp
        case 0b111:
#endif
        case 0b101: {
            uint32_t rs2 = (insn & INSN_FIELD_C_RS2) >> 2;
            uint32_t imm = (((insn & INSN_FIELD_C_UIMM9SP_S) >> 7) & 0b111000)
                            | (((insn & INSN_FIELD_C_UIMM9SP_S) >> 1) & 0b111000000);
            uint32_t base = funct3 == 0b111 ? MATCH_SD : MATCH_FSD;
            uint32_t decompressed = make_store(base, REG_SP, rs2, imm);
            encodingOut->compressedEncoding = insn;
            encodingOut->decompressedEncoding = decompressed;
            sprintf(encodingOut->compressedMnemonic, "%s %s, %d(%s)",
                funct3 == 0b111 ? "c.sdsp" : "c.fsdsp",
                registerNames[rs2], sigext(imm, 12), registerNames[REG_SP]);
            sprintf(encodingOut->decompressedMnemonic, "%s %s, %d(%s)",
                funct3 == 0b111 ? "sd" : "fsd",
                registerNames[rs2], sigext(imm, 12), registerNames[REG_SP]);
        } break;

#ifndef RV64C_MODE
        // RV32C: c.fswsp
        case 0b111:
#endif
        case 0b110: {
            uint32_t rs2 = (insn & INSN_FIELD_C_RS2) >> 2;
            uint32_t imm = (((insn & INSN_FIELD_C_UIMM9SP_S) >> 7) & 0b111100)
                            | (((insn & INSN_FIELD_C_UIMM9SP_S) >> 1) & 0b11000000);
            uint32_t base = funct3 == 0b111 ? MATCH_FSW : MATCH_SW;
            uint32_t decompressed = make_store(base, REG_SP, rs2, imm);
            encodingOut->compressedEncoding = insn;
            encodingOut->decompressedEncoding = decompressed;
            sprintf(encodingOut->compressedMnemonic, "%s %s, %d(%s)",
                funct3 == 0b111 ? "c.fswsp" : "c.fswsp",
                funct3 == 0b111 ? fpRegisterNames[rs2] : registerNames[rs2],
                sigext(imm, 12), registerNames[REG_SP]);
            sprintf(encodingOut->decompressedMnemonic, "%s %s, %d(%s)",
                funct3 == 0b111 ? "fsw" : "sw",
                funct3 == 0b111 ? fpRegisterNames[rs2] : registerNames[rs2],
                sigext(imm, 12), registerNames[REG_SP]);            
        } break;

        default: __builtin_unreachable();
    }
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
