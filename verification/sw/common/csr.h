#ifndef _CSR_H_
#define _CSR_H_

#include <stdint.h>
#include <stdbool.h>
#include <stdnoreturn.h>

// Read CSR
#define CSRR(csr) ({ \
    uint32_t __value; \
    __asm__ volatile("csrr %0, " csr : "=r"(__value)); \
    __value; \
})

// Write CSR
#define CSRW(csr, val) \
    __asm__ volatile("csrw " csr ", %0" : : "r"(val))

// Read and Write CSR (atomic swap)
#define CSRRW(csr, val) ({ \
    uint32_t __value; \
    __asm__ volatile("csrrw %0, " csr ", %1" : "=r"(__value) : "r"(val)); \
    __value; \
})

// Set bits in CSR
#define CSRS(csr, val) \
    __asm__ volatile("csrs " csr ", %0" : : "r"(val))

// Read and Set bits in CSR
#define CSRRS(csr, val) ({ \
    uint32_t __value; \
    __asm__ volatile("csrrs %0, " csr ", %1" : "=r"(__value) : "r"(val)); \
    __value; \
})

// Clear bits in CSR
#define CSRC(csr, val) \
    __asm__ volatile("csrc " csr ", %0" : : "r"(val))

// Read and Clear bits in CSR
#define CSRRC(csr, val) ({ \
    uint32_t __value; \
    __asm__ volatile("csrrc %0, " csr ", %1" : "=r"(__value) : "r"(val)); \
    __value; \
})

// Immediate variants (for 5-bit unsigned immediates)
#define CSRWI(csr, imm) \
    __asm__ volatile("csrwi " csr ", %0" : : "i"(imm))

#define CSRSI(csr, imm) \
    __asm__ volatile("csrsi " csr ", %0" : : "i"(imm))

#define CSRCI(csr, imm) \
    __asm__ volatile("csrci " csr ", %0" : : "i"(imm))

#define CSRRWI(csr, imm) ({ \
    uint32_t __value; \
    __asm__ volatile("csrrwi %0, " csr ", %1" : "=r"(__value) : "i"(imm)); \
    __value; \
})

#define CSRRSI(csr, imm) ({ \
    uint32_t __value; \
    __asm__ volatile("csrrsi %0, " csr ", %1" : "=r"(__value) : "i"(imm)); \
    __value; \
})

#define CSRRCI(csr, imm) ({ \
    uint32_t __value; \
    __asm__ volatile("csrrci %0, " csr ", %1" : "=r"(__value) : "i"(imm)); \
    __value; \
})


typedef enum {
    EX_MAL_INSN     = 0,
    EX_FAULT_INSN   = 1,
    EX_ILLEGAL      = 2,
    EX_BKPT         = 3,
    EX_MAL_LOAD     = 4,
    EX_FAULT_LOAD   = 5,
    EX_MAL_STORE    = 6,
    EX_FAULT_STORE  = 7,
    EX_ECALL_UMODE  = 8,
    EX_ECALL_SMODE  = 9,
    // No cause 10
    EX_ECALL_MMODE  = 11,
    EX_INSN_PAGEFAULT = 12,
    EX_LOAD_PAGEFAULT = 13,
    // No cause 14
    EX_STORE_PAGEFAULT = 15,
    EX_DOUBLE_TRAP  = 16,
    // No cause 17
    EX_SOFTWARE_CHECK = 18,
    EX_HARDWARE_ERROR = 19,
    INT_SSIP = 1 | (1 << 31),
    INT_MSIP = 3 | (1 << 31),
    INT_STIP = 5 | (1 << 31),
    INT_MTIP = 7 | (1 << 31),
    INT_SEIP = 9 | (1 << 31),
    INT_MEIP = 11 | (1 << 31),
    INT_LCOFIP = 13 | (1 << 31)
} mcause_t;

// TODO: Give own enum with only its legal values
typedef mcause_t scause_t;

typedef enum {
    IE_SSIE = (1 << 1),
    IE_MSIE = (1 << 3),
    IE_STIE = (1 << 5),
    IE_MTIE = (1 << 7),
    IE_SEIE = (1 << 9),
    IE_MEIE = (1 << 11),
    IE_LCOFIE = (1 << 13)
} mie_t;

// TODO: Add rest as needed
typedef enum {
    MSTATUS_SIE = (1 << 1),
    MSTATUS_MIE = (1 << 3),
    MSTATUS_SPIE = (1 << 5),
    MSTATUS_MPIE = (1 << 7),
    MSTATUS_SPP = (1 << 8),
    MSTATUS_MPP = (0b11 << 11),
} mstatus_fields_t;

typedef enum {
    SSTATUS_SIE = (1 << 1),
    SSTATUS_SPIE = (1 << 5),
    SSTATUS_SPP = (0b1 << 8)
} sstatus_fields_t;

typedef struct {
    uint32_t epc;
    uint32_t tval;
    uint32_t cause;
    uint32_t cycle;
    uint32_t time;
    uint32_t icache_misses;
    uint32_t dcache_misses;
} exception_context_t;

// Interrupt functions
extern uint32_t vector_table[] __attribute__((aligned(256)));
void default_handler()   __attribute__((interrupt)) __attribute__((aligned(4)));
void exception_handler() __attribute__((interrupt)) __attribute__((aligned(4)));
void ssip_handler()      __attribute__((interrupt)) __attribute__((aligned(4)));
void msip_handler()      __attribute__((interrupt)) __attribute__((aligned(4)));
void stip_handler()      __attribute__((interrupt)) __attribute__((aligned(4)));
void mtip_handler()      __attribute__((interrupt)) __attribute__((aligned(4)));
void seip_handler()      __attribute__((interrupt)) __attribute__((aligned(4)));
void meip_handler()      __attribute__((interrupt)) __attribute__((aligned(4)));
void lcofip_handler()    __attribute__((interrupt)) __attribute__((aligned(4)));
noreturn void unreachable_handler();

void read_exception_context(exception_context_t *);
void read_exception_context_s(exception_context_t*);
void print_exception_context(exception_context_t *);

void advance_mepc(uint32_t by);
void set_mepc(void *address);
void advance_sepc(uint32_t by);
void set_sepc(void *address);
void setup_interrupts_m(void *handler_addr, uint32_t mie_value);
void setup_interrupt_m_vectored(void *table_addr, uint32_t mie_value);

void enable_interrupts_m();
void disable_interrupts_m();
void enable_interrupts_save_m(uint32_t restore);
uint32_t disable_interrupts_save_m();

bool check_supervisor_mode_available();
void require_supervisor_mode();

#endif
