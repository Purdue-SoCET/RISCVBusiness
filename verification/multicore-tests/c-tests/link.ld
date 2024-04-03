OUTPUT_ARCH( "riscv" )
ENTRY(_start)

SECTIONS
{
  . = 0x0000000080000000;
  .text.init : { *(.text.init) }
  .text : { *(.text) }
  .data ALIGN(0x1000) : { *(.data) }
  PROVIDE(__bss_start = .);
  .bss :
  {
      *(.sbss .sbss.*)
      *(.bss .bss.*)
  }
  PROVIDE(__bss_end = .);
  . = 0x0000000080007000;
  .statuses : { *(.statuses) }
  _end = .;
}
