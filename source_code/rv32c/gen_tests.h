#ifndef __GEN_TESTS_H__
#define __GEN_TESTS_H__

#include <stdint.h>

typedef struct {
    uint16_t compressedEncoding;
    uint32_t decompressedEncoding;
    char compressedMnemonic[80];
    char decompressedMnemonic[80];
} InstructionEncoding;

void decompress(uint16_t insn, InstructionEncoding *encodingOut);
#endif