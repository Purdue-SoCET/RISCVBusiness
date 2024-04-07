OUTPUT_ARCH( "riscv" )
ENTRY(_start);

SECTIONS
{

    . = 0x0000000080000000;
    .text.init : { *(.text.init) }
    .text : { *(.text) }
    .data ALIGN(0x1000) : { *(.data) }
    . = ALIGN(0x4);
    PROVIDE(__bss_start = .);
    .bss :
    {
        *(.sbss .sbss.*)
        *(.bss .bss.*)
    }
    . = ALIGN(0x4);
    PROVIDE(__bss_end = .);
    PROVIDE(__global_pointer$ = .);
}
