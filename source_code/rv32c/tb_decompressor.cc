#include <cstring>
#include <iostream>
#include <format>

#include "verilated.h"
#include "Vdecompressor.h"
#include "gen_tests.h"

unsigned test_count = 0;
unsigned pass_count = 0;
unsigned ignore_count = 0;

auto check(uint16_t insn, uint32_t actual, InstructionEncoding& expected) -> void {
    test_count += 1;
    if(actual == expected.decompressedEncoding) {
        std::cout << std::format("[PASS]: {:#04x} -> {:#08x} {}", insn, actual, expected.compressedMnemonic) << std::endl;
        pass_count += 1;
    } else if(std::strstr(expected.compressedMnemonic, "hint") != nullptr) {
        // ignore HINTs for now
        std::cout << std::format("[IGNORE]: Hint {:#04x} -> {:#08x} {}", insn, actual, expected.compressedMnemonic) << std::endl;
        ignore_count += 1;
    } else if(std::strstr(expected.compressedMnemonic, "reserved") != nullptr) {
        std::cout << std::format("[IGNORE] Reserved {:#04x} -> {:#08x} {}", insn, actual, expected.compressedMnemonic) << std::endl;
        ignore_count += 1;
    } else if(std::strstr(expected.compressedMnemonic, "custom") != nullptr) {
        std::cout << std::format("[IGNORE] Custom {:#04x} -> {:#08x} {}", insn, actual, expected.compressedMnemonic) << std::endl;
        ignore_count += 1;
    } else if(std::strstr(expected.compressedMnemonic, "subw") != nullptr
                || std::strstr(expected.compressedMnemonic, "addw") != nullptr) {
        std::cout << std::format("[IGNORE] RV64 Only {:#04x} {}", insn, expected.compressedMnemonic) << std::endl;
        ignore_count += 1;
    } else {
        std::cout << std::format("[FAIL]: {} {:#04x} -> {:#08x} (Expected {:#08x})", expected.compressedMnemonic, insn, actual, expected.decompressedEncoding) << std::endl;
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

