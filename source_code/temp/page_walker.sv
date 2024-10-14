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
*   Created by:   William Milne
*   Email:        milnew@purdue.edu
*   Date Created: 
*   Description: Automatically load virtual-to-physical translations into 
*                the Translation Lookaside Buffer (TLB) when queued
*/

module page_walker #(
    parameter int ADDR_WIDTH = 32,
    parameter int PTE_WIDTH = 32,
    parameter int PGSIZE_BITS = 12 // Assuming a 4 KiB page size
)(
    input logic clk,
    input logic reset_n,
    input logic start_walk,
    input logic [ADDR_WIDTH-1:0] virtual_address,
    input logic [ADDR_WIDTH-1:0] satp, // Supervisor Address Translation and Protection register
    output logic [ADDR_WIDTH-1:0] physical_address,
    output logic walk_done,
    output logic walk_fault

    //Memory interface
);

    // Define the FSM states
    typedef enum logic [2:0] {
        STATE_WAIT,
        STATE_WALK_LEVEL1,
        STATE_WALK_LEVEL2,
        STATE_RETURN_PA,
        STATE_FAULT
    } state_t;

    state_t current_state, next_state;

    // Internal signals
    logic [ADDR_WIDTH-1:0] level1_pte_addr;
    logic [ADDR_WIDTH-1:0] level2_pte_addr;
    logic [PTE_WIDTH-1:0] level1_pte; // Placeholder for level 1 page table entry
    logic [PTE_WIDTH-1:0] level2_pte; // Placeholder for level 2 page table entry

    // Extract VPNs from the virtual address
    logic [9:0] vpn[1:0];
    assign vpn[1] = virtual_address[31:22]; // VPN[1] for Level 1
    assign vpn[0] = virtual_address[21:12]; // VPN[0] for Level 2

    // FSM sequential logic
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            current_state <= STATE_WAIT;
        end else begin
            current_state <= next_state;
        end
    end

    // FSM combinational logic
    always_comb begin
        // Default outputs
        walk_done = 1'b0;
        walk_fault = 1'b0;
        physical_address = {ADDR_WIDTH{1'b0}};
        next_state = current_state;

        case (current_state)
            STATE_WAIT: begin
                if (start_walk) begin
                    // Check if SATP mode is BARE, which means no translation
                    if (satp[31:28] == 4'b0000) begin
                        physical_address = virtual_address;
                        walk_done = 1'b1;
                    end else begin
                        // Start the page table walk
                        next_state = STATE_WALK_LEVEL1;
                    end
                end
            end
            STATE_WALK_LEVEL1: begin
                // Calculate the address for level 1 page table entry
                // Placeholder logic for retrieving the level 1 PTE
                level1_pte_addr = (satp[21:0] << PGSIZE_BITS) + (vpn[1] * PTE_WIDTH / 8);
                // Retrieve the level 1 PTE (this would be a memory read in a real implementation)
                level1_pte = ...;
                // Check if the level 1 PTE is valid
                level1_pte_vld = ...;
                if (level1_pte_vld) begin
                    next_state = STATE_WALK_LEVEL2;
                end else begin
                    next_state = STATE_FAULT;
                end
            end
            STATE_WALK_LEVEL2: begin
                // Calculate the address for level 2 page table entry
                // Placeholder logic for retrieving the level 2 PTE
                level2_pte_addr = (level1_pte[21:0] << PGSIZE_BITS) + (vpn[0] * PTE_WIDTH / 8);
                // Retrieve the level 2 PTE (this would be a memory read in a real implementation)
                level2_pte = ...;
                // Check if the level 2 PTE is valid (this would be permission bits, page not allocated, etc.)
                level2_pte_vld = ...; 
                if (level2_pte_vld) begin
                    // Construct the physical address
                    physical_address = {level2_pte[21:0], virtual_address[11:0]};
                    next_state = STATE_RETURN_PA;
                end else begin
                    next_state = STATE_FAULT;
                end
            end
            STATE_RETURN_PA: begin
                // Return the physical address to the requester
                walk_done = 1'b1;
                next_state = STATE_WAIT;
            end
            STATE_FAULT: begin
                // Handle any faults that occurred during the page walk
                walk_fault = 1'b1;
                next_state = STATE_WAIT;
            end
            default: begin
                next_state = STATE_WAIT;
            end
        endcase
    end

 

    // Additional logic for memory reads, PTE checks, etc., would be required here

 

endmodule