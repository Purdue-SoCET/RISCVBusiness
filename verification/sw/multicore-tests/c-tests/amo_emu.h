#ifndef AMO_EMU_H
#define AMO_EMU_H

#define WANT_AMO_EMU_SUPPORT                                                                       \
    .globl exception_handler;                                                                      \
    la t0, exception_handler;                                                                      \
    csrw mtvec, t0;

#endif
