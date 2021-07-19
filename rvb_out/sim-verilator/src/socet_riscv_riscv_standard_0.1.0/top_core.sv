`include "core_interrupt_if.vh"
`include "generic_bus_if.vh"
`include "component_selection_defines.vh"

module top_core #(
    parameter logic [31:0] RESET_PC = 32'h80000000
) (
    input CLK,
    nRST,
    input [63:0] mtime,
    output wfi,
    halt,
    // generic bus if case
`ifdef BUS_INTERFACE_GENERIC_BUS
    input busy,
    input [31:0] rdata,
    output ren,
    wen,
    output [3:0] byte_en,
    output [31:0] addr,
    wdata,
    // ahb if case
`elsif BUS_INTERFACE_AHB
    // TODO
`else

`endif
    // core_interrupt_if
    input ext_int,
    ext_int_clear,
    input soft_int,
    soft_int_clear,
    input timer_int,
    timer_int_clear
);


    function [31:0] get_x28;
        // verilator public
        get_x28 = CORE.pipeline.execute_stage_i.g_rfile_select.rf.registers[28];
    endfunction


    bind stage3_mem_stage cpu_tracker cpu_track1 (
        .CLK(CLK),
        .wb_stall(wb_stall),
        .instr(ex_mem_if.ex_mem_reg.instr),
        .pc(ex_mem_if.ex_mem_reg.pc),
        .opcode(rv32i_types_pkg::opcode_t'(ex_mem_if.ex_mem_reg.instr[6:0])),
        .funct3(funct3),
        .funct12(funct12),
        .rs1(ex_mem_if.ex_mem_reg.instr[19:15]),
        .rs2(ex_mem_if.ex_mem_reg.instr[24:20]),
        .rd(ex_mem_if.ex_mem_reg.rd_m),
        .imm_S(ex_mem_if.ex_mem_reg.tracker_signals.imm_S), // TODO: Extract constants. Maybe we could pass these in the pipeline and they'd be removed by synthesis?
        .imm_I(ex_mem_if.ex_mem_reg.tracker_signals.imm_I),
        .imm_U(ex_mem_if.ex_mem_reg.tracker_signals.imm_U),
        .imm_UJ(ex_mem_if.ex_mem_reg.tracker_signals.imm_UJ),
        .imm_SB(ex_mem_if.ex_mem_reg.tracker_signals.imm_SB),
        .instr_30(instr_30)
    );



    core_interrupt_if interrupt_if ();
    assign interrupt_if.ext_int = ext_int;
    assign interrupt_if.ext_int_clear = ext_int_clear;
    assign interrupt_if.soft_int = soft_int;
    assign interrupt_if.soft_int_clear = soft_int_clear;
    assign interrupt_if.timer_int = timer_int;
    assign interrupt_if.timer_int_clear = timer_int_clear;

`ifdef BUS_INTERFACE_GENERIC_BUS
    generic_bus_if gen_bus_if ();
    assign gen_bus_if.busy = busy;
    assign gen_bus_if.rdata = rdata;
    assign ren = gen_bus_if.ren;
    assign wen = gen_bus_if.wen;
    assign byte_en = gen_bus_if.byte_en;
    assign addr = gen_bus_if.addr;
    assign wdata = gen_bus_if.wdata;
`elsif BUS_INTERFACE_AHB
    ahb_if ahb_master ();
    // TODO

`elsif BUS_INTERFACE_APB
    apb_if apb_requester (CLK, nRST);
`else

`endif


    RISCVBusiness #(.RESET_PC(RESET_PC)) CORE (.*);

endmodule
