#ifndef __UTILITY_H__
#define __UTILITY_H__

#include <stdint.h>

extern int32_t flag;

extern volatile int32_t hart_done;
extern volatile int32_t hart1_done;
extern volatile int32_t hart2_done;
extern volatile int32_t hart3_done;
extern volatile int32_t hart4_done;
extern volatile int32_t hart5_done;
extern volatile int32_t hart6_done;
extern volatile int32_t hart7_done;

#define MTIME_ADDR 0xFFFFFFE0
#define MTIMEH_ADDR 0xFFFFFFE4
#define MTIMECMP_ADDR 0xFFFFFFE8
#define MTIMECMPH_ADDR 0xFFFFFFEC
#define MSIP_ADDR 0xFFFFFFF0
#define EXT_ADDR_SET 0xFFFFFFF4
#define EXT_ADDR_CLEAR 0xFFFFFFF8
#define MAGIC_ADDR 0xFFFFFFFC

void print(const char *fmt, ...);
void put_uint32_hex(uint32_t hex);
uint32_t get_cycles();
uint32_t get_instrs();
void wait_for_all_harts_done();
uint32_t get_mhartid();

#endif
