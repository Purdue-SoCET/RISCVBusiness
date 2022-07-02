`ifndef CORE_INTERRUPT_IF
`define CORE_INTERRUPT_IF

interface core_interrupt_if ();
    logic ext_int, ext_int_clear;
    logic soft_int, soft_int_clear;
    logic timer_int, timer_int_clear;

    modport core(
        input ext_int, soft_int, timer_int,
              ext_int_clear, soft_int_clear, timer_int_clear
    );

    modport plic(
        output ext_int, ext_int_clear
    );

    modport clint(
        output soft_int_clear, timer_int_clear,
               soft_int, timer_int
    );

endinterface


`endif
