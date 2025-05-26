#include <cstring>
#include <iostream>
#include <stdio.h>

#include "verilated.h"
#include "Vdecompressor.h"
#include "encoding.out.h"
#include "gen_tests.h"

unsigned test_count = 0;
unsigned pass_count = 0;
unsigned ignore_count = 0;

auto check(uint16_t insn, uint32_t actual, InstructionEncoding& expected) -> void {
    test_count += 1;
    if(actual == expected.decompressedEncoding) {
        printf("[PASS]: 0x%04x -> 0x%08x %s\n", insn, actual, expected.compressedMnemonic);
        pass_count += 1;
    } else if(std::strstr(expected.compressedMnemonic, "hint") != nullptr) {
        // ignore HINTs for now
        printf("[IGNORE]: Hint 0x%04x -> 0x%08x %s\n", insn, actual, expected.compressedMnemonic);
        ignore_count += 1;
    } else if(std::strstr(expected.compressedMnemonic, "custom") != nullptr) {
        printf("[IGNORE]: Custom 0x%04x -> 0x%08x %s\n", insn, actual, expected.compressedMnemonic);
        ignore_count += 1;
    } else {
        printf("[FAIL]: %s 0x%04x -> 0x%08x (Expected 0x%08x)\n", expected.compressedMnemonic, insn, actual, expected.decompressedEncoding);
    }
}

int main() {
    Vdecompressor dut;
    InstructionEncoding encodingOut;

    for(auto i = 0; i < (1 << 16); i++) {
        if((i & 0x3) == 0x3) continue; // not RV32C
        dut.compressed = (uint16_t)i;
        dut.eval();
        decompress((uint16_t)i, &encodingOut);
        check((uint16_t)i, dut.decompressed, encodingOut);
    }

    std::cout << "Passed " << pass_count << " / " << test_count << " tests, failed " << (test_count - pass_count - ignore_count) << std::endl;
    std::cout << "(Ignored " << ignore_count << " / " << test_count << " tests)" << std::endl;

    return 0;
}

