#ifndef __UTILITY_H__
#define __UTILITY_H__

#include <stdint.h>

extern volatile int32_t flag;
extern volatile uint32_t start_flag;

extern volatile int32_t hart_done;
extern volatile int32_t hart1_done;
extern volatile int32_t hart2_done;
extern volatile int32_t hart3_done;
extern volatile int32_t hart4_done;
extern volatile int32_t hart5_done;
extern volatile int32_t hart6_done;
extern volatile int32_t hart7_done;
extern volatile uint32_t hart1_ready_for_initial_sleep;
extern volatile uint32_t hart1_awake_and_worked;
extern volatile uint32_t hart1_sleep_again_request;
extern volatile uint32_t hart1_sleeping_again;

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
void __attribute__((noinline)) wait_for_hart1_done();
void __attribute__((noinline)) wait_for_hart2_done();
void __attribute__((noinline)) wait_for_hart3_done();
void __attribute__((noinline)) wait_for_hart4_done();
void __attribute__((noinline)) wait_for_hart5_done();
void __attribute__((noinline)) wait_for_hart6_done();
void __attribute__((noinline)) wait_for_hart7_done();
void wait_for_all_harts_done();
uint32_t get_mhartid();

#endif
