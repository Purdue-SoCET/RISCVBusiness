/*
*   Copyright 2024 Purdue University
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
*   Filename:     rv32v_uop_gen.sv
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 02/06/2024
*   Description:  Vector uop generation block
*/

`include "rv32v_uop_gen_if.vh"

import rv32v_types_pkg::*; 

module rv32v_uop_gen(
    input logic CLK,
    input logic nRST,
    rv32v_uop_gen_if.vug vug_if
);

parameter VREG_WIDTH_BYTES = 16;
parameter VREG_COUNT = 32;
parameter VLMUL_MAX = 8;
parameter VLANE_COUNT = 4;

// Required intermediate values
logic [2:0] eew_bytes;

// Flags to indicate when to refresh or advance
logic refresh;
logic advance;

// Register containing the number of elements left in this instruction
// Note that this value includes the elements in the uop being issued
// on this cycle, so it will never actually reach zero
logic [7:0] elements_left_reg;
logic [7:0] elements_left;

// Register to store current uop number
logic [7:0] vuop_num_reg;

assign eew_bytes = (1 << vug_if.veew);

assign advance = (!vug_if.stall && vug_if.gen);

// uop number counter
always_ff @(posedge CLK, negedge nRST) begin
    if (!nRST) begin
        vuop_num_reg <= 0;
    end else if (refresh) begin
        vuop_num_reg <= 1;
    end else if (advance) begin
        vuop_num_reg <= vuop_num_reg + 1;
    end
end

// elements left register
always_ff @(posedge CLK, negedge nRST) begin
    if (!nRST) begin
        elements_left_reg <= '0;
    end else if (refresh) begin
        elements_left_reg <= vug_if.vl[7:0] - VLANE_COUNT;
    end else if (advance) begin
        elements_left_reg <= elements_left_reg - VLANE_COUNT;
    end
end

// refresh reg
always_ff @(posedge CLK, negedge nRST) begin
    if (!nRST) begin
        refresh <= '0;
    end else if (!vug_if.stall) begin
        refresh <= !vug_if.busy;
    end
end

// Override registered values with latest values if we're about to refresh
assign elements_left = (refresh) ? vug_if.vl : elements_left_reg;
assign vug_if.vuop_num = (refresh) ? 0 : vuop_num_reg;

// Set busy flag until the last uop is being issued
assign vug_if.busy = (vug_if.gen && elements_left > VLANE_COUNT);

// Set last uop flag if last uop is being issued
assign vug_if.vuop_last = (vug_if.gen && elements_left <= VLANE_COUNT);

// Calculate bank offset
assign vug_if.vbank_offset = {vug_if.vuop_num[1:0] << vug_if.veew}[1:0];

// Calculate reg offset
always_comb begin
    case (vug_if.veew)
        rv32v_types_pkg::SEW8 : vug_if.vreg_offset = {vug_if.vuop_num >> 2}[2:0];
        rv32v_types_pkg::SEW16: vug_if.vreg_offset = {vug_if.vuop_num >> 1}[2:0];
        rv32v_types_pkg::SEW32: vug_if.vreg_offset = {vug_if.vuop_num >> 0}[2:0];
        default: vug_if.vreg_offset = '0;
    endcase
end

// Calculate lane actives
always_comb begin
    case (elements_left)
        1: vug_if.vlane_active = 4'b0001;
        2: vug_if.vlane_active = 4'b0011;
        3: vug_if.vlane_active = 4'b0111;
        default: vug_if.vlane_active = '1;
    endcase
end

endmodule
