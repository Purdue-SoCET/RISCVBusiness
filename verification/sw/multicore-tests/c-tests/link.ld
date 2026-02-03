MEMORY {
    RAM : ORIGIN = 0x80000000, LENGTH = 64K
}

ENTRY(boot);

SECTIONS
{
    .text :
    {
        *(.text.boot)
        *(.text .text.*)
    } > RAM

    .preinit_array :
    {
        PROVIDE(__preinit_array_start = .);
        KEEP(*(SORT_BY_INIT_PRIORITY(.preinit_array)));
        PROVIDE(__preinit_array_end = .);
    } > RAM

    .init_array :
    {
        PROVIDE(__init_array_start = .);
        KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
        KEEP(*(.init_array .ctors));
        PROVIDE(__init_array_end = .);
    } > RAM

    .fini_array :
    {
        PROVIDE(__fini_array_start = .);
        KEEP(*(SORT_BY_INIT_PRIORITY(.fini_array.*) SORT_BY_INIT_PRIORITY(.dtors.*)));
        KEEP(*(.fini_array .dtors));
        PROVIDE(__fini_array_end = .);
    } > RAM

    .data :
    {
        *(.data .data.*)
        *(.rodata .rodata.*)
        *(.sdata .sdata.*)
        *(.eh_frame .eh_frame.*)
    } > RAM

    PROVIDE(_edata = .);

    .noinit :
    {
        *(.noinit .noinit.*)
    } > RAM

    PROVIDE(__bss_start = .);
    .bss :
    {
        *(.sbss .sbss.*)
        *(.bss .bss.*)
    } > RAM
    PROVIDE(__bss_end = .);
    PROVIDE(_end = .);
    PROVIDE(__global_pointer$ = .);
    . = ALIGN(0x400);
    PROVIDE(__heap_start = .);
    PROVIDE(__stack_top = ORIGIN(RAM) + LENGTH(RAM));
}
