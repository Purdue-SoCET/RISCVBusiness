// Module: cache_sm
// Description: 
//      cache state machine control the state of the cache consist of
//  IDLE: 
//  HIT: 
//  FETCH: 
//  WB: 
//  SNOOP: 
//  FLUSH_CACHE: 
//  CANCLE_REQ: 
`include "cache_generic_struct.vh"
`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"

module cache_sm  (
    input logic CLK,
    input logic nRST,
    input logic idle_done,
    input logic reserve,
    input logic sc_valid_block,
    input logic pass_through,
    input logic hit,
    input logic sramRead, 
    input logic flush,
    input logic flush_req,
    input logic flush_done, //***

    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus proc_gen_bus_if
    cache_coherence_if.cache ccif,

    output cache_fsm_t state_out;
);

    cache_fsm_t state, next_state;
    assign state_out = state;

    // cache state machine: sequential update
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // next state logic
    always_comb begin
	    next_state = state;
	    casez(state)
            IDLE: begin
                if (idle_done) // Used when flushing
                    next_state = HIT;
	        end
	        HIT: begin
                if (ccif.snoop_hit && !ccif.snoop_busy)
                    next_state = SNOOP;
                else if (proc_gen_bus_if.wen && reserve && !sc_valid_block && ~pass_through) // Don't transition on a failed sc
                    next_state = state;
                else if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].tag.dirty && ~pass_through)
                    next_state = WB;
                else if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].tag.dirty && ~pass_through)
                    next_state = FETCH;
                if (flush || flush_req)  
                    next_state = FLUSH_CACHE;
	        end
	        FETCH: begin
                if (!mem_gen_bus_if.busy || mem_gen_bus_if.error)
                    next_state = HIT; 
                else if (ccif.snoop_hit && !ccif.snoop_busy)
                    next_state = SNOOP;
                else if (!ccif.abort_bus && !proc_gen_bus_if.ren && !proc_gen_bus_if.wen)
                    next_state = CANCEL_REQ;
            end
            WB: begin
                if (!mem_gen_bus_if.busy)
                    next_state = HIT; 
                else if (ccif.snoop_hit && !ccif.snoop_busy)
                    next_state = SNOOP;
            end
            SNOOP: begin
                next_state = ccif.snoop_req ? SNOOP :
                             flush_req      ? FLUSH_CACHE : HIT;
            end
            FLUSH_CACHE: begin
                if (flush_done)
                    next_state = HIT;
                else if (ccif.snoop_hit && !ccif.snoop_busy)
                    next_state = SNOOP;
            end
            CANCEL_REQ: begin
               if (!mem_gen_bus_if.busy) begin
                   next_state = HIT;
               end else if (ccif.snoop_hit && !ccif.snoop_busy) begin
                   next_state = SNOOP;
               end
            end
	    endcase
    end
endmodule