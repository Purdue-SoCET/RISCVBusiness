#ifndef __UTILITY_H__
#define __UTILITY_H__

#include <stdint.h>
#include <stdnoreturn.h>

#define MTIME_ADDR      0xFFFFFFE0
#define MTIMEH_ADDR     0xFFFFFFE4
#define MTIMECMP_ADDR   0xFFFFFFE8
#define MTIMECMPH_ADDR  0xFFFFFFEC
#define MSIP_ADDR       0xFFFFFFF0
#define EXT_ADDR_SET    0xFFFFFFF4
#define EXT_ADDR_CLEAR  0xFFFFFFF8
#define MAGIC_ADDR      0xFFFFFFFC

#define MTIME           (volatile uint32_t *)(MTIME_ADDR)
#define MTIMEH          (volatile uint32_t *)(MTIMEH_ADDR)
#define MTIMECMP        (volatile uint32_t *)(MTIMECMP_ADDR)
#define MTIMECMPH       (volatile uint32_t *)(MTIMECMPH_ADDR)
#define MSIP            (volatile uint32_t *)(MSIP_ADDR)
#define EXT_SET         (volatile uint32_t *)(EXT_ADDR_SET)
#define EXT_CLEAR       (volatile uint32_t *)(EXT_ADDR_CLEAR)
#define MAGIC           (volatile uint32_t *)(MAGIC_ADDR)

#define BIT_TEST(x, n)  (((x) >> n) & 0x1)

extern volatile int flag;
noreturn void done();
void test_pass(const char *msg);
void test_fail(const char *msg);
static inline void ecall() {
    asm volatile("ecall");
}

#endif
