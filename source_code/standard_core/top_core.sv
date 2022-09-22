`include "core_interrupt_if.vh"
`include "generic_bus_if.vh"

module top_core #(
    parameter logic [31:0] RESET_PC = 32'h80000000
) (
    input CLK,
    nRST,
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
        get_x28 = CORE.execute_stage_i.g_rfile_select.rf.registers[28];
    endfunction

    /*
    bind tspp_execute_stage cpu_tracker cpu_track1 (
        .CLK(CLK),
        .wb_stall(wb_stall),
        .instr(fetch_ex_if.fetch_ex_reg.instr),
        .pc(fetch_ex_if.fetch_ex_reg.pc),
        .opcode(cu_if.opcode),
        .funct3(funct3),
        .funct12(funct12),
        .rs1(rf_if.rs1),
        .rs2(rf_if.rs2),
        .rd(rf_if.rd),
        .imm_S(cu_if.imm_S),
        .imm_I(cu_if.imm_I),
        .imm_U(cu_if.imm_U),
        .imm_UJ(imm_UJ_ext),
        .imm_SB(cu_if.imm_SB),
        .instr_30(instr_30)
    );*/



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
`endif


    RISCVBusiness #(.RESET_PC(RESET_PC)) CORE (.*);

endmodule
