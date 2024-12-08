`include "cache_generic_struct.vh"
`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"

module cache_hit_logic (
    input cache_set sramRead,
    input decoded_cache_addr_t decoded_addr,
    input logic addr_is_reserved,
    input cache_fsm_t state_in,
    input cache_tag_t read_tag_bits,
    input logic[N_TAG_BITS-1:0] bus_frame_tag,
    output logic hit,
    output logic [N_FRAME_BITS-1:0] hit_idx,
    output word_t [BLOCK_SIZE-1:0] hit_data,
    output logic pass_through,
    output logic coherence_hit,
    output logic sc_valid_block,
    generic_bus_if.generic_bus proc_gen_bus_if,
    cache_coherence_if.cache ccif
);
    // Hit logic with pass through
    // CPU and bus sram have different always_comb blocks to prevent false
    // circular logic
    always_comb begin
        hit 	        = 0;
        hit_idx         = 0;
        hit_data        = 0;
        pass_through    = proc_gen_bus_if.addr >= NONCACHE_START_ADDR;
        coherence_hit   = 0;
        sc_valid_block  = 0;

        if (!pass_through) begin
            for(int i = 0; i < ASSOC; i++) begin
                if(sramRead.frames[i].tag.tag_bits == decoded_addr.idx.tag_bits && sramRead.frames[i].tag.valid) begin
                    sc_valid_block = addr_is_reserved;
                    coherence_hit = sramRead.frames[i].tag.dirty || sramRead.frames[i].tag.exclusive;
                    //Read or write hit: using write back policy, only update cache write
                    if((state == HIT && (proc_gen_bus_if.ren || (proc_gen_bus_if.wen && coherence_hit))) || state == SNOOP) begin
	                    hit       = 1'b1;
        	            hit_data  = sramRead.frames[i].data;
                	    hit_idx   = i;
                    end
                end
            end
        end
    end

    always_comb begin
        ccif.snoop_hit  = 0;
        ccif.valid = 0;
        ccif.dirty = 0;
        ccif.exclusive = 0;

        for(int i = 0; i < ASSOC; i++) begin
            if (read_tag_bits[i].tag_bits == bus_frame_tag && read_tag_bits[i].valid) begin
                ccif.snoop_hit = 1'b1;
                ccif.valid = read_tag_bits[i].valid;
                ccif.dirty = read_tag_bits[i].dirty;
                ccif.exclusive = read_tag_bits[i].exclusive;
            end
        end
    end
endmodule