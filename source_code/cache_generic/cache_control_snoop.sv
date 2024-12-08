// Module: cache_control_snoop
// Description:
//  control the snoopy bus output base on the read/write hit/miss state transition
// to implement cache coherency among multiple caches of the multicore processor
`include "cache_generic_struct.vh"
`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"

module cache_control_snoop (
    input CLK,
    input nRst,
    input cache_set sramRead,
    input logic sramWEN,
    input logic [N_SET_BITS-1:0] sramSEL,
    output logic [N_SET_BITS-1:0] sramSNOOPSEL,
    input decoded_cache_addr_t snoop_decoded_addr,
    output cache_tag_t sramTags [ASSOC-1:0], 
    output cache_tag_t sramTagsMask [ASSOC-1:0],
    input cache_set_t sramMask,
    input cache_set_t sramWrite,
    input flush_idx_t flush_idx,
    input logic [N_FRAME_BITS-1:0] hit_idx,
    cache_coherence_if.cache ccif
);
    always_ff @(negedge nRst, posedge CLK) begin
        if(!nRst) begin
            ccif.abort_bus <= 0;
        end else begin
            ccif.abort_bus <= !proc_gen_bus_if.ren && !proc_gen_bus_if.wen;
        end
    end

    always_comb begin
        ccif.dWEN               = 1'b0;
        ccif.requested_data     = {BLOCK_SIZE{32'hBAD1BAD1}};
        casez(state_in)
            IDLE: begin end // nothing to do
            HIT: begin end // nothing to do
            FETCH: begin end // nothing to do
            WB: begin
                ccif.dWEN = 1'b1;
            end
            FLUSH_CACHE: begin
                // flush to memory if valid & dirty
                if (sramRead.frames[flush_idx.frame_num].tag.valid && sramRead.frames[flush_idx.frame_num].tag.dirty) begin
                    ccif.dWEN             = 1'b1;
                end
            end
            SNOOP: begin
                ccif.requested_data = sramRead.frames[hit_idx].data;
            end
        endcase

        // Same as sramSEL except try to lookup the snoop addr when there's
        // a request
        sramSNOOPSEL    = sramWEN ? sramSEL
                        : ccif.snoop_req ? snoop_decoded_addr.idx.idx_bits
                        : sramSEL;
        ccif.snoop_busy = sramWEN || !ccif.snoop_req;

        for (int i = 0; i < ASSOC; i++) begin
            sramTags[i] = sramWrite.frames[i].tag;
            sramTagsMask[i] = sramMask.frames[i].tag;
        end
    end
endmodule