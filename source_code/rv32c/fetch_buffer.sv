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
    // State Machine:
    // The state is encoded as {pc[1], fb.valid}:
    // - PC_ALIGNED_FB_INVALID (00): PC is word-aligned, no data buffered
    // - PC_ALIGNED_FB_VALID (01): PC is word-aligned, data buffered (rare/transient)
    // - PC_MISALIGNED_FB_INVALID (10): PC is halfword-aligned, no data buffered
    // - PC_MISALIGNED_FB_VALID (11): PC is halfword-aligned, upper 16b buffered
    typedef enum logic [1:0] {
        PC_ALIGNED_FB_INVALID    = 2'b00,
        PC_ALIGNED_FB_VALID      = 2'b01,
        PC_MISALIGNED_FB_INVALID = 2'b10,
        PC_MISALIGNED_FB_VALID   = 2'b11
    } fb_state_t;

    // Fetch buffer holds the upper 16 bits when needed
    typedef struct packed {
        logic [15:0] data;
        logic valid;
    } fb_t;

    fb_state_t state;
    fb_t fb;
    fb_t fb_next;
    logic [31:0] fetch_addr;
    logic want_fetch;

    function automatic logic is_compressed(logic [15:0] chunk);
        return (chunk[1:0] != 2'b11);
    endfunction

    // state register is combination of pc[1] and fb.valid
    assign state = fb_state_t'({pc[1], fb.valid});

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            fb <= '0;
        end else begin
            fb <= fb_next;
        end
    end

    // Hack: intermediate signal needed for Verilator
    // to not find combinational loop
    fb_t fb_next_before_invalidate;

    always_comb begin
        // Default outputs
        insn_out = 32'h0;
        insn_valid = 1'b0;
        insn_compressed = 1'b0;

        // Default: hold current buffer
        fb_next_before_invalidate = fb;

        if (ren) begin
            case (state)
                PC_ALIGNED_FB_INVALID: begin
                    // State: PC word-aligned, buffer empty
                    // Action: Fetch from cache at aligned address
                    if (!icache.busy) begin
                        insn_out = icache.rdata;
                        insn_valid = 1'b1;

                        if (is_compressed(icache.rdata[15:0])) begin
                            // Read compressed instruction from lower 16b
                            // Output: 16-bit instruction
                            // Next: Buffer upper 16b, transition to MISALIGNED_VALID (via PC increment)
                            insn_compressed = 1'b1;
                            fb_next_before_invalidate.data = icache.rdata[31:16];
                            fb_next_before_invalidate.valid = 1'b1;
                        end else begin
                            // Read 32-bit instruction
                            // Output: 32-bit instruction
                            // Next: Stay in ALIGNED_INVALID (via PC increment)
                            insn_compressed = 1'b0;
                            fb_next_before_invalidate.valid = 1'b0;
                        end
                    end
                    // If icache.busy, outputs remain 0 (stall)
                end

                PC_ALIGNED_FB_VALID: begin
                    // State: PC word-aligned but buffer has data
                    // This is a transient/unusual state (e.g., after a branch to aligned
                    // address while buffer was valid). The case pc_aligned && fb.valid
                    // is noted in original as "not possible" under normal flow.
                    // Action: Prioritize I$ fetch (as per original comment)
                    if (!icache.busy) begin
                        insn_out = icache.rdata;
                        insn_valid = 1'b1;

                        if (is_compressed(icache.rdata[15:0])) begin
                            insn_compressed = 1'b1;
                            fb_next_before_invalidate.data = icache.rdata[31:16];
                            fb_next_before_invalidate.valid = 1'b1;
                        end else begin
                            insn_compressed = 1'b0;
                            fb_next_before_invalidate.valid = 1'b0;
                        end
                    end
                end

                PC_MISALIGNED_FB_VALID: begin
                    // State: PC halfword-aligned, buffer has upper 16b
                    if (is_compressed(fb.data)) begin
                        // Buffer holds a complete compressed instruction
                        // Output: 16-bit instruction from buffer
                        // Next: Clear buffer, transition to ALIGNED_INVALID (via PC increment)
                        insn_out = {16'b0, fb.data};
                        insn_compressed = 1'b1;
                        insn_valid = 1'b1;
                        fb_next_before_invalidate.valid = 1'b0;
                    end else begin
                        // Buffer holds upper half of 32-bit instruction
                        // Need to fetch next word for lower 16b
                        if (!icache.busy) begin
                            insn_out = {icache.rdata[15:0], fb.data};
                            insn_compressed = 1'b0;
                            insn_valid = 1'b1;

                            if (!stall) begin
                                // Update buffer with new upper 16b
                                // Next: Stay in MISALIGNED_VALID (via PC increment)
                                fb_next_before_invalidate.data = icache.rdata[31:16];
                                fb_next_before_invalidate.valid = 1'b1;
                            end else begin
                                // Stall: keep current buffer (don't update)
                                // This handles the case where IF/EX stage is stalled
                                fb_next_before_invalidate.data = fb.data;
                                fb_next_before_invalidate.valid = 1'b1;
                            end
                        end
                        // If icache.busy, outputs remain 0 (stall)
                    end
                end

                PC_MISALIGNED_FB_INVALID: begin
                    // State: PC halfword-aligned, buffer empty
                    // Action: Fetch at word-aligned address, use upper 16 bits
                    if (!icache.busy) begin
                        if (is_compressed(icache.rdata[31:16])) begin
                            // Upper halfword is a compressed instruction
                            // Output: 16-bit instruction from upper half
                            // Next: Stay invalid, transition to ALIGNED_INVALID (via PC increment)
                            insn_out = {16'b0, icache.rdata[31:16]};
                            insn_compressed = 1'b1;
                            insn_valid = 1'b1;
                            fb_next_before_invalidate.valid = 1'b0;
                        end else begin
                            // Upper halfword is start of 32-bit instruction
                            // Buffer it and wait for next fetch
                            // Output: Invalid (stall)
                            // Next: Transition to MISALIGNED_VALID (same PC)
                            insn_out = icache.rdata; // don't care
                            insn_compressed = 1'b0;
                            insn_valid = 1'b0;
                            fb_next_before_invalidate.data = icache.rdata[31:16];
                            fb_next_before_invalidate.valid = 1'b1;
                        end
                    end
                    // If icache.busy, outputs remain 0 (stall)
                end
            endcase
        end
    end

    // Hack: Verilator got spurious combinational loop if this logic
    // was part of the above block. Considers assigning fb.valid to
    // also drive fb.data, even when completely separated.
    always_comb begin : NEXT_STATE
        fb_next = fb_next_before_invalidate;

        if (invalidate) begin
            fb_next.valid = 1'b0;
        end
    end

    // Fetch address + request generation
    always_comb begin : FETCH_CONTROL
        // Note: state PC_ALIGNED_FB_VALID isn't possible.
        assert(state != PC_ALIGNED_FB_VALID);
        // Determine fetch address based on current state
        case (state)
            PC_ALIGNED_FB_INVALID, PC_ALIGNED_FB_VALID: begin
                // Fetch at current PC (word-aligned)
                fetch_addr = pc;
            end

            PC_MISALIGNED_FB_VALID: begin
                // If buffer has compressed, consume it without fetch (but set addr to PC)
                // If buffer has 32b upper half, fetch next word at PC+2
                if (is_compressed(fb.data))
                    fetch_addr = pc;  // Won't actually fetch
                else
                    fetch_addr = pc + 2;
            end

            PC_MISALIGNED_FB_INVALID: begin
                // Fetch at word-aligned address to get upper 16b
                fetch_addr = {pc[31:2], 2'b00};
            end
        endcase

        // Determine if we need to fetch from cache
        case (state)
            PC_ALIGNED_FB_INVALID, PC_ALIGNED_FB_VALID:
                want_fetch = 1'b1;  // ALIGNED + VALID not possible

            PC_MISALIGNED_FB_INVALID:
                want_fetch = 1'b1;  // Always fetch when buffer invalid

            PC_MISALIGNED_FB_VALID:
                want_fetch = !is_compressed(fb.data);  // Fetch only if 32b instruction
        endcase
    end

    // Icache
    assign icache.wen = 1'b0;
    assign icache.ren = ren && want_fetch;
    assign icache.addr = fetch_addr;
    assign icache.wdata = '0;
    assign icache.byte_en = 4'hF;

endmodule
