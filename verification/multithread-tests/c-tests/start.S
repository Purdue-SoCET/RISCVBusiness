
.global _start
_start:
    li sp, 0x8000F000
    j thread1
    li sp, 0x800F0000
    j thread2
    li sp, 0x80F00000
    j thread3

.global done
done:
    la x28, flag
    lw x28, 0(x28)
__inf_loop:
    j __inf_loop


.global flag
.data
flag: .word 0xFF
