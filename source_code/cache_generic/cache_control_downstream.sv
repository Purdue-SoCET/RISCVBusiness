// Module: cache_control_downstream
// Description:
//  control the output signals to the downstream memory (closer to main memory)
// setting the outputs to mem_gen_bus_if (downstream) passing instruction from proc_gen_bus_if (upstream)
`include "cache_generic_struct.vh"
`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"

module cache_control_downstream (
    input logic CLK,
    input logic nRST,
    input logic hit,
    input logic flush,
    input logic reserve,
    input logic addr_is_reserved,
    input logic pass_through,
    input logic sc_valid_block,
    input cache_set sramRead,
    input cache_fsm_t state_in,
    input logic [N_FRAME_BITS-1:0] ridx,
    input decoded_cache_addr_t decoded_addr,
    input flush_idx_t flush_idx,
    
    generic_bus_if.cpu mem_gen_bus_if,              // bus to downstream memory, to main memory
    generic_bus_if.generic_bus proc_gen_bus_if,     // bus to upstream memory, to CPU
    cache_coherence_if.cache ccif
);

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            read_addr <= 0;
        end else begin
            read_addr <= next_read_addr;                // cache address to provide to memory
        end
    end
    
    always_comb begin
        mem_gen_bus_if.ren      = 0;
        mem_gen_bus_if.wen      = 0;
        mem_gen_bus_if.addr     = 0; 
        mem_gen_bus_if.wdata    = 0; 
        mem_gen_bus_if.byte_en  = '1; // set this to all 1s for evictions
        next_read_addr          = proc_gen_bus_if.addr & ~{CLEAR_LENGTH{1'b1}};
        casez(state_in) 
            IDLE: // nothing to do downstream
            HIT: begin
                // cache hit on a processor read -> nothing to do
                if(proc_gen_bus_if.ren && hit && !flush) begin end 

                // cache hit on a processor write -> nothing to do
                else if(proc_gen_bus_if.wen && hit && (!reserve || (reserve && addr_is_reserved)) && !flush) begin end
                
                // passthrough (for direct access memory, using the same bus (for output, input straight to CPU))
                else if(pass_through) begin
                    mem_gen_bus_if.wen      = proc_gen_bus_if.wen;      // relay the instruction (write enable) to lower bus
                    mem_gen_bus_if.ren      = proc_gen_bus_if.ren;      // relay the instruction (read enable) to lower bus
                    mem_gen_bus_if.addr     = proc_gen_bus_if.addr;     // relay the instruction (address) to lower bus
                    mem_gen_bus_if.byte_en  = proc_gen_bus_if.byte_en;  // relay the instruction (byte enable) to lower bus
                    if(proc_gen_bus_if.wen) begin   // if it's write instruction
                        casez (proc_gen_bus_if.byte_en) // based on the byte enable, write the data to data line
                            4'b0001:    mem_gen_bus_if.wdata  = {24'd0, proc_gen_bus_if.wdata[7:0]};
                            4'b0010:    mem_gen_bus_if.wdata  = {16'd0,proc_gen_bus_if.wdata[15:8],8'd0};
                            4'b0100:    mem_gen_bus_if.wdata  = {8'd0, proc_gen_bus_if.wdata[23:16], 16'd0};
                            4'b1000:    mem_gen_bus_if.wdata  = {proc_gen_bus_if.wdata[31:24], 24'd0};
                            4'b0011:    mem_gen_bus_if.wdata  = {16'd0, proc_gen_bus_if.wdata[15:0]};
                            4'b1100:    mem_gen_bus_if.wdata  = {proc_gen_bus_if.wdata[31:16],16'd0};
                            default:    mem_gen_bus_if.wdata  = proc_gen_bus_if.wdata;
                        endcase
                    end 
                end

                // Cache miss of sc -> nothin to do (*** what is sc valid block for? coherency?)
                else if (proc_gen_bus_if.wen && reserve && !sc_valid_block && ~pass_through) begin end

                // cache miss on a clean block -> nothing to do (state machine will proceed to fetch)
		        else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].tag.dirty && ~pass_through) begin end
                
                // cache miss on a dirty block -> nothing to do (state machine will proceed to write back before fetching new data)
			    else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].tag.dirty && ~pass_through) begin end
            end
            FETCH: begin
                mem_gen_bus_if.wen = proc_gen_bus_if.wen;   // relay the write enable data instruction from cpu to main memory
                mem_gen_bus_if.ren = proc_gen_bus_if.ren || !ccif.abort_bus;    // relay the read enable to main memory
                mem_gen_bus_if.addr = read_addr;            // relay the address requested to main memory
                // with these, main memory will return the data in the data line which will go to cache sram
                // byte_en will control which bytes in this data got stored in cache sram, be dealt with in sram control module
            end
            WB: begin
                mem_gen_bus_if.wen = 1'b1;  
                mem_gen_bus_if.addr = read_addr; 
                mem_gen_bus_if.wdata = sramRead.frames[ridx].data;
                next_read_addr =  {sramRead.frames[ridx].tag, decoded_addr.idx.idx_bits, N_BLOCK_BITS'('0), 2'b00};
            end
            FLUSH_CACHE: begin
                // flush to memory if valid & dirty
                if (sramRead.frames[flush_idx.frame_num].tag.valid && sramRead.frames[flush_idx.frame_num].tag.dirty) begin
                    mem_gen_bus_if.wen    = 1'b1;
                    mem_gen_bus_if.addr   = {sramRead.frames[flush_idx.frame_num].tag.tag_bits, flush_idx.set_num, {N_BLOCK_BITS{1'b0}}, 2'b00};
                    mem_gen_bus_if.wdata  = sramRead.frames[flush_idx.frame_num].data;
                end
            end
            SNOOP: // nothing to do
            CANCEL_REQ: begin
                mem_gen_bus_if.wen     = 0;
                mem_gen_bus_if.ren     = 1;
                mem_gen_bus_if.addr    = decoded_addr;
                mem_gen_bus_if.byte_en = 0;
            end
        endcase
    end

endmodule