// Module: cache_control_sram
// Description:
//  control the output signals to the actual sram, module that implements this cache
// The sram that we instantiate consist of the **CPU_SRAM (data + overhead) and **BUS_SRAM (overhead)
// The main signals are sramWE, sramRead, sramWrite, sramMask 
//
// -----------Notice------------
//  **CPU_SRAM and BUS_SRAM naming seems to be misleading implying it connected to CPU and BUS to somewhere. Idk why either
`include "cache_generic_struct.vh"
`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"

module cache_control_sram(
    input logic CLK,
    input logic nRST,
    input logic hit,
    input logic [N_FRAME_BITS-1:0] hit_idx,
    // input word_t [BLOCK_SIZE-1:0] hit_data,
    input logic flush,
    input logic reserve,
    input logic addr_is_reserved,
    input cache_fsm_t state_in,
    input flush_idx_t flush_idx,
    input decoded_cache_addr_t snoop_decoded_addr,
    output decoded_cache_addr_t decoded_addr,

    input cache_set_t sramRead,  
    output logic sramWEN,
    output cache_set_t sramWrite,                              
    output cache_set_t sramMask,  
    
    output logic enable_flush_count,
    output logic enable_flush_count_nowb,
    output logic idle_done,
    output logic clear_done,
    output logic flush_done,
    output logic clear_flush_count,

    output logic [N_FRAME_BITS-1:0] ridx,
    generic_bus_if.cpu mem_gen_bus_if,              // bus to downstream memory, to main memory
    generic_bus_if.generic_bus proc_gen_bus_if,     // bus to upstream memory, to CPU
    cache_coherence_if.cache ccif
);
    decoded_cache_addr_t decoded_req_addr, next_decoded_req_addr;

    // replacement policy LRU logic
    logic [N_SETS-1:0] last_used;
    logic [N_SETS-1:0] next_last_used;

    always @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            decoded_req_addr <= 0;
            last_used <= 0;
        end else begin
            decoded_req_addr <= next_decoded_req_addr;  // cache address requested by core
            last_used <= next_last_used;                // MRU index
        end
    end

    // decoded address conversion
    assign decoded_addr = state == SNOOP ? snoop_decoded_addr : decoded_cache_addr_t'(proc_gen_bus_if.addr);

    always_comb begin
        sramWEN     = 0;    // default sramWEN zero, only allow to write (one) when receiving instruction
        sramWrite   = 0;    // default sramWrite zero, only modify the write data (data) when receiving instruction
        sramMask    = '1;   // default sramMask 'one, masking all the bit, only modify some bits to zero when receiving instruction
        enable_flush_count      = 0;
        enable_flush_count_nowb = 0;
        idle_done               = 0;
        clear_done 	            = 0;
        flush_done 	            = 0;
        clear_flush_count       = 0;
        next_decoded_req_addr   = decoded_req_addr;
        next_last_used          = last_used;

        // associativity, using NRU
        if (ASSOC == 1 || (last_used[decoded_addr.idx.idx_bits] == (ASSOC - 1))) begin
            ridx = 0;
        end else begin
            ridx = last_used[decoded_addr.idx.idx_bits] + 1;
        end

        casez(state_in) 
            IDLE: begin
                // Case: At the beginning of all operation
                // Do: clear out caches with flushing, but no write back require (basically set all frames in cache to zeros)
                sramWEN = 1;                                    // enable to write to sram
    	        sramWrite.frames[flush_idx.frame_num] = '0;     // sram write set the data wVal in cache to zeros
                sramMask.frames[flush_idx.frame_num] = '0;      // sram mask set to zero so it doesn't mask out any byte
                enable_flush_count_nowb = 1;                    // remain high until all frames are flushed

                // Case: Done with flushing at the beginning
                // Do: set the flush completion flag high, proceeding the cache state machine to HIT
                if (flush_idx.finish) begin
                    clear_flush_count  = 1;                     // clear_flush_count clears the flush_idx (counter) to zero
                    idle_done 	       = 1;                     // idle_done will proceed cache state machine to HIT state
                    flush_done = 1;                             // output signal for cache ***HACK: Remove if this causes bugs, used for testbench
                end
            end
            HIT: begin
                // Case: cache hit on a processor read
                // Do: update last used index, the cache hit return data is a combinational hit_data which is dealt with in upstream control
                if(proc_gen_bus_if.ren && hit && !flush) begin 
                    next_last_used[decoded_addr.idx.idx_bits] = hit_idx;
                end
                
                // Case: cache hit on a processor write
                // Do: write the data to the cache sram
                else if(proc_gen_bus_if.wen && hit && (!reserve || (reserve && addr_is_reserved)) && !flush) begin
                    sramWEN = 1;    // enable the sram write signal

                    // set the sram Mask based on the byte_en signal
                    casez (proc_gen_bus_if.byte_en)
                        4'b0001:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'hFFFFFF00;
                        4'b0010:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'hFFFF00FF;
                        4'b0100:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'hFF00FFFF;
                        4'b1000:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'h00FFFFFF;
                        4'b0011:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'hFFFF0000;
                        4'b1100:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'h0000FFFF;
                        default:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'h0;
                    endcase
                    // set the cache tag within the cache sram to be dirty
                    sramWrite.frames[hit_idx].data[decoded_addr.idx.block_bits] = proc_gen_bus_if.wdata;
                    sramWrite.frames[hit_idx].tag.dirty = 1;        // the data dirty since it is not written-back to main memory yet
                    sramWrite.frames[hit_idx].tag.exclusive = 0;    // Set exclusive bit in tag to 0, E -> M case
                    sramMask.frames[hit_idx].tag.dirty = 0;         // set the dirty bit mask to zero, allowing the status update in sram
                    sramMask.frames[hit_idx].tag.exclusive = 0;     // set the exclusive bit mask to zero, allowing the status update in sram
                    next_last_used[decoded_addr.idx.idx_bits] = hit_idx;    //***********
                end

                // Case: passthrough
                // Do: nothing
                else if(pass_through) begin end
                
                // Case: Cache miss of sc
                // Do: nothing
                else if (proc_gen_bus_if.wen && reserve && !sc_valid_block && ~pass_through) begin end
                
                // Case: cache miss on a clean block
                // Do: nothing
		        else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].tag.dirty && ~pass_through) begin 
                    next_decoded_req_addr = decoded_addr;
                end
                
                // Case: cache miss on a dirty block
                // DO: nothing
			    else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].tag.dirty && ~pass_through) begin 
                    next_decoded_req_addr = decoded_addr;
                    next_read_addr        =  {sramRead.frames[ridx].tag, decoded_addr.idx.idx_bits, N_BLOCK_BITS'('0), 2'b00};
                end
            end
            FETCH: begin
                // Set the cache valid status to zero, until the cache is done fetching
                sramWrite.frames[ridx].tag.valid = 0;   // set the cache valid bit to zero
                sramMask.frames[ridx].tag.valid = 0;    // set the mask at valid bit zero, allowing the sram valid bit to be updated
                
                // Fill in data
                if(~mem_gen_bus_if.busy) begin  // can fill the data when the main memory is not busy
                    // Fill in the data from the main memory to cache
                    sramWEN                             = 1'b1;                             // enable writing to cache sram
                    sramWrite.frames[ridx].data         = mem_gen_bus_if.rdata;             // set the data to what returns from main memory bus
                    sramWrite.frames[ridx].tag.valid    = 1'b1;                             // set the valid bit value, meaning data is fetched, not the preexisting data
                    sramWrite.frames[ridx].tag.tag_bits = decoded_req_addr.idx.tag_bits;    // set the tage bit value to match with the main memory address
                    sramMask.frames[ridx].data          = 1'b0;     // unmask to allow updating data value in sram (** shouldn't this be the size of data)
                    sramMask.frames[ridx].tag.valid     = 1'b0;     // unmask to allow updating valid bit value in sram     
                    sramMask.frames[ridx].tag.tag_bits  = 1'b0;     // unmask to allow updating tag bit value in sram

                    // These below parts, I don't know yet what they do
                    sramWrite.frames[ridx].tag.exclusive = (ccif.state_transfer == EXCLUSIVE);
                    sramWrite.frames[ridx].tag.dirty = (ccif.state_transfer == MODIFIED);
                    sramMask.frames[ridx].tag.exclusive = 0;
                    sramMask.frames[ridx].tag.dirty = 0;

                    // Fill in the data from the CPU write request to cache 
                    /* 
                        *** shouldn't there be a way to make the process a state-machine specific, eg. after fetching, 
                        go back to the hit state and then write on write hit, so that we don't write duplicate module
                        like the below line is similar to write on write hit in hit state above ????
                    */

                    // Fetched to write, the CPU will also send a write-enable signal
                    if (proc_gen_bus_if.wen) begin  
                        casez (proc_gen_bus_if.byte_en) // based on the byte_en, select
                            4'b0001:    sramWrite.frames[ridx].data[decoded_addr.idx.block_bits][7:0] = proc_gen_bus_if.wdata[7:0];
                            4'b0010:    sramWrite.frames[ridx].data[decoded_addr.idx.block_bits][15:8] = proc_gen_bus_if.wdata[15:8];
                            4'b0100:    sramWrite.frames[ridx].data[decoded_addr.idx.block_bits][23:16] = proc_gen_bus_if.wdata[23:16];
                            4'b1000:    sramWrite.frames[ridx].data[decoded_addr.idx.block_bits][31:24] = proc_gen_bus_if.wdata[31:24];
                            4'b0011:    sramWrite.frames[ridx].data[decoded_addr.idx.block_bits][15:0] = proc_gen_bus_if.wdata[15:0];
                            4'b1100:    sramWrite.frames[ridx].data[decoded_addr.idx.block_bits][31:16] = proc_gen_bus_if.wdata[31:16];
                            default:    sramWrite.frames[ridx].data[decoded_addr.idx.block_bits] = proc_gen_bus_if.wdata;
                        endcase
                    end
                end
            end
            WB: begin
                // increment eviction word counter
                if(!mem_gen_bus_if.busy) begin
                    // invalidate when eviction is complete
                    sramWEN = 1;
                    sramWrite.frames[ridx].tag.dirty = 0;
                    sramWrite.frames[ridx].tag.valid = 0;
                    sramMask.frames[ridx].tag.dirty  = 0;
                    sramMask.frames[ridx].tag.valid  = 0;
                end
            end
            FLUSH_CACHE: begin
                // flush to memory if valid & dirty
                if (sramRead.frames[flush_idx.frame_num].tag.valid && sramRead.frames[flush_idx.frame_num].tag.dirty) begin
                    if (~mem_gen_bus_if.busy) begin
                        enable_flush_count = 1;
                        // clears entry when flushed
                        sramWEN = 1;
                        sramWrite.frames[flush_idx.frame_num] = 0;
                        sramMask.frames[flush_idx.frame_num] = 0;
                    end
                end
                // else clears entry, moves to next frame
                else begin
                    sramWEN = 1;
	    	        sramWrite.frames[flush_idx.frame_num] = 0;
                    sramMask.frames[flush_idx.frame_num] = 0;
                    enable_flush_count_nowb = 1;
                end
                // flag the completion of flush
                if (flush_idx.finish) begin
                    clear_flush_count  = 1;
                    flush_done 	       = 1;
                end
            end
            SNOOP: begin
                if (!mem_gen_bus_if.busy) begin
                    sramWEN = 1;
                    case(ccif.state_transfer)
                        INVALID: begin
                            sramWrite.frames[hit_idx].tag.dirty     = 0;
                            sramWrite.frames[hit_idx].tag.valid     = 0;
                            sramWrite.frames[hit_idx].tag.exclusive = 0;
                            sramMask.frames[hit_idx].tag.dirty         = 0;
                            sramMask.frames[hit_idx].tag.valid         = 0;
                            sramMask.frames[hit_idx].tag.exclusive     = 0;
                        end 
                        SHARED: begin
                            sramWrite.frames[hit_idx].tag.dirty     = 0;
                            sramWrite.frames[hit_idx].tag.valid     = 1;
                            sramWrite.frames[hit_idx].tag.exclusive = 0;
                            sramMask.frames[hit_idx].tag.dirty      = 0;
                            sramMask.frames[hit_idx].tag.valid      = 0;
                            sramMask.frames[hit_idx].tag.exclusive  = 0;
                        end 
                        EXCLUSIVE: begin
                            sramWrite.frames[hit_idx].tag.dirty     = 0;
                            sramWrite.frames[hit_idx].tag.valid     = 1;
                            sramWrite.frames[hit_idx].tag.exclusive = 1;
                            sramMask.frames[hit_idx].tag.dirty      = 0;
                            sramMask.frames[hit_idx].tag.valid      = 0;
                            sramMask.frames[hit_idx].tag.exclusive  = 0;
                        end 
                        MODIFIED: begin
                            sramWrite.frames[hit_idx].tag.dirty     = 1;
                            sramWrite.frames[hit_idx].tag.valid     = 1;
                            sramWrite.frames[hit_idx].tag.exclusive = 0;
                            sramMask.frames[hit_idx].tag.dirty      = 0;
                            sramMask.frames[hit_idx].tag.valid      = 0;
                            sramMask.frames[hit_idx].tag.exclusive  = 0;
                        end 
                    endcase
                end
            end
            CANCEL_REQ: begin end// nothing to do with sram cache
        endcase

    end
endmodule