module fetch_buffer
(
    input logic clk,
    input logic n_rst,
    input logic [31:0] inst,
    input logic reset_en,
    input logic [31:0] reset_pc,
    input logic inst_arrived,
    input logic pc_update,
    output logic done,
    output logic [31:0] nextpc,
    output logic [31:0] countread,
    output logic [31:0] result
);
    logic [15:0] buffer, nextbuffer;
    logic [31:0] pc, nextcountread;
    logic combine, combine_reg, loadbuffer, loadbuffer_reg;
    logic [31:0] final_inst_store, final_inst;
    logic reset_en_1, reset_next, finished;

    // Buffer and PC logic
    always_ff @ (posedge clk, negedge n_rst) begin
        if (n_rst == 0) begin
	    buffer <= 16'd0;
	    combine_reg <= 1'b0;
	    loadbuffer_reg <= 1'b0;
	    countread <= 32'h200;
	    pc <= 32'h200;
	    final_inst_store <= 32'd0;
	    reset_next <= 1'b0;
	end else if (reset_en) begin
	    buffer <= nextbuffer;
	    combine_reg <= combine;
	    loadbuffer_reg <= loadbuffer;
	    countread <= nextcountread;
	    pc <= nextpc;
	    final_inst_store <= final_inst;
	    reset_next <= 1'b1;
	end else if (inst_arrived) begin
	    buffer <= nextbuffer;
	    combine_reg <= combine;
	    loadbuffer_reg <= loadbuffer;
	    countread <= nextcountread;
	    pc <= nextpc;
	    final_inst_store <= final_inst;
	    reset_next <= 1'b0;
	end
    end 

    always_comb begin
        nextcountread = countread;
	nextpc = pc;
	nextbuffer = buffer;
	combine = 1'b0;
	loadbuffer = 1'b0;
	final_inst = final_inst_store;
	finished = 1'b0;
	if (inst_arrived & reset_next & (pc != countread)) begin // Handle Jump/Branch Condition when misaligned
	    nextcountread = countread + 4;
	    if (inst[17:16] != 2'b11) begin // upper 16 bits are compressed
	        final_inst = {16'd0, inst[31:16]};
                nextpc = pc + 2;
		finished = 1'b1;
    	    end else begin
		combine = 1;
		nextbuffer = inst[31:16];
                nextpc = pc + 4;
		finished = 1'b0;
	    end
	end else if (reset_en) begin
	    nextcountread = {reset_pc[31:2], 2'b0}; // Always aligned
	    nextpc = reset_pc; // Can be misaligned
	    nextbuffer = 16'd0;
	    final_inst = 32'd0;
	end else if (inst_arrived & combine_reg) begin
	    final_inst = {inst[15:0], buffer};
	    nextbuffer = inst[31:16];
	    nextpc = pc + 4;
	    finished = 1'b1;
	    if (inst[17:16] != 2'b11) begin // upper 16 bits are compressed
	        loadbuffer = 1;
	        nextcountread = countread;
    	    end else begin
		combine = 1;
		nextcountread = countread + 4;
	    end
        end else if (inst_arrived & loadbuffer_reg) begin
            final_inst = {16'b0, buffer};
	    finished = 1'b1;
	    nextpc = pc + 2;
	    nextcountread = countread + 4;
	end else if (inst[1:0] != 2'b11) begin // lower 16 bits are compressed
	    final_inst = inst[15:0];
	    nextbuffer = inst[31:16];
            nextpc = pc + 2;
	    finished = 1'b1;
	    if (inst[17:16] != 2'b11) begin // upper 16 bits are compressed
	        loadbuffer = 1;
		nextcountread = countread;
	    end else begin
		combine = 1;
		nextcountread = countread + 4;
	    end
        end else if (inst[1:0] == 2'b11) begin
	    final_inst = inst;
	    nextcountread = countread + 4;
	    nextpc = pc + 4;
	    finished = 1'b1;
	end
    end

    assign result = inst_arrived ? final_inst : final_inst_store;
    //assign c_ena = result[1:0] != 2'b11;
    assign done = inst_arrived & finished;

endmodule

