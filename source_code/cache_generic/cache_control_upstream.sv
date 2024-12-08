// Module: cache_control_upstream
// Description:
//  control the output signals to the upstream memory (closer to CPU)
// setting the ouputs in prog_gen_bus_if (upstream) from the data sent back from mem_gen_bus_if (downstream)
`include "cache_generic_struct.vh"
`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"

module cache_control_upstream (
    input logic CLK,
    input logic nRST,
    input logic hit,
    input logic flush,
    input logic reserve,
    input logic addr_is_reserved,
    input logic pass_through,
    input logic sc_valid_block,
    input decoded_cache_addr_t decoded_addr,
    input cache_fsm_t state_in,

    generic_bus_if.cpu mem_gen_bus_if,              // bus to downstream memory, to main memory
    generic_bus_if.generic_bus proc_gen_bus_if      // bus to upstream memory, to CPU
);
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            
        end else begin
            
        end
    end
    
    always_comb begin
        proc_gen_bus_if.busy    = 1;
        proc_gen_bus_if.rdata   = 0; // TODO: Can this be optimized?
        casez(state_in) 
            IDLE: begin end // nothing to do
            HIT: begin
                // Case: cache hit on a processor read
                // Do: send the data upstream directly from cache
                if(proc_gen_bus_if.ren && hit && !flush) begin
                    proc_gen_bus_if.busy = 0;
                    proc_gen_bus_if.rdata = hit_data[decoded_addr.idx.block_bits];

                    // Delay so we can set the reservation set
                    // if (reserve && !addr_is_reserved) begin
                    //     proc_gen_bus_if.busy = 1;
                    // end
                end
                // Case: cache hit on a processor write
                // Do: send the busy signal upstream, waiting for writing the data to cache done
                else if(proc_gen_bus_if.wen && hit && (!reserve || (reserve && addr_is_reserved)) && !flush) begin
                    proc_gen_bus_if.busy = 0;   
                    proc_gen_bus_if.rdata = 0;
                end

                // passthrough
                else if(pass_through) begin
                    proc_gen_bus_if.busy    = mem_gen_bus_if.busy;
                    proc_gen_bus_if.rdata   = mem_gen_bus_if.rdata;
                end

                // Cache miss of sc
                else if (proc_gen_bus_if.wen && reserve && !sc_valid_block && ~pass_through) begin
                    proc_gen_bus_if.busy = 0;
                    proc_gen_bus_if.rdata = 32'b1;
                end

                // cache miss on a clean block -> nothing to do (state machine will proceed to fetch)
		        else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].tag.dirty && ~pass_through) begin end
                
                // cache miss on a dirty block -> nothing to do (state machine will proceed to write back before fetching new data)
			    else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].tag.dirty && ~pass_through) begin end
            end
            FETCH: begin end // nothing to do -> once the data is fetched into cache, the state machine proceed to HIT returning data upstream
            WB: begin end // nothing to do upstream
            FLUSH_CACHE: begin end // nothing to do upstream
            SNOOP: begin end // nothing to do upstream
            CANCEL_REQ: begin
                proc_gen_bus_if.busy   = 1;
            end
        endcase
    end
endmodule