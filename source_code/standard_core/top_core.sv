`include "core_interrupt_if.vh"
`include "ahb_if.vh"
`include "generic_bus_if.vh"

module top_core(
    input CLK, nRST,
    output wfi, halt,
    // core_interrupt_if
    input ext_int, ext_int_clear,
    input soft_int, soft_int_clear,
    input timer_int, timer_int_clear,
    // generic bus if case
    `ifdef BUS_INTERFACE_GENERIC_BUS
    input busy,
    input [31:0] rdata,
    output ren, wen,
    output [3:0] byte_en,
    output [31:0] addr, wdata
    // ahb if case
    `elsif BUS_INTERFACE_AHB
    // TODO
    `endif
);

    function [31:0] get_x28;
        // verilator public
        get_x28 = CORE.execute_stage_i.REG_FILE_SEL.rf.registers[28];
    endfunction


    core_interrupt_if interrupt_if();
    assign interrupt_if.ext_int = ext_int;
    assign interrupt_if.ext_int_clear = ext_int_clear;
    assign interrupt_if.soft_int = soft_int;
    assign interrupt_if.soft_int_clear = soft_int_clear;
    assign interrupt_if.timer_int = timer_int;
    assign interrupt_if.timer_int_clear = timer_int_clear;

    `ifdef BUS_INTERFACE_GENERIC_BUS
        generic_bus_if gen_bus_if();
        assign gen_bus_if.busy = busy;
        assign gen_bus_if.rdata = rdata;
        assign ren = gen_bus_if.ren;
        assign wen = gen_bus_if.wen;
        assign byte_en = gen_bus_if.byte_en;
        assign addr = gen_bus_if.addr;
        assign wdata = gen_bus_if.wdata;
    `elsif BUS_INTERFACE_AHB
        ahb_if ahb_master();
        // TODO
    `endif


    RISCVBusiness CORE(
        .*
    );

endmodule
