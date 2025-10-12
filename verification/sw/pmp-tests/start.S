
.global _start
_start:
    li sp, 0x8000F000
    jal main

.global done
done:
    la x28, flag
    lw x28, 0(x28)
__inf_loop:
    j __inf_loop


.global flag
.data
flag: .word 0xFF
