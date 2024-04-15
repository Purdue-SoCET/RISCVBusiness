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
// logic [2:0] eew_bytes;

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

// assign eew_bytes = (1 << vug_if.veew_dest);

assign advance = (!vug_if.stall && vug_if.gen);

// counter for seg load/store instruction for which field were load/storing 
logic[3:0] nf_counter_reg;
always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST)
        nf_counter_reg <= '0; 
    else if(refresh)
        nf_counter_reg <= 1; 
    else if(advance) begin
        if(nf_counter_reg == vug_if.nf_seg)
            nf_counter_reg <= '0; 
        else 
            nf_counter_reg <= nf_counter_reg + 1; 
    end
end

assign vug_if.nf_counter = (refresh) ? 0 : nf_counter_reg; 
assign vug_if.new_seg = vug_if.is_seg_op && (vug_if.nf_counter == 0); 

// segment instruction signals vlane_active signals. Also used for segment index instructions
logic[3:0] vlane_active_seg_reg; 
logic[3:0] vlane_active_seg; 


always_ff @(posedge CLK, negedge nRST) begin
    if(!nRST)
        vlane_active_seg_reg <= '0; 
    else if(refresh) begin
        vlane_active_seg_reg <= 0; 
    end
    else if(advance) begin
        if(vug_if.nf_counter == vug_if.nf_seg)
            vlane_active_seg_reg <= vlane_active_seg_reg + 1;
    end 
end

assign vlane_active_seg = (refresh) ? 0 : vlane_active_seg_reg; 

// uop number counter. For segment memory operations, this corresponds to the segment number. 
always_ff @(posedge CLK, negedge nRST) begin
    if (!nRST) begin
        vuop_num_reg <= 0;
    end else if (refresh) begin
        if(vug_if.is_seg_op) begin
            vuop_num_reg <= 0;  
        end
        else 
            vuop_num_reg <= 1; 
    end else if (advance) begin
        if(vug_if.is_seg_op) begin
            if(vug_if.nf_counter == vug_if.nf_seg)
                vuop_num_reg <= vuop_num_reg + 1;; 
        end
        else begin
            vuop_num_reg <= vuop_num_reg + 1;
        end
        
    end
end

// elements left register
always_ff @(posedge CLK, negedge nRST) begin
    if (!nRST) begin
        elements_left_reg <= '0;
    end else if (refresh) begin
        if(vug_if.is_seg_op) begin
            elements_left_reg <= vug_if.vl[7:0]; 
        end
        else 
            elements_left_reg <= vug_if.vl[7:0] - VLANE_COUNT; 
    end else if (advance) begin
        if(vug_if.is_seg_op) begin
             if(vug_if.nf_counter == vug_if.nf_seg)
                elements_left_reg <= elements_left_reg - 1; 
        end 
        else begin
            elements_left_reg <=  elements_left_reg - VLANE_COUNT; 
        end 
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
always_comb begin
    vug_if.busy = 1'b0; 
    if(vug_if.is_seg_op & vug_if.gen) begin
        vug_if.busy = 1'b1; 
        if(elements_left == 1 && (vug_if.nf_counter == vug_if.nf_seg))
            vug_if.busy = 1'b0; 
    end
    else if(vug_if.gen) begin  
        vug_if.busy = elements_left > VLANE_COUNT; 
    end

end
// assign vug_if.busy = (vug_if.gen && (vug_if.is_seg_op ? elements_left > 1 : elements_left > VLANE_COUNT) );

// Set last uop flag if last uop is being issued
assign vug_if.vuop_last = ~vug_if.gen || ~vug_if.busy; // (vug_if.is_seg_op ? elements_left <= 1 : elements_left <= VLANE_COUNT); //  (vug_if.gen && elements_left <= VLANE_COUNT);

// calculate bank offset 
assign vug_if.vbank_offset = vug_if.is_seg_op ? {vug_if.vuop_num >> 2}[1:0] : vug_if.vuop_num[1:0];

// Calculate reg offset 
always_comb begin
    case (vug_if.veew_dest)
        rv32v_types_pkg::SEW8 : vug_if.vreg_offset_dest = vug_if.is_seg_op ? {vug_if.vuop_num >> 4}[2:0] : {vug_if.vuop_num >> 2}[2:0];
        rv32v_types_pkg::SEW16: vug_if.vreg_offset_dest = vug_if.is_seg_op ? {vug_if.vuop_num >> 3}[2:0] : {vug_if.vuop_num >> 1}[2:0];
        rv32v_types_pkg::SEW32: vug_if.vreg_offset_dest = vug_if.is_seg_op ? {vug_if.vuop_num >> 2}[2:0] : {vug_if.vuop_num >> 0}[2:0];
        default: vug_if.vreg_offset_dest = '0;
    endcase

    if(vug_if.is_seg_op) begin
        vug_if.vreg_offset_dest = (vug_if.vreg_offset_dest) + (vug_if.nf_counter << vug_if.emul_dest);  // moving across fields within registers 
    end

    case (vug_if.veew_src1)
        rv32v_types_pkg::SEW8 : vug_if.vreg_offset_src1 = vug_if.is_seg_op ? {vug_if.vuop_num >> 4}[2:0] : {vug_if.vuop_num >> 2}[2:0];
        rv32v_types_pkg::SEW16: vug_if.vreg_offset_src1 = vug_if.is_seg_op ? {vug_if.vuop_num >> 3}[2:0] : {vug_if.vuop_num >> 1}[2:0];
        rv32v_types_pkg::SEW32: vug_if.vreg_offset_src1 = vug_if.is_seg_op ? {vug_if.vuop_num >> 2}[2:0] : {vug_if.vuop_num >> 0}[2:0];
        default: vug_if.vreg_offset_src1 = '0;
    endcase

    if(vug_if.is_seg_op) begin
        vug_if.vreg_offset_src1 = (vug_if.vreg_offset_src1) + (vug_if.nf_counter << vug_if.emul_src1); 
    end


    case (vug_if.veew_src2)
        rv32v_types_pkg::SEW8 : vug_if.vreg_offset_src2 = vug_if.is_seg_op ? {vug_if.vuop_num >> 4}[2:0] : {vug_if.vuop_num >> 2}[2:0];
        rv32v_types_pkg::SEW16: vug_if.vreg_offset_src2 = vug_if.is_seg_op ? {vug_if.vuop_num >> 3}[2:0] : {vug_if.vuop_num >> 1}[2:0];
        rv32v_types_pkg::SEW32: vug_if.vreg_offset_src2 = vug_if.is_seg_op ? {vug_if.vuop_num >> 2}[2:0] : {vug_if.vuop_num >> 0}[2:0];
        default: vug_if.vreg_offset_src2 = '0;
    endcase

    //** we don't the below operation since vs2 serves as the index vector 
    // if(vug_if.is_seg_op) begin
    //     vug_if.vreg_offset_src2 = (vug_if.vreg_offset_src2) + (vug_if.nf_counter << vug_if.emul_src2); 
    // end

end

// Calculate lane actives
always_comb begin
    case (elements_left)
        1: vug_if.vlane_active = 4'b0001;
        2: vug_if.vlane_active = 4'b0011;
        3: vug_if.vlane_active = 4'b0111;
        default: vug_if.vlane_active = '1;
    endcase


    // overwrite for segment instructions 
    if(vug_if.is_seg_op)
        vug_if.vlane_active = vlane_active_seg; 
end

endmodule
