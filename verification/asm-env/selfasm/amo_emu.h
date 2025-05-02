#ifndef AMO_EMU_H
#define AMO_EMU_H

#define WANT_AMO_EMU_SUPPORT                                                                       \
    .globl __stack_top;                                                                            \
    .globl exception_handler;                                                                      \
    csrr s0, mhartid;                                                                              \
    la sp, __stack_top;                                                                            \
    slli t0, s0, 11;                                                                               \
    add sp, sp, t0;                                                                                \
    la t0, exception_handler;                                                                      \
    csrw mtvec, t0;

#endif
