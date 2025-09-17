`timescale 1ns / 10ps

module counter64bit (
input logic clk,
input logic n_rst,
input logic enable, //counter enable
input logic [31:0] overwrite_val, //overwrite value, can only overwrite 32 bits of the counter at a time
input logic [1:0] csr_active_sel, // 0 --> not overwriting; 1 --> write to lower 32 bits ; 2 --> write to upper 32 bits
input logic clear, //clear all 64 bits of counter

output logic [63:0] count_out,
output logic rollover_flag
);

localparam LOWERSEL = 2'b01;
localparam UPPERSEL = 2'b10;
localparam MAXCOUNT = 64'hFFFFFFFFFFFFFFFF;

logic [63:0] next_count;
logic next_rollover_flag;

always_ff @(posedge clk, negedge n_rst) begin: COUNT_REG
    if(~n_rst) begin
        count_out <= 64'd0;
        rollover_flag <= 0;
    end
    else begin
        count_out <= next_count;
        rollover_flag <= next_rollover_flag;
    end
end

always_comb begin : COUNT_COMB
    if(clear) begin
        next_count = 64'd0;
        next_rollover_flag = 0;
    end
    else if(csr_active_sel == LOWERSEL) begin
        next_count = {count_out[63:32],overwrite_val};
        next_rollover_flag = 0;
    end
    else if(csr_active_sel == UPPERSEL) begin
        next_count = {overwrite_val,count_out[31:0]};
        next_rollover_flag = 0;
    end
    else if(enable) begin
        if(count_out == MAXCOUNT) begin
            next_rollover_flag = 1;
            next_count = 64'd0;
        end
        else begin
            next_count = count_out + 1;
            next_rollover_flag = 0;
        end
    end
    else begin
        next_rollover_flag = 0;
        next_count = count_out;
    end

end

endmodule
