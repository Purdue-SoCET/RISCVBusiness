module flex_counter_mul #(
    parameter NUM_CNT_BITS = 4
) (
    input wire clk,
    input wire n_rst,
    input wire clear,
    input wire count_enable,
    input reg [(NUM_CNT_BITS-1):0] rollover_val,
    output reg [(NUM_CNT_BITS-1):0] count_out,
    output reg rollover_flag
);

    reg [(NUM_CNT_BITS-1):0] next_count;
    reg next_flag;
    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 0) begin
            count_out <= '0;
            rollover_flag <= 1'b0;
        end else begin
            count_out <= next_count;
            rollover_flag <= next_flag;
        end
    end

    always_comb begin
        if (clear == 1) next_flag = 0;
        else if (count_enable == 0) next_flag = rollover_flag;
        else if (count_out == (rollover_val - 1) & clear == 1'b0) next_flag = 1;
        else next_flag = 0;


        if (clear) next_count = 0;
        else if (count_enable) begin
            if (count_out == rollover_val) next_count = 1;
            else next_count = count_out + 1;
        end else next_count = count_out;
    end
endmodule
