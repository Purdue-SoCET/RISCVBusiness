`include "generic_bus_if.vh"

module fetch_buffer (
    input logic CLK,
    input logic nRST,
    input logic ren,
    input logic invalidate,
    input logic stall,
    input logic [31:0] pc,
    output logic insn_valid,
    output logic insn_compressed,
    output logic [31:0] insn_out,
    generic_bus_if.cpu icache
);
    // Fetch Buffer
    //
    // transparently allows for misaligned reads
    // of data from the I$
    //
    // Idea: Use PC alignment and FB validity
    // to determine where to fetch.
    
    struct packed {
        logic [15:0] data;
        logic valid;
    } fb, fb_next;

    logic pc_aligned, want_fetch;
    logic [31:0] fetch_addr;

    assign pc_aligned = (pc[1] == 0);


    function automatic logic is_compressed(logic [15:0] chunk);
        return (chunk[1:0] != 2'b11);
    endfunction

    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            fb <= '0;
        end else begin
            fb <= fb_next;
        end
    end

    always_comb begin : FETCH_ADDR
        if(pc_aligned) fetch_addr = pc;
        else if(!pc_aligned && fb.valid) fetch_addr = pc + 2;
        else fetch_addr = {pc[31:2], 2'b00};
    end

    assign want_fetch = pc_aligned || !fb.valid || !is_compressed(fb.data) && fb.valid;

    always_comb begin : BUFFER_UPDATE
        fb_next = fb;
        insn_out = 32'h0; // TODO: better default for less logic
        insn_valid = 1'b0;
        insn_compressed = 1'b0;
        if(invalidate) begin
            fb_next.valid = 1'b0;
        end else if(ren) begin
            // The case pc_aligned && fb.valid is not possible,
            // sufficient to just check this bit. 
            // Additionally, if we somehow get into the bad state,
            // this allows us to recover by always prioritizing I$.
            if(pc_aligned) begin
                if(!icache.busy) begin
                    if(is_compressed(icache.rdata[15:0])) begin
                        insn_out = icache.rdata;
                        insn_compressed = 1'b1;
                        insn_valid = 1'b1;
                        fb_next.valid = 1'b1;
                        fb_next.data = icache.rdata[31:16];
                    end else begin
                        insn_out = icache.rdata;
                        insn_compressed = 1'b0;
                        insn_valid = 1'b1;
                        fb_next.valid = 1'b0;
                    end
                end
            end else if(!pc_aligned && fb.valid) begin
                if(is_compressed(fb.data)) begin
                    insn_out = {16'b0, fb.data};
                    insn_compressed = 1'b1;
                    insn_valid = 1'b1;
                    fb_next.valid = 1'b0;
                end else begin
                    // PC is misaligned, we have half a 32b
                    // insn in FB, need to fetch next word
                    // for rest.
                    if(!icache.busy) begin
                        fb_next.valid = 1'b1;
                        fb_next.data = !stall ? icache.rdata[31:16] : fb.data;
                        insn_out = {icache.rdata[15:0], fb.data};
                        insn_compressed = 1'b0;
                        insn_valid = 1'b1;
                    end
                end
            end else begin
                // !pc_aligned && !fb.valid
                // PC is misaligned, want to fetch
                // the *current* word pointed to
                if(!icache.busy) begin
                    if(is_compressed(icache.rdata[31:16])) begin
                        // TODO: upper bits here don't matter,
                        // can we relax this? output 0 isn't free
                        insn_out = {16'b0, icache.rdata[31:16]};
                        insn_compressed = 1'b1;
                        insn_valid = 1'b1;
                        fb_next.valid = 1'b0;
                    end else begin
                        // Stall case: transition to state
                        // {misaligned, valid} to handle this
                        insn_out = icache.rdata; // don't care
                        insn_compressed = 1'b0;
                        insn_valid = 1'b0;
                        fb_next.valid = 1'b1;
                        fb_next.data = icache.rdata[31:16];
                    end
                end
            end
        end
    end


    assign icache.wen = 1'b0;
    assign icache.ren = ren && want_fetch;
    assign icache.addr = fetch_addr;
    assign icache.wdata = '0;
    assign icache.byte_en = 4'hF;

endmodule

