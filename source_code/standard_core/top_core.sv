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
    input error,
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
        get_x28 = CORE.x28;
    endfunction

    bind multicore_wrapper cpu_tracker #(.NUM_HARTS(NUM_HARTS)) cpu_track1 (
        .CLK(CLK),
        .wb_stall(wb_stall),
        .instr(instr),
        .pc(pc),
        .opcode(opcode),
        .funct3(funct3),
        .funct12(funct12),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .imm_S(imm_S), // TODO: Extract constants. Maybe we could pass these in the pipeline and they'd be removed by synthesis?
        .imm_I(imm_I),
        .imm_U(imm_U),
        .imm_UJ(imm_UJ),
        .imm_SB(imm_UJ),
        .instr_30(instr_30),
        .cache_statistics(cache_statistics)
    );

	bind branch_predictor_wrapper branch_tracker branch_track1 (
		.CLK(CLK),
		.nRST(nRST),
		.update_predictor(predict_if.update_predictor),
		.prediction(predict_if.prediction),
		.branch_result(predict_if.branch_result)
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
    assign gen_bus_if.error = error;
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


    multicore_wrapper #(.RESET_PC(RESET_PC), .NUM_HARTS(NUM_HARTS)) CORE (.*);

endmodule
