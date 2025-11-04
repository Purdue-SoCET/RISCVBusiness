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
    parameter int PHYSICAL_ADDR_WIDTH = 32 // Can max out to 34 bits for Sv32, 56 for Sv39-57
)
(
    input logic CLK, nRST,
    input logic itlb_miss, dtlb_miss, abort,
    output logic fault_load_page, fault_store_page, fault_insn_page,
    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus itlb_gen_bus_if,
    generic_bus_if.generic_bus dtlb_gen_bus_if,
    prv_pipeline_if.cache prv_pipe_if,
    address_translation_if insn_at_if,
    address_translation_if data_at_if
);

    import rv32i_types_pkg::*;
    import priv_isa_types_pkg::*;

    // local parameters
    localparam SV32_LEVELS = 2;
    localparam SV39_LEVELS = 3;
    localparam SV48_LEVELS = 4;
    localparam SV57_LEVELS = 5;
    localparam SV64_LEVELS = 6;

    // state logic
    typedef enum logic [1:0] {
        IDLE, WALK, FAULT
    } pw_fsm_t;

    // address signals
    logic [33:0] page_address, next_page_address; // will need to change num bits if not using sv32
    
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
    assign insn_at_if.sv32 = prv_pipe_if.satp.mode == SV32_MODE;
    assign insn_at_if.sv39 = 0; // prv_pipe_if.satp.mode == SV39_MODE
    assign insn_at_if.sv48 = 0; // prv_pipe_if.satp.mode == SV48_MODE
    assign insn_at_if.sv57 = 0; // prv_pipe_if.satp.mode == SV57_MODE
    assign insn_at_if.sv64 = 0; // prv_pipe_if.satp.mode == SV64_MODE
    assign insn_at_if.addr_trans_on = (insn_at_if.sv32 | insn_at_if.sv39 | insn_at_if.sv48 | insn_at_if.sv57 | insn_at_if.sv64) && (prv_pipe_if.curr_privilege_level == S_MODE || prv_pipe_if.curr_privilege_level == U_MODE);

    assign data_at_if.sv32 = prv_pipe_if.satp.mode == SV32_MODE;
    assign data_at_if.sv39 = 0; // prv_pipe_if.satp.mode == SV39_MODE
    assign data_at_if.sv48 = 0; // prv_pipe_if.satp.mode == SV48_MODE
    assign data_at_if.sv57 = 0; // prv_pipe_if.satp.mode == SV57_MODE
    assign data_at_if.sv64 = 0; // prv_pipe_if.satp.mode == SV64_MODE
    assign data_at_if.addr_trans_on = insn_at_if.addr_trans_on | (prv_pipe_if.mstatus.mprv & (prv_pipe_if.mstatus.mpp == S_MODE || prv_pipe_if.mstatus.mpp == U_MODE)); // MPRV allows M-mode loads/stores to be translated using previous privilege level privileges.

    assign decoded_daddr_sv32 = va_sv32_t'(dtlb_gen_bus_if.addr);
    assign decoded_iaddr_sv32 = va_sv32_t'(itlb_gen_bus_if.addr);
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
        .at_if(data_at_if)
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
            IDLE, FAULT: begin
                casez({data_at_if.sv64, data_at_if.sv57, data_at_if.sv48, data_at_if.sv39, data_at_if.sv32})
                    5'b????1 :  next_level = SV32_LEVELS - 1;
                    5'b???10 :  next_level = SV39_LEVELS - 1;
                    5'b??100 :  next_level = SV48_LEVELS - 1;
                    5'b?1000 :  next_level = SV57_LEVELS - 1;
                    5'b10000 :  next_level = SV64_LEVELS - 1;
                    default  :  next_level = 0;
                endcase
            end
            WALK: begin
                if (~mem_gen_bus_if.busy) // might be a problem if this takes more than a cycle...
                    next_level = level - 1;
                if (next_state == FAULT)
                    next_level = 0;
            end
        endcase
    end

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
        decoded_addr_sv32       = access == ACCESS_LOAD || access == ACCESS_STORE ? decoded_daddr_sv32 : access == ACCESS_INSN ? decoded_iaddr_sv32 : '0;

        casez(state)
            IDLE: begin
                if (data_at_if.addr_trans_on) begin
                    // service dtlb miss on read
                    if (dtlb_miss && dtlb_gen_bus_if.ren) begin
                        next_access = ACCESS_LOAD;
                        decoded_addr_sv32 = decoded_daddr_sv32;
                    // service dtlb miss on write
                    end else if (dtlb_miss && dtlb_gen_bus_if.wen) begin
                        next_access = ACCESS_STORE;
                        decoded_addr_sv32 = decoded_daddr_sv32;
                    // service itlb miss
                    end else if (itlb_miss && itlb_gen_bus_if.ren) begin
                        next_access = ACCESS_INSN;
                        decoded_addr_sv32 = decoded_iaddr_sv32;
                    end

                    if ((dtlb_miss && (dtlb_gen_bus_if.ren || dtlb_gen_bus_if.wen)) || (itlb_miss && itlb_gen_bus_if.ren)) begin
                        if (data_at_if.sv32)
                            next_page_address = {prv_pipe_if.satp.ppn, decoded_addr_sv32.vpn[1], 2'b00};
                        else if (data_at_if.sv39)
                            next_page_address = '0; // {prv_pipe_if.satp.ppn, decoded_addr_sv39.vpn[2], 3'b00};
                        else if (data_at_if.sv48)
                            next_page_address = '0; // {prv_pipe_if.satp.ppn, decoded_addr_sv39.vpn[3], 3'b00};
                        else if (data_at_if.sv57)
                            next_page_address = '0; // {prv_pipe_if.satp.ppn, decoded_addr_sv57.vpn[4], 3'b00};
                        else if (data_at_if.sv64)
                            next_page_address = '0; // {prv_pipe_if.satp.ppn, decoded_addr_sv64.vpn[5], 3'b00};
                        else
                            next_page_address = '0;
                    end
                end
            end
            WALK: begin
                mem_gen_bus_if.ren = 1;
                mem_gen_bus_if.addr = page_address[(PHYSICAL_ADDR_WIDTH-1):0];
                if (~mem_gen_bus_if.busy) begin
                    if (leaf_pte) begin
                        next_page_address = '0;
                        next_access = ACCESS_NONE;
                        dtlb_gen_bus_if.busy = ~(access == ACCESS_LOAD || access == ACCESS_STORE);
                        itlb_gen_bus_if.busy = ~(access == ACCESS_INSN);
                        casez({data_at_if.sv64, data_at_if.sv57, data_at_if.sv48, data_at_if.sv39, data_at_if.sv32})
                            5'b????1: begin
                                dtlb_gen_bus_if.rdata = access == ACCESS_STORE || access ==  ACCESS_LOAD ? word_t'(pte_sv32) : '0;
                                itlb_gen_bus_if.rdata = access == ACCESS_INSN ? word_t'(pte_sv32) : '0;
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
                        if (data_at_if.sv32)
                            next_page_address = {pte_sv32.ppn, decoded_addr_sv32.vpn[level-1], 2'b00};
                        else if (data_at_if.sv39)
                            next_page_address = '0; // {pte_sv39.ppn, decoded_addr_sv39.vpn[level-1], 3'b00};
                        else if (data_at_if.sv48)
                            next_page_address = '0; // {pte_sv48.ppn, decoded_addr_sv48.vpn[level-1], 3'b00};
                        else if (data_at_if.sv57)
                            next_page_address = '0; // {pte_sv57.ppn, decoded_addr_sv57.vpn[level-1], 3'b00};
                        else if (data_at_if.sv64)
                            next_page_address = '0; // {pte_sv64.ppn, decoded_addr_sv64.vpn[level-1], 3'b00};
                        else
                            next_page_address = '0;
                    end
                end
            end
            FAULT: begin
                decoded_addr_sv32 = '0;
                next_page_address = '0;
                next_access = ACCESS_NONE;
            end
        endcase
    end

    // next state logic
    always_comb begin
        next_state = state;

        casez(state)
            IDLE: begin
                if ((dtlb_miss && (dtlb_gen_bus_if.ren || dtlb_gen_bus_if.wen)) ||  // we always want to service a dTLB miss
                    (itlb_miss && (itlb_gen_bus_if.ren) && ~abort))                 // we don't service the iTLB miss if we are aborting the walk
                    next_state = WALK;

                if (~data_at_if.addr_trans_on)
                    next_state = IDLE;
            end
            WALK: begin
                next_state = fault_insn_page | fault_load_page | fault_store_page ? FAULT : leaf_pte | (abort & access == ACCESS_INSN) ? IDLE : WALK;
            end
            FAULT: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule