#include <stdio.h>

#include "gen_tests.h"

// Test cases for RISC-V RV32C/RV64C C0 quadrant instructions
// Format: {compressed 16-bit instruction, expected decompressed 32-bit instruction}
// RV64C vs RV32C instruction selection is handled with preprocessor conditionals
const struct {
    uint16_t compressed;
    uint32_t decompressed;
} rv32c_c0_test_cases[] = {
    // Illegal instruction cases
    {0x0000, 0x00000000},  // Reserved when nzuimm=0 for C.ADDI4SPN (illegal instruction)
    
    // C.ADDI4SPN cases - same for both RV32C and RV64C
    {0x0410, 0x20010613},  // C.ADDI4SPN: addi x10, x2, 512
    {0x1FD0, 0x3f410613},  // C.ADDI4SPN: addi x10, x2, 1012
    {0x1FFC, 0x3fc10793},  // C.ADDI4SPN: addi x15, x2, 1020
    {0x0840, 0x01410413},  // C.ADDI4SPN: addi x8, x2, 20
    // C.FLD
    {0x3aa0, 0x0706b407}, // C.FLD fs0, 132(a3)
    // C.FSD
    {0xa0d0, 0x08c4b027}, // C.FSD fa2, 128(s1)
    // C.LW cases - load word instructions
    // Format: c.lw rd', offset(rs1')
    {0x4308, 0x00072503},  // C.LW: lw a0, 0(a4)
    // C.SW cases - store word instructions
    // Format: c.sw rs2', offset(rs1')
    {0xddb4, 0x06d5ac23},  // C.SW: sw a3, 120(a1)
    {0x073a, 0x00e71713}, // C.SLLI
    {0x3462, 0x03813407}, // C.FLDSP fs0, 56
    {0x4752, 0x01412703}, // C.LWSP a4, 20
    {0x8b82, 0x000b8067}, // C.JR s7
    {0x8e26, 0x00900e33}, // C.MV t3, s1
    {0x9002, 0x00100073}, // C.EBREAK
    {0x9182, 0x000180e7}, // C.JALR 
    {0x931e, 0x00700333}, // C.ADD t1, t2
    {0xac26, 0x00913c27}, // C.FSDSP fs1, 24
    {0xd22e, 0x02b12223}, // C.SWSP a1, 36
    // C1 quadrant
    {0x1, 0x00000013}, // c.nop
    {0x1f7d, 0xffff0f13}, // c.addi x30, -1
    {0x5735, 0xfed00713}, // c.li a4, -19
    {0x7111, 0xf0010113}, // c.addi16sp -256
    {0x6229, 0x0000a237}, // c.lui
    {0x80cd, 0x0134d493}, // c.srli
    {0x84cd, 0x4134d493}, // c.srai
    {0x9885, 0xfe14f493}, // c.andi s1, 0x61
    {0x8c05, 0x40940433}, // c.sub s0, s1 
    {0x8da9, 0x00a5c5b3}, // c.xor a1, a0
    {0x8e55, 0x00d66633}, // c.or a2, a3
    {0x8f7d, 0x00f77733}, // c.and a4, a5
    {0xbfed, 0xffbff06f},
    {0xd001, 0xf00400e3}, // c.beqz s0, -256
    {0xecfd, 0x0e049f63}, // c.bnez s1, 254
#ifdef RV64C_MODE
    // RV64C-specific instructions

    // C.LD cases (RV32C only) - load single-precision floating point
    // Format: c.flw rd', offset(rs1')
    {0x60a0, 0x0404b403},  // C.LD: ld s0, 64(s1)
    // C.SD cases (RV32C only) - store single-precision floating point
    // Format: c.fsw rs2', offset(rs1')
    {0xe004, 0x00943023},  // C.SD: sd s1, 0(s0)
    {0x6632, 0x10813603}, // C.LDSP a2, 264(sp)
    {0xf4ca, 0x07213423}, // C.SDSP s2, 104
    {0x3fc5, 0xff1f8f9b}, // c.addiw t6, -15
    {0x9fa9, 0x00a787bb}, // c.addw a5, a0
    {0x9d81, 0x408585bb}, // c.subw a1, a1, s0
#else
    // RV32C-specific instructions

    // C.FLW cases (RV32C only) - load single-precision floating point
    // Format: c.flw rd', offset(rs1')
    {0x60a0, 0x0404a407},  // C.FLW: flw fs0, 0(s1)
    // C.FSW cases (RV32C only) - store single-precision floating point
    // Format: c.fsw rs2', offset(rs1')
    {0xe004, 0x00942027},  // C.FSW: fsw fs1, 0(s0)
    {0x6632, 0x00c12607}, // C.FLWSP fa2, 12
    {0xf4ca, 0x07212427}, // C.FSWSP fs2, 104
    {0x3fc5, 0xff1ff0ef}, // c.jal -16
#endif
};

int main() {
    InstructionEncoding encodingOut;
    for(int i = 0; i < sizeof rv32c_c0_test_cases / sizeof rv32c_c0_test_cases[0]; i++) {
        decompress(rv32c_c0_test_cases[i].compressed, &encodingOut);
        if(rv32c_c0_test_cases[i].decompressed == encodingOut.decompressedEncoding) {
            printf("[PASS]: ");
        } else {
            printf("[FAIL] (Expected %08x): ", rv32c_c0_test_cases[i].decompressed);
        }

        printf("%s -> %s (%04x -> %08x)\n", encodingOut.compressedMnemonic, encodingOut.decompressedMnemonic, encodingOut.compressedEncoding, encodingOut.decompressedEncoding);
    }
}