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
#ifdef RV64C_MODE
    // RV64C-specific instructions

    // C.LD cases (RV32C only) - load single-precision floating point
    // Format: c.flw rd', offset(rs1')
    {0x60a0, 0x0404b403},  // C.LD: ld s0, 64(s1)
    // C.SD cases (RV32C only) - store single-precision floating point
    // Format: c.fsw rs2', offset(rs1')
    {0xe004, 0x00943023},  // C.SD: sd s1, 0(s0)
    
#else
    // RV32C-specific instructions

    // C.FLW cases (RV32C only) - load single-precision floating point
    // Format: c.flw rd', offset(rs1')
    {0x60a0, 0x0404a407},  // C.FLW: flw fs0, 0(s1)
    // C.FSW cases (RV32C only) - store single-precision floating point
    // Format: c.fsw rs2', offset(rs1')
    {0xe004, 0x00942027},  // C.FSW: fsw fs1, 0(s0)

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