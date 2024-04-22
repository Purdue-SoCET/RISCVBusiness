
.global _start
_start:
    lui sp, 0x8000F
    addi sp, sp, 0x000
    j thread1
    lui sp, 0x800F0
    addi sp, sp, 0x088
    j interrupt_thread
    # lui sp, 0x80F00
    # addi sp, sp, 0x044
    # j thread3

.global done
done:
    la x28, flag
    lw x28, 0(x28)
__inf_loop:
    j __inf_loop

.global thread_wait_loop
thread_wait_loop:
    nop
    j thread_wait_loop

.global flag
.data
flag: .word 0x1
.global t_count
t_count: .word 0x00
