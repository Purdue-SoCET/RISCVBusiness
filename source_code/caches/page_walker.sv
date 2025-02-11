/*
*   Copyright 2016 Purdue University
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:    page_walker.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 10/13/2024
*   Description: Automatically load virtual-to-physical translations into 
*                the Translation Lookaside Buffer (TLB) when queued.
*                Logic for RV64 paging not fully implemented, needs support.
*/

`include "generic_bus_if.vh"
`include "prv_pipeline_if.vh"
`include "address_translation_if.vh"

module page_walker #(
    parameter int PHYSICAL_ADDR_WIDTH = 32 // Can be 34 for Sv32, 56 for Sv39-57
    // parameter int PGSIZE_BITS = 12 // Assuming a 4 KiB page size
)
(
    input logic CLK, nRST,
    input logic itlb_miss, dtlb_miss,
    output logic fault_load_page, fault_store_page, fault_insn_page,
    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus itlb_gen_bus_if,
    generic_bus_if.generic_bus dtlb_gen_bus_if,
    prv_pipeline_if.cache prv_pipe_if,
    address_translation_if at_if
);

    import rv32i_types_pkg::*;
    import machine_mode_types_1_13_pkg::*;

    // local parameters
    localparam SV32_LEVELS = 2;
    localparam SV39_LEVELS = 3;
    localparam SV48_LEVELS = 4;
    localparam SV57_LEVELS = 5;
    localparam SV64_LEVELS = 6;

    // typedef struct packed {
    //     logic [1:0] reserved_0;
    //     logic       dirty;
    //     logic       accessed;
    //     logic       global;
    //     logic       user;
    //     logic       executable;
    //     logic       writable;
    //     logic       readable;
    //     logic       valid;
    // } pte_perms_t;

    // state logic
    typedef enum {
        IDLE, WALK, RETURN_PA, FAULT
    } pw_fsm_t;

    // // preserving which is currently serviced
    // typedef enum {
    //     NONE, LOAD, STORE, INSTRUCTION
    // } access_t;

    // address signals
    logic [(PHYSICAL_ADDR_WIDTH-1):0] page_address, next_page_address;
    
    // sv32
    va_sv32_t decoded_daddr_sv32, decoded_iaddr_sv32, decoded_addr_sv32;
    pte_sv32_t pte_sv32;

    // counter signals
    logic [2:0] level, next_level;

    // permission signals
    pte_perms_t pte_perms;
    logic leaf_pte;

    // state signals
    pw_fsm_t state, next_state;
    access_t access, next_access;

    // rtl (need to add logic for sv39-64 if RV64 is implemented)
    assign at_if.sv32 = prv_pipe_if.satp.mode == SV32_MODE;
    assign at_if.sv39 = 0; // prv_pipe_if.satp.mode == SV39_MODE
    assign at_if.sv48 = 0; // prv_pipe_if.satp.mode == SV48_MODE
    assign at_if.sv57 = 0; // prv_pipe_if.satp.mode == SV57_MODE
    assign at_if.sv64 = 0; // prv_pipe_if.satp.mode == SV64_MODE
    assign at_if.addr_trans_on = (at_if.sv32 | at_if.sv39 | at_if.sv48 | at_if.sv57 | at_if.sv64) && (prv_pipe_if.curr_privilege_level == S_MODE || prv_pipe_if.curr_privilege_level == U_MODE);

    assign decoded_daddr_sv32 = va_sv32_t'(dtlb_gen_bus_if.addr);
    assign decoded_iaddr_sv32 = va_sv32_t'(itlb_gen_bus_if.addr);
    assign decoded_addr_sv32  = itlb_miss && itlb_gen_bus_if.ren ? decoded_iaddr_sv32 : decoded_daddr_sv32;
    assign pte_sv32           = pte_sv32_t'(mem_gen_bus_if.rdata);
    assign pte_perms          = pte_perms_t'(mem_gen_bus_if.rdata[9:0]);

    // permission checking
    page_perm_check PW_PERM_CHECK (
        .check(state == WALK && ~mem_gen_bus_if.busy),
        .level(level),
        .access(access),
        .pte_sv32(pte_sv32),
        .fault_load_page(fault_load_page),
        .fault_store_page(fault_store_page),
        .fault_insn_page(fault_insn_page),
        .leaf_pte(leaf_pte),
        .prv_pipe_if(prv_pipe_if),
        .at_if(at_if)
    );

    // flip flops
    always_ff @ (posedge CLK, negedge nRST) begin
        if (~nRST) begin
            state <= IDLE;
            page_address <= '0;
            level <= '0;
            access <= ACCESS_NONE;
        end else begin
            state <= next_state;
            page_address <= next_page_address;
            level <= next_level;
            access <= next_access;
        end
    end

    // address translation level logic
    always_comb begin
        next_level = level;

        casez(state)
            IDLE, RETURN_PA: begin
                casez({at_if.sv64, at_if.sv57, at_if.sv48, at_if.sv39, at_if.sv32})
                    5'b????1 :  next_level = SV32_LEVELS - 1;
                    5'b???10 :  next_level = SV39_LEVELS - 1;
                    5'b??100 :  next_level = SV48_LEVELS - 1;
                    5'b?1000 :  next_level = SV57_LEVELS - 1;
                    5'b10000 :  next_level = SV64_LEVELS - 1;
                    default  :  next_level = 0;
                endcase
            end
            WALK: begin
                if (~mem_gen_bus_if.busy) begin // might be a problem if this takes more than a cycle...
                    next_level = level - 1;
                end
            end
            // FAULT: begin
            //     next_level = level;
            // end
        endcase
    end

    // // leaf page permission checking
    // always_comb begin    
    //     prv_pipe_if.fault_load_page  = 0;
    //     prv_pipe_if.fault_store_page = 0;
    //     prv_pipe_if.fault_insn_page  = 0;
    //     leaf_pte                     = 0;

    //     // need to check for normal/super pages as well as r/w/x
    //     if (state == WALK) begin
    //         if (~mem_gen_bus_if.busy) begin
    //             // may need to add pma and pmp checks here

    //             // fault if pte.v = 0 or if pte.r = 0 and pte.w = 1
    //             if (~pte_perms.valid | (~pte_perms.readable & pte_perms.writable)) begin
    //                 prv_pipe_if.fault_load_page  = access == LOAD;
    //                 prv_pipe_if.fault_store_page = access == STORE;
    //                 prv_pipe_if.fault_insn_page  = access == INSTRUCTION;
    //             end
    //             // fault if level == 0 and r/w/x are NOT set (means leaf pte is marked as a pointer to page level)
    //             else if (level == '0 & ~(pte_perms.readable | pte_perms.writable | pte_perms.executable)) begin
    //                 prv_pipe_if.fault_load_page  = access == LOAD;
    //                 prv_pipe_if.fault_store_page = access == STORE;
    //                 prv_pipe_if.fault_insn_page  = access == INSTRUCTION;
    //             end
    //             // check if pte.r = 1 or pte.x = 1, means this is a leaf node
    //             else if (pte_perms.readable | pte_perms.executable) begin
    //                 leaf_pte = 1;

    //                 // fault if instruction access and pte.r = 0
    //                 if (access == INSTRUCTION & ~pte_perms.readable) begin
    //                     prv_pipe_if.fault_insn_page = 1;
    //                 end
    //                 // fault if store access and pte.w = 0
    //                 else if (access == STORE & ~pte_perms.writable) begin
    //                     prv_pipe_if.fault_store_page = 1;
    //                 end
    //                 // fault if U = 1 and is S-mode or U = 0 and is U-mode
    //                 else if ((pte_perms.user & prv_pipe_if.curr_privilege_level == S_MODE & ~prv_pipe_if.mstatus.sum) |
    //                         (~pte_perms.user & prv_pipe_if.curr_privilege_level == U_MODE)) begin
    //                     prv_pipe_if.fault_load_page  = access == LOAD;
    //                     prv_pipe_if.fault_store_page = access == STORE;
    //                     prv_pipe_if.fault_insn_page  = access == INSTRUCTION;
    //                 end

    //                 // superpage checking
    //                 // need to add RV64 superpage checking for RV64 implementation
    //                 if (level != 0) begin
    //                     if (at_if.sv32 & |pte_sv32.ppn[9:0]) begin
    //                         prv_pipe_if.fault_load_page  = access == LOAD;
    //                         prv_pipe_if.fault_store_page = access == STORE;
    //                         prv_pipe_if.fault_insn_page  = access == INSTRUCTION;
    //                     end
    //                 end
    //             end
    //         end
    //     end
    // end

    // output logic
    always_comb begin
        dtlb_gen_bus_if.busy    = 1;
        dtlb_gen_bus_if.rdata   = 0;
        itlb_gen_bus_if.busy    = 1;
        itlb_gen_bus_if.rdata   = 0;
        mem_gen_bus_if.ren      = 0;
        mem_gen_bus_if.wen      = 0;
        mem_gen_bus_if.addr     = 0; 
        mem_gen_bus_if.wdata    = 0; 
        mem_gen_bus_if.byte_en  = '1; // set this to all 1s for evictions
        next_page_address       = page_address;
        next_access             = access;

        casez(state)
            IDLE: begin
                // if dtlb miss, service that first
                if (at_if.addr_trans_on) begin
                    if ((dtlb_miss && (dtlb_gen_bus_if.ren || dtlb_gen_bus_if.wen)) || (itlb_miss && itlb_gen_bus_if.ren)) begin
                        casez({at_if.sv64, at_if.sv57, at_if.sv48, at_if.sv39, at_if.sv32})
                            5'b????1: next_page_address = {prv_pipe_if.satp.ppn, decoded_addr_sv32.vpn[level], 2'b00};
                            5'b???10: next_page_address = '0; // {prv_pipe_if.satp.ppn, decoded_addr_sv39.vpn[level], 3'b00};
                            5'b??100: next_page_address = '0; // {prv_pipe_if.satp.ppn, decoded_addr_sv48.vpn[level], 3'b00};
                            5'b?1000: next_page_address = '0; // {prv_pipe_if.satp.ppn, decoded_addr_sv57.vpn[level], 3'b00};
                            5'b10000: next_page_address = '0; // {prv_pipe_if.satp.ppn, decoded_addr_sv64.vpn[level], 3'b00};
                            default : next_page_address = '0;
                        endcase
                    end

                    if (dtlb_miss && dtlb_gen_bus_if.ren) begin
                        next_access = ACCESS_LOAD;
                    end else if (dtlb_miss && dtlb_gen_bus_if.wen) begin
                        next_access = ACCESS_STORE;
                    end else if (itlb_miss && itlb_gen_bus_if.ren) begin
                        next_access = ACCESS_INSN;
                    end
                end
            end
            WALK: begin
                mem_gen_bus_if.ren = 1;
                mem_gen_bus_if.addr = page_address;
                if (~mem_gen_bus_if.busy) begin
                    if (leaf_pte) begin
                        dtlb_gen_bus_if.busy = ~(access == ACCESS_LOAD || access == ACCESS_STORE);
                        itlb_gen_bus_if.busy = ~(access == ACCESS_INSN);
                        casez({at_if.sv64, at_if.sv57, at_if.sv48, at_if.sv39, at_if.sv32})
                            5'b????1: begin
                                dtlb_gen_bus_if.rdata = level == 0 ? word_t'(pte_sv32) : word_t'(pte_sv32 | {12'b0, page_address[21:12], 10'b0});
                                itlb_gen_bus_if.rdata = level == 0 ? word_t'(pte_sv32) : word_t'(pte_sv32 | {12'b0, page_address[21:12], 10'b0});
                            end
                            5'b???10: begin
                                dtlb_gen_bus_if.rdata = '0;
                                itlb_gen_bus_if.rdata = '0;
                            end 
                            5'b??100: begin
                                dtlb_gen_bus_if.rdata = '0;
                                itlb_gen_bus_if.rdata = '0;
                            end
                            5'b?1000: begin
                                dtlb_gen_bus_if.rdata = '0;
                                itlb_gen_bus_if.rdata = '0;
                            end
                            5'b10000: begin
                                dtlb_gen_bus_if.rdata = '0;
                                itlb_gen_bus_if.rdata = '0;
                            end
                            default : begin
                                dtlb_gen_bus_if.rdata = '0;
                                itlb_gen_bus_if.rdata = '0;
                            end
                        endcase
                    end else begin
                        casez({at_if.sv64, at_if.sv57, at_if.sv48, at_if.sv39, at_if.sv32})
                            5'b????1: next_page_address = {pte_sv32.ppn, decoded_addr_sv32.vpn[level-1], 2'b00};
                            5'b???10: next_page_address = '0; // {pte_sv39.ppn, decoded_addr_sv39.vpn[level-1], 3'b00};
                            5'b??100: next_page_address = '0; // {pte_sv48.ppn, decoded_addr_sv48.vpn[level-1], 3'b00};
                            5'b?1000: next_page_address = '0; // {pte_sv57.ppn, decoded_addr_sv57.vpn[level-1], 3'b00};
                            5'b10000: next_page_address = '0; // {pte_sv64.ppn, decoded_addr_sv64.vpn[level-1], 3'b00};
                            default : next_page_address = '0;
                        endcase
                    end
                end
            end
            // RETURN_PA: begin
            //     next_access = NONE; // return back to no access
            // end
            // FAULT: begin

            // end
        endcase
    end

    // next state logic
    always_comb begin
        next_state = state;

        casez(state)
            IDLE: begin
                if ((dtlb_miss && (dtlb_gen_bus_if.ren || dtlb_gen_bus_if.wen)) ||
                    (itlb_miss && (itlb_gen_bus_if.ren)))
                    next_state = WALK;

                if (~at_if.addr_trans_on)
                    next_state = IDLE;
            end
            WALK: begin
                next_state = leaf_pte ? IDLE : WALK;
            end
            // RETURN_PA: begin
            //     next_state = IDLE; // may need to update
            // end
            // FAULT: begin

            // end
        endcase
    end

endmodule