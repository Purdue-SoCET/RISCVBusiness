`include "fetch_buffer_if.vh"
module fetch_buffer
# (
    parameter RESET_PC = 32'h200
)
(
    input logic clk, n_rst,
    fetch_buffer.fb fb_if
);
    logic [15:0] buffer, nextbuffer;
    logic [31:0] pc, next_imem_pc;
    logic combine, combine_reg, waitnext, waitnext_reg;
    logic [31:0] final_inst_store, final_inst;
    logic reset_next, finished;
    logic inst_arrived_delay;

    always_ff @ (posedge clk, negedge n_rst) begin
        if (n_rst == 0) inst_arrived_delay <= 1'b0;
	else inst_arrived_delay <= fb_if.inst_arrived;
    end


    assign fb_if.done_earlier = inst_arrived_delay & waitnext_reg & !fb_if.ex_busy;
    //assign fb_if.done_earlier = 0;

    // Buffer and PC logic
    always_ff @ (posedge clk, negedge n_rst) begin
        if (n_rst == 0) begin
	    buffer <= 16'd0;
	    combine_reg <= 1'b0;
	    waitnext_reg <= 1'b0;
	    fb_if.imem_pc <= RESET_PC;
	    pc <= RESET_PC;
	    final_inst_store <= 32'd0;
	    reset_next <= 1'b0;
	end else if (fb_if.reset_en) begin
	    buffer <= nextbuffer;
	    combine_reg <= combine;
	    waitnext_reg <= waitnext;
	    fb_if.imem_pc <= next_imem_pc;
	    pc <= fb_if.nextpc;
	    final_inst_store <= final_inst;
	    reset_next <= 1'b1;
	end else if (fb_if.inst_arrived | fb_if.done_earlier) begin
	    buffer <= nextbuffer;
	    combine_reg <= combine;
	    waitnext_reg <= waitnext;
	    fb_if.imem_pc <= next_imem_pc;
	    pc <= fb_if.nextpc;
	    final_inst_store <= final_inst;
	    reset_next <= 1'b0;
	end
    end 

    always_comb begin
        next_imem_pc = fb_if.imem_pc;
	fb_if.nextpc = pc;
	nextbuffer = buffer;
	combine = 1'b0;
	waitnext = 1'b0;
	final_inst = final_inst_store;
	finished = 1'b0;
	if (fb_if.inst_arrived & reset_next & (pc != fb_if.imem_pc)) begin // Handle Jump/Branch Condition when misaligned
	    next_imem_pc = fb_if.imem_pc + 4;
	    if (fb_if.inst[17:16] != 2'b11) begin // upper 16 bits are compressed
	        final_inst = {16'd0, fb_if.inst[31:16]};
                fb_if.nextpc = pc + 2;
		finished = 1'b1;
    	    end else begin
		combine = 1;
		nextbuffer = fb_if.inst[31:16];
//              nextpc = pc + 4;
		finished = 1'b0;
	    end
	end else if (fb_if.reset_en) begin
	    next_imem_pc = {fb_if.reset_pc[31:2], 2'b0}; // Always aligned
	    fb_if.nextpc = fb_if.reset_pc; // Can be misaligned
	    nextbuffer = 16'd0;
	    final_inst = 32'd0;
	end else if (fb_if.inst_arrived & combine_reg) begin
	    final_inst = {fb_if.inst[15:0], buffer};
	    nextbuffer = fb_if.inst[31:16];
	    fb_if.nextpc = pc + 4;
	    finished = 1'b1;
	    if (fb_if.inst[17:16] != 2'b11) begin // upper 16 bits are compressed
	        waitnext = 1;
	        next_imem_pc = fb_if.imem_pc;
    	    end else begin
		combine = 1;
		next_imem_pc = fb_if.imem_pc + 4;
	    end
        end else if (fb_if.done_earlier | (fb_if.inst_arrived & waitnext_reg)) begin
            final_inst = {16'b0, buffer};
	    finished = 1'b1;
	    fb_if.nextpc = pc + 2;
	    next_imem_pc = fb_if.imem_pc + 4;
	end else if (fb_if.inst[1:0] != 2'b11) begin // lower 16 bits are compressed
	    final_inst = fb_if.inst[15:0];
	    nextbuffer = fb_if.inst[31:16];
            fb_if.nextpc = pc + 2;
	    finished = 1'b1;
	    if (fb_if.inst[17:16] != 2'b11) begin // upper 16 bits are compressed
	        waitnext = 1;
		next_imem_pc = fb_if.imem_pc;
	    end else begin
		combine = 1;
		next_imem_pc = fb_if.imem_pc + 4;
	    end
        end else if (fb_if.inst[1:0] == 2'b11) begin
	    final_inst = fb_if.inst;
	    next_imem_pc = fb_if.imem_pc + 4;
	    fb_if.nextpc = pc + 4;
	    finished = 1'b1;
	end
    end

    //logic [31:0] debug;
    assign fb_if.result = final_inst;
    //assign debug = fb_if.inst_arrived ? final_inst : final_inst_store;
    //assign c_ena = fb_if.result[1:0] != 2'b11;
    assign fb_if.done = fb_if.inst_arrived & finished;

endmodule
