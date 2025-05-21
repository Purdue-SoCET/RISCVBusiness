#ifndef __GEN_TESTS_H__
#define __GEN_TESTS_H__

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    uint16_t compressedEncoding;
    uint32_t decompressedEncoding;
    char compressedMnemonic[80];
    char decompressedMnemonic[80];
} InstructionEncoding;

#ifdef __cplusplus
}
#endif

void decompress(uint16_t insn, InstructionEncoding *encodingOut);
#endif