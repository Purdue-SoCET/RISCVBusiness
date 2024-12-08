// Module: cache_flush_counter_handler
// Description:
//  Handle the cache flush counter including
// - taking flush signal
// - keep track of the flush, next_flush counter
// - updating the flush_clear, flush_done logic
`include "cache_generic_struct.vh"
`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"

module cache_flush_counter_handler (
    input logic CLK,
    input logic nRST,
    input logic flush,
    input logic flush_done,
    input logic clear_flush_count,
    input logic enable_flush_count,
    input logic enable_flush_count_nowb,
    output logic flush_req,
    output flush_idx_t flush_idx_out
);
    flush_idx_t flush_idx, next_flush_idx;
    logic nflush_req;
    assign flush_idx_out = flush_idx;

    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            flush_idx <= 0;
            flush_req <= 0;
        end else begin
            flush_idx <= next_flush_idx;    // index for flushing the cache entries
            flush_req <= nflush_req;        // flush requested by core
        end
    end
    // counters
    always_comb begin
        next_flush_idx = flush_idx;

        // flush counter logic
        if (clear_flush_count)
            next_flush_idx = 0;
        else if (enable_flush_count_nowb && BLOCK_SIZE != 1)
            next_flush_idx = flush_idx + 1;
        else if (enable_flush_count || enable_flush_count_nowb)
            next_flush_idx = flush_idx + 1;

        // correction for non-powers of 2
        if (next_flush_idx.set_num == N_SETS) begin
            next_flush_idx.finish = 1;
            next_flush_idx.set_num = 0;
            next_flush_idx.frame_num = 0;
        end
        else if (next_flush_idx.frame_num == ASSOC) begin
            next_flush_idx.set_num = flush_idx.set_num + 1;
            next_flush_idx.frame_num = 0;
        end

        // FOR ASSOC == 1 FINISH FLAG
        if (next_flush_idx.set_num == 0 && flush_idx.set_num == N_SETS - 1) begin
            next_flush_idx.finish = 1;
            next_flush_idx.set_num = 0;
            next_flush_idx.frame_num = 0;
        end

        // flush saver
        nflush_req = flush_req;
        if (flush)
            nflush_req = 1;
        if (flush_done)
            nflush_req = 0;
    end

endmodule