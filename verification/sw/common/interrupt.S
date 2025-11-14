#include "csr.h"

.align 256
.global vector_table
.option push
.option norvc
j exception_handler     // exceptions jump to cause 0
j ssip_handler          // 1
j unreachable_handler   // 2
j msip_handler          // 3

j unreachable_handler   // 4 
j stip_handler          // 5
j unreachable_handler   // 6
j mtip_handler          // 7

j unreachable_handler   // 8
j seip_handler          // 9
j unreachable_handler   // 10
j meip_handler          // 11

j unreachable_handler   // 12
j lcofip_handler        // 13
j unreachable_handler   // 14
j unreachable_handler   // 15
// end of standard interrupts
.option pop
