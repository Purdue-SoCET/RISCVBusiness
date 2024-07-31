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
*   Filename:     multi_instruction_handler.sv
*
*   Created by:   Abhijay Achukola
*   Email:        aachukol@purdue.edu
*   Date Created: 07/15/2024
*   Description: Expand certain compressed instructions into multiple 32-bit instructions or pass through the 1-to-1 32-bit equivalent.
*/

`include "decompressor_if.vh"
`include "multi_instruction_handler_if.vh"
module multi_instruction_handler (
    input logic clk, n_rst,
    decompressor_if.mih dcpr_if,
    multi_instruction_handler_if.mih mih_if
);
    //General variables
    typedef enum logic[1:0] {IDLE, SENDING_HAZARD_ON, SENDING_HAZARD_OFF, FINAL_LINES} State;
    State state, next_state;
    logic finished_base_lines;
    logic finished_final_lines;
    logic [31:0] local_inst32;
    logic multi_line_instr, atomic_instr;
    assign multi_line_instr = mih_if.c_push | mih_if.c_pop | mih_if.c_popretz | mih_if.c_popret | mih_if.c_mvsa01 | mih_if.c_mva01s | mih_if.c_jt | mih_if.c_jalt;
    assign atomic_instr = mih_if.c_mvsa01 | mih_if.c_mva01s;

    //Push/Pop variables
    logic [3:0] rlist;
    logic [5:0] sp_adjust; 
    logic [2:0] r1s, r2s; 
    logic [11:0] current_offset;
    

    //Push/Pop ROM variables
    logic [31:0] push_rom_inst32;
    logic [31:0] pop_rom_inst32;
    logic [31:0] mvsa0_rom_inst32;
    logic [31:0] mvsa1_rom_inst32;
    logic [31:0] mvas0_rom_inst32;
    logic [31:0] mvas1_rom_inst32;

    //Push/Pop variable assignment
    assign rlist = dcpr_if.inst16[7:4];
    assign sp_adjust = {dcpr_if.inst16[3:2], 4'd0}; 
    assign r1s = dcpr_if.inst16[9:7]; 
    assign r2s = dcpr_if.inst16[4:2];

    //Push/Pop State Machine
    always_ff @ (posedge clk, negedge n_rst) begin
        if (!n_rst) begin
            state = IDLE;
        end
        else begin
            state = next_state;
        end
    end
    always_comb begin: NEXT_STATE_LOGIC
        next_state = state

        if (state == IDLE && multi_line_instr && atomic_instr) begin
            next_state = SENDING_HAZARD_OFF;
        end
        else if (state == IDLE && multi_line_instr) begin
            next_state = SENDING_HAZARD_ON;
        end
        else if (state == SENDING_HAZARD_ON && finished_base_lines) begin
            next_state = FINAL_LINES;
        end
        else if (finished_final_lines && (state == SENDING_HAZARD_OFF || state == FINAL_LINES)) begin
            next_state = IDLE;
        end
    end

    always_comb begin: COMBO LOGIC
        if (state == IDLE) begin
            mih_if.inst32 = dcpr_if.inst32;
            mih_if.hazard_dis = 1'b0;
            mih_if.fetch_dis = 1'b0;
        end
        else if (state == SENDING_HAZARD_ON) begin
            mih_if.inst32 = local_inst32;
            mih_if.hazard_dis = 1'b0;
            mih_if.fetch_dis = 1'b1;
        end
        else if (state == SENDING_HAZARD_OFF) begin
            mih_if.inst32 = local_inst32;
            mih_if.hazard_dis = 1'b1;
            mih_if.fetch_dis = 1'b1;
        end
        else if (state == FINAL_LINES) begin
            mih_if.inst32 = local_inst32;
            mih_if.hazard_dis = 1'b1;
            mih_if.fetch_dis = 1'b1;
        end
    end


    //Push ROM (store)
    always_comb begin
        current_offset = -4; //Placeholder
        case (rlist)
            4'd4 : push_rom_inst32 = {current_offset[11:5], 5'd1, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //ra
            4'd5 : push_rom_inst32 = {current_offset[11:5], 5'd8, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s0
            4'd6 : push_rom_inst32 = {current_offset[11:5], 5'd9, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s1
            4'd7 : push_rom_inst32 = {current_offset[11:5], 5'd18, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s2
            4'd8 : push_rom_inst32 = {current_offset[11:5], 5'd19, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s3
            4'd9 : push_rom_inst32 = {current_offset[11:5], 5'd20, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s4
            4'd10 : push_rom_inst32 = {current_offset[11:5], 5'd21, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s5
            4'd11 : push_rom_inst32 = {current_offset[11:5], 5'd22, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s6
            4'd12 : push_rom_inst32 = {current_offset[11:5], 5'd23, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s7
            4'd13 : push_rom_inst32 = {current_offset[11:5], 5'd24, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s8
            4'd14 : push_rom_inst32 = {current_offset[11:5], 5'd25, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s9
            4'd15 : push_rom_inst32 = {current_offset[11:5], 5'd26, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s10
            default: push_rom_inst32 = {current_offset[11:5], 5'd27, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s11
        endcase
    end

    //Pop ROM (load)
    always_comb begin
        case (rlist)
            4'd4 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd1, 7'b0000011}; //ra
            4'd5 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd8, 7'b0000011}; //s0
            4'd6 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd9, 7'b0000011}; //s1
            4'd7 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd18, 7'b0000011}; //s2
            4'd8 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd19, 7'b0000011}; //s3
            4'd9 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd20, 7'b0000011}; //s4
            4'd10 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd21, 7'b0000011}; //s5
            4'd11 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd22, 7'b0000011}; //s6
            4'd12 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd23, 7'b0000011}; //s7
            4'd13 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd24, 7'b0000011}; //s8
            4'd14 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd25, 7'b0000011}; //s9
            4'd15 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd26, 7'b0000011}; //s10
            default: pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd27, 7'b0000011}; //s11
        endcase
    end

    //MVSA ROM 0 and 1(mv into s from a)
    always_comb begin
        case (r1s)
            3'd0 : mvsa0_rom_inst32 = {7'd0, 5'd0, 5'd10, 3'd0, 5'd8, 7'b0110011}; //s0
            3'd1 : mvsa0_rom_inst32 = {7'd0, 5'd0, 5'd10, 3'd0, 5'd9, 7'b0110011}; //s1
            3'd2 : mvsa0_rom_inst32 = {7'd0, 5'd0, 5'd10, 3'd0, 5'd18, 7'b0110011}; //s2
            3'd3 : mvsa0_rom_inst32 = {7'd0, 5'd0, 5'd10, 3'd0, 5'd19, 7'b0110011}; //s3
            3'd4 : mvsa0_rom_inst32 = {7'd0, 5'd0, 5'd10, 3'd0, 5'd20, 7'b0110011}; //s4
            3'd5 : mvsa0_rom_inst32 = {7'd0, 5'd0, 5'd10, 3'd0, 5'd21, 7'b0110011}; //s5
            3'd6 : mvsa0_rom_inst32 = {7'd0, 5'd0, 5'd10, 3'd0, 5'd22, 7'b0110011}; //s6
            3'd7 : mvsa0_rom_inst32 = {7'd0, 5'd0, 5'd10, 3'd0, 5'd23, 7'b0110011}; //s7
        endcase
    end
    always_comb begin
        case (r2s)
            3'd0 : mvsa1_rom_inst32 = {7'd0, 5'd0, 5'd11, 3'd0, 5'd8, 7'b0110011}; //s0
            3'd1 : mvsa1_rom_inst32 = {7'd0, 5'd0, 5'd11, 3'd0, 5'd9, 7'b0110011}; //s1
            3'd2 : mvsa1_rom_inst32 = {7'd0, 5'd0, 5'd11, 3'd0, 5'd18, 7'b0110011}; //s2
            3'd3 : mvsa1_rom_inst32 = {7'd0, 5'd0, 5'd11, 3'd0, 5'd19, 7'b0110011}; //s3
            3'd4 : mvsa1_rom_inst32 = {7'd0, 5'd0, 5'd11, 3'd0, 5'd20, 7'b0110011}; //s4
            3'd5 : mvsa1_rom_inst32 = {7'd0, 5'd0, 5'd11, 3'd0, 5'd21, 7'b0110011}; //s5
            3'd6 : mvsa1_rom_inst32 = {7'd0, 5'd0, 5'd11, 3'd0, 5'd22, 7'b0110011}; //s6
            3'd7 : mvsa1_rom_inst32 = {7'd0, 5'd0, 5'd11, 3'd0, 5'd23, 7'b0110011}; //s7
        endcase
    end

    //MVAS ROM 0 and 1(mv into a from s)
    always_comb begin
        case (r1s)
            3'd0 : mvas0_rom_inst32 = {7'd0, 5'd0, 5'd8, 3'd0, 5'd10, 7'b0110011}; //s0
            3'd1 : mvas0_rom_inst32 = {7'd0, 5'd0, 5'd9, 3'd0, 5'd10, 7'b0110011}; //s1
            3'd2 : mvas0_rom_inst32 = {7'd0, 5'd0, 5'd18, 3'd0, 5'd10, 7'b0110011}; //s2
            3'd3 : mvas0_rom_inst32 = {7'd0, 5'd0, 5'd19, 3'd0, 5'd10, 7'b0110011}; //s3
            3'd4 : mvas0_rom_inst32 = {7'd0, 5'd0, 5'd20, 3'd0, 5'd10, 7'b0110011}; //s4
            3'd5 : mvas0_rom_inst32 = {7'd0, 5'd0, 5'd21, 3'd0, 5'd10, 7'b0110011}; //s5
            3'd6 : mvas0_rom_inst32 = {7'd0, 5'd0, 5'd22, 3'd0, 5'd10, 7'b0110011}; //s6
            3'd7 : mvas0_rom_inst32 = {7'd0, 5'd0, 5'd23, 3'd0, 5'd10, 7'b0110011}; //s7
        endcase
    end
    always_comb begin
        case (r2s)
            3'd0 : mvas1_rom_inst32 = {7'd0, 5'd0, 5'd8, 3'd0, 5'd11, 7'b0110011}; //s0
            3'd1 : mvas1_rom_inst32 = {7'd0, 5'd0, 5'd9, 3'd0, 5'd11, 7'b0110011}; //s1
            3'd2 : mvas1_rom_inst32 = {7'd0, 5'd0, 5'd18, 3'd0, 5'd11, 7'b0110011}; //s2
            3'd3 : mvas1_rom_inst32 = {7'd0, 5'd0, 5'd19, 3'd0, 5'd11, 7'b0110011}; //s3
            3'd4 : mvas1_rom_inst32 = {7'd0, 5'd0, 5'd20, 3'd0, 5'd11, 7'b0110011}; //s4
            3'd5 : mvas1_rom_inst32 = {7'd0, 5'd0, 5'd21, 3'd0, 5'd11, 7'b0110011}; //s5
            3'd6 : mvas1_rom_inst32 = {7'd0, 5'd0, 5'd22, 3'd0, 5'd11, 7'b0110011}; //s6
            3'd7 : mvas1_rom_inst32 = {7'd0, 5'd0, 5'd23, 3'd0, 5'd11, 7'b0110011}; //s7
        endcase
    end

endmodule 
