#ifndef AMO_EMU_H
#define AMO_EMU_H

#define WANT_AMO_EMU_SUPPORT                                                                       \
    .globl __stack_top;                                                                            \
    .globl exception_handler;                                                                      \
    la sp, __stack_top;                                                                            \
    la t0, exception_handler;                                                                      \
    csrw mtvec, t0;

#endif
