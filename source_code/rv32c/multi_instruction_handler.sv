opyright 2024 Purdue University
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
    logic finished_base_lines; //finish assigning (push/pop instrs)
    logic finished_final_lines; //finish assigning (pop instrs)
    logic [31:0] local_inst32;
    logic multi_line_instr, atomic_instr; 

    assign multi_line_instr = mih_if.c_push | mih_if.c_pop | mih_if.c_popretz | mih_if.c_popret | mih_if.c_mvsa01 | mih_if.c_mva01s | mih_if.c_jt | mih_if.c_jalt;
    assign atomic_instr = mih_if.c_mvsa01 | mih_if.c_mva01s;

    //Push/Pop variables
    logic [3:0] rlist;
    logic [11:0] sp_adjust, sp_adjust_neg; 
    logic [2:0] r1s, r2s; 
    logic [11:0] current_offset; //Assign
    logic [5:0] stack_adj_base;
    logic started_sending, started_final_lines;
    logic [1:0] final_instr_index; //Finish assign (final)
    
    //Push/Pop ROM variables
    logic [31:0] final_instr_inst32;
    logic [31:0] push_rom_inst32;
    logic [31:0] pop_rom_inst32;
    logic [31:0] mvsa0_rom_inst32;
    logic [31:0] mvsa1_rom_inst32;
    logic [31:0] mvas0_rom_inst32;
    logic [31:0] mvas1_rom_inst32;
    logic [4:0] push_pop_index;

    //Counter variables
    logic counter_clear, counter_enable, counter_flag;
    logic [3:0] counter_limit, counter_count; //USE 

    //Push/Pop variable assignment
    assign rlist = dcpr_if.inst16[7:4];
    assign sp_adjust = {dcpr_if.inst16[3:2], 4'd0} + stack_adj_base; 
    assign sp_adjust_neg = (!sp_adjust) + 1'b1;
    assign r1s = dcpr_if.inst16[9:7]; 
    assign r2s = dcpr_if.inst16[4:2];

    multi_instr_counter mic (.clk(clk), .n_rst(n_rst), .clear(counter_clear), .count_enable(counter_enable),
                            .rollover_val(counter_limit), .count_out(counter_count), .rollover_flag(counter_flag));

    //Push/Pop State Machine + Logic
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

    always_comb begin: COMBO_LOGIC
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

    //logic [11:0] current_offset; //Assign, tied to counter + logic
    always_comb begin: INSTRUCTION_SELECTION
        local_inst32 = 32'b0;
        counter_clear = 0;
        counter_enable = 0
        counter_limit = 4'd2; //default
        current_offset = 12'd0;
        push_pop_index = {(rlist == 4'd15 && counter_count == 0), rlist - counter_count - (rlist == 4'd15)}; //flags rlist == 15 in bit 5, adjusts index if the flag needs to be dealt with. 
        started_sending = (next_state != state) && (state == IDLE)
        started_final_lines = (next_state != state) && (next_state == FINAL_LINES)

        if (started_sending | started_final_lines) begin
            counter_clear = 1;
        end
        
        if (state != FINAL_LINES && state != IDLE) begin //Sending Lines State
            finished_final_lines = 0;
            finished_base_lines = 0;

            if (counter_flag) begin 
                finished_base_lines = 1; //End of push/pop
            end

            if (mih_if.c_push) begin
                counter_enable = 1;
                counter_limit = rlist - 4 + (rlist == 4'd15); 
                local_inst32 = push_rom_inst32;   
            end
            else if (mih_if.c_pop | mih_if.c_popretz | mih_if.c_popret) begin
                counter_enable = 1;
                counter_limit = rlist - 4 + (rlist == 4'd15); 
                local_inst32 = pop_rom_inst32;
            end
            else if (mih_if.c_mvsa01) begin
                if (started_sending) begin
                    local_inst32 = mvsa0_rom_inst32;
                end
                else begin
                    local_inst32 = mvsa1_rom_inst32;
                    finished_base_lines = 1;
                    finished_final_lines = 1;
                end
            end
            else if (mih_if.c_mva01s) begin
                if (started_sending) begin
                    local_inst32 = mvas0_rom_inst32;
                end
                else begin
                    local_inst32 = mvas1_rom_inst32;
                    finished_base_lines = 1;
                    finished_final_lines = 1;
                end
            end
        end

        else begin //Final Lines State
            finished_final_lines = 0;
            finished_base_lines = 1;

            if (mih_if.c_push) begin
                final_instr_index = 0;
                local_inst32 = final_instr_inst32;
                finished_final_lines = 1;
            end
            else if (mih_if.c_pop) begin
                final_instr_index = 2;
                local_inst32 = final_instr_inst32;
                finished_final_lines = 1;
            end
            else if (mih_if.c_popret | mih_if.popretz) begin 
                counter_enable = 1;
                local_inst32 = final_instr_inst32;

                if (mih_if.c_popret) begin
                    counter_limit = 4'd1;
                    finished_final_lines = counter_flag ? 2'd3 : 2'd2;
                end
                else begin //popretz
                    counter_limit = 4'd2;
                    finished_final_lines = counter_flag ? 2'd3 : (counter_count == 4'd1) ? 2'd2 : 2'd1;
                end

                if (counter_flag) begin
                    finished_final_lines = 1;
                end
            end
        end
    end


    //ALL ROMS
    always_comb begin: STACK_ADJ_BASE_ROM
        case (rlist)
            4'd8, 4'd9, 4'd10, 4'd11 : stack_adj_base = 6'd32; 
            4'd12, 4'd13, 4'd14 : stack_adj_base = 6'd48; 
            4'd15 : stack_adj_base = 6'd64; 
            default : stack_adj_base = 16;
        endcase
    end

    always_comb begin: FINAL_LINES_ROM
        case (final_instr_index)
            2'd0 : final_instr_inst32 = {sp_adjust_neg, 5'd5, 3'd0, 5'd5, 7'b0010011} //push stack adjust (addi sp sp sp_adjust_neg)
            2'd1 : final_instr_inst32 = {7'd0, 5'd0, 5'd0, 3'd0, 5'd1, 7'b0110011}; //popretz (addi ra zero zero)
            2'd2 : final_instr_inst32 = {sp_adjust, 5'd5, 3'd0, 5'd5, 7'b0010011}; //pop stack adjust (addi sp sp sp_adjust)
            2'd3 : final_instr_inst32 = {12'd0, 5'd1, 3'd0, 5'd0, 7'b1100111}; //popret (ret) 
        endcase
    end

    always_comb begin: PUSH_ROM
        case (push_pop_index)
            5'd4 : push_rom_inst32 = {current_offset[11:5], 5'd1, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //ra
            5'd5 : push_rom_inst32 = {current_offset[11:5], 5'd8, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s0
            5'd6 : push_rom_inst32 = {current_offset[11:5], 5'd9, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s1
            5'd7 : push_rom_inst32 = {current_offset[11:5], 5'd18, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s2
            5'd8 : push_rom_inst32 = {current_offset[11:5], 5'd19, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s3
            5'd9 : push_rom_inst32 = {current_offset[11:5], 5'd20, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s4
            5'd10 : push_rom_inst32 = {current_offset[11:5], 5'd21, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s5
            5'd11 : push_rom_inst32 = {current_offset[11:5], 5'd22, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s6
            5'd12 : push_rom_inst32 = {current_offset[11:5], 5'd23, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s7
            5'd13 : push_rom_inst32 = {current_offset[11:5], 5'd24, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s8
            5'd14 : push_rom_inst32 = {current_offset[11:5], 5'd25, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s9
            5'd15 : push_rom_inst32 = {current_offset[11:5], 5'd26, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s10
            5'b1????: push_rom_inst32 = {current_offset[11:5], 5'd27, 5'd2, 3'b010, current_offset[4:0], 7'b0100011}; //s11
            default: push_rom_inst32 = 32'b0;
        endcase
    end

    always_comb begin: POP_ROM
        case (push_pop_index)
            5'd4 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd1, 7'b0000011}; //ra
            5'd5 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd8, 7'b0000011}; //s0
            5'd6 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd9, 7'b0000011}; //s1
            5'd7 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd18, 7'b0000011}; //s2
            5'd8 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd19, 7'b0000011}; //s3
            5'd9 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd20, 7'b0000011}; //s4
            5'd10 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd21, 7'b0000011}; //s5
            5'd11 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd22, 7'b0000011}; //s6
            5'd12 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd23, 7'b0000011}; //s7
            5'd13 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd24, 7'b0000011}; //s8
            5'd14 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd25, 7'b0000011}; //s9
            5'd15 : pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd26, 7'b0000011}; //s10
            5'b1????: pop_rom_inst32 = {current_offset, 5'd2, 3'b010, 5'd27, 7'b0000011}; //s11
            default: pop_rom_inst32 = 32'b0;
        endcase
    end

    //(mv into s from a)
    always_comb begin: MVSA_0_ROM
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
    always_comb begin: MVSA_1_ROM
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

    //(mv into a from s)
    always_comb begin: MVAS_0_ROM
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
    always_comb begin: MVAS_1_ROM
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

