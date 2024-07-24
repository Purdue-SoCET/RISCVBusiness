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
*   Filename:     decompressor.sv
*
*   Created by:   Jing Yin See
*   Email:        see4@purdue.edu
*   Date Created: 12/20/2020
*   Description:  Decompress RV32C instructions into full-size instruction
*/

`include "decompressor_if.vh"
module decompressor (
    decompressor_if.dcpr dcpr_if
);
    //Formatting of instruction
    logic c0_format, c1_format, c2_format; 

    logic upper3_0, upper3_1, upper3_2, upper3_3, upper3_4, upper3_5, upper3_6, upper3_7;

    //Logic signals for each instruction
    logic c_addi, c_addi16sp, c_addi14spn, c_slli, c_andi, c_srli, c_srai;
    logic c_mv, c_add, c_and, c_or, c_xor, c_sub;
    logic
        c_lw, c_sw, c_lwsp, c_swsp, c_flw, c_fsw, c_flwsp, c_fswsp;
    logic c_j, c_jal, c_jr, c_jalr, c_beqz, c_bnez;
    logic c_li, c_lui, c_nop, c_ebreak;
    logic c_push, c_pop, c_popretz, c_popret, c_mvsa01, c_mva01;

    //Type of instruction
    logic rtype, itype, stype, btype, utype, jtype, mtype; //mtype will represent multiple register moves.

    //Function codes
    logic [ 2:0] funct3;
    logic [ 6:0] funct7;

    //Immediates (comment in depth)
    logic [ 5:0] imm_i_c;
    logic [11:0] imm_i;
    logic [10:0] imm_j;
    logic [ 7:0] imm_b;

    //Push/Pop variables
    logic [3:0] rlist;
    logic [5:0] sp_adjust; 
    logic [2:0] r1s, r2s; 
    logic [11:0] current_offset;
    typedef enum logic[2:0] {IDLE, SENDING_HAZARD_ON, SENDING_HAZARD_OFF, ENDING, UNFREEZE, HAZARD_ACTIVE} State;

    //Push/Pop ROM variables
    logic [31:0] push_rom_inst32;
    logic [31:0] pop_rom_inst32;
    logic [31:0] mvsa0_rom_inst32;
    logic [31:0] mvsa1_rom_inst32;
    logic [31:0] mvas0_rom_inst32;
    logic [31:0] mvas1_rom_inst32;

    //Registers
    logic [4:0] rd, rs2;

    //Offsets
    logic [4:0] offset_c, offset_c_df;
    logic [5:0] offset_csp, offset_csp_df;
    logic [11:0] offset, offset_df;
    logic [20:0] jump_offset;
    logic [12:0] branch_offset;

    //Format
    assign c0_format = dcpr_if.inst16[1:0] == 2'b00;
    assign c1_format = dcpr_if.inst16[1:0] == 2'b01;
    assign c2_format = dcpr_if.inst16[1:0] == 2'b10;

    assign upper3_0 = dcpr_if.inst16[15:13] == 3'b000;
    assign upper3_1 = dcpr_if.inst16[15:13] == 3'b001;
    assign upper3_2 = dcpr_if.inst16[15:13] == 3'b010;
    assign upper3_3 = dcpr_if.inst16[15:13] == 3'b011;
    assign upper3_4 = dcpr_if.inst16[15:13] == 3'b100;
    assign upper3_5 = dcpr_if.inst16[15:13] == 3'b101;
    assign upper3_6 = dcpr_if.inst16[15:13] == 3'b110;
    assign upper3_7 = dcpr_if.inst16[15:13] == 3'b111;



    // Immediate Instructions
    assign c_addi = upper3_0 & (dcpr_if.inst16[11:7] != 5'd0) & c1_format;
    assign c_addi16sp = upper3_3 & (dcpr_if.inst16[11:7] == 5'd2) & c1_format;
    assign c_addi14spn = upper3_0 & (dcpr_if.inst16[12:5] != 8'd0) & c0_format;
    assign c_slli = upper3_0 & c2_format;
    assign c_andi = upper3_4 & c1_format & (dcpr_if.inst16[11:10] == 2'd2);
    assign c_srli = upper3_4 & c1_format & (dcpr_if.inst16[11:10] == 2'd0);
    assign c_srai = upper3_4 & c1_format & (dcpr_if.inst16[11:10] == 2'd1);

    // Register Instructions
    assign c_mv = upper3_4 & c2_format & dcpr_if.inst16[12] == 1'b0 & dcpr_if.inst16[6:2] != 5'd0;
    assign c_add = upper3_4 & c2_format & dcpr_if.inst16[12]
                   & dcpr_if.inst16[6:2] != 5'd0 & dcpr_if.inst16[11:7] != 5'd0;
    assign c_and = upper3_4 & c1_format & (dcpr_if.inst16[11:10] == 2'd3)
                   & (dcpr_if.inst16[6:5] == 2'd3);
    assign c_or = upper3_4 & c1_format & (dcpr_if.inst16[11:10] == 2'd3)
                  & (dcpr_if.inst16[6:5] == 2'd2);
    assign c_xor = upper3_4 & c1_format & (dcpr_if.inst16[11:10] == 2'd3)
                   & (dcpr_if.inst16[6:5] == 2'd1);
    assign c_sub = upper3_4 & c1_format & (dcpr_if.inst16[11:10] == 2'd3)
                   & (dcpr_if.inst16[6:5] == 2'd0);

    // Load/Store Instructions
    assign c_lw = upper3_2 & c0_format;
    assign c_sw = upper3_6 & c0_format;
    assign c_flw = upper3_3 & c0_format;
    assign c_fsw = upper3_7 & c0_format;
    assign c_lwsp = upper3_2 & c2_format;
    assign c_swsp = upper3_6 & c2_format;
    assign c_flwsp = upper3_3 & c2_format;
    assign c_fswsp = upper3_7 & c2_format;

    // Control Transfer Instructions
    assign c_j = upper3_5 & c1_format;
    assign c_jal = upper3_1 & c1_format;
    assign c_jr = upper3_4 & dcpr_if.inst16[12] == 1'b0 & dcpr_if.inst16[6:2] == 5'd0 & c2_format;
    assign c_jalr = upper3_4 & c2_format & dcpr_if.inst16[12]
                    & dcpr_if.inst16[6:2] == 5'd0 & dcpr_if.inst16[11:7] != 5'd0;
    assign c_beqz = upper3_6 & c1_format;
    assign c_bnez = upper3_7 & c1_format;

    // Constant Generation Instructions
    assign c_li = upper3_2 & c1_format;
    assign c_lui = upper3_3 & (dcpr_if.inst16[11:7] != 5'd0)
                   & (dcpr_if.inst16[11:7] != 5'd2) & c1_format;

    //Push/Pop Instructions
    assign c_push = upper3_5 & c2_format & (dcpr_if.inst16[12:8] == 5'b11000);
    assign c_pop = upper3_5 & c2_format & (dcpr_if.inst16[12:8] == 5'b11010);
    assign c_popretz = upper3_5 & c2_format & (dcpr_if.inst16[12:8] == 5'b11100);
    assign c_popret = upper3_5 & c2_format & (dcpr_if.inst16[12:8] == 5'b11110);
    assign c_mvsa01 = upper3_5 & c2_format & (dcpr_if.inst16[12:10] == 3'b011) & (dcpr_if.inst16[6:5] == 3'b01);
    assign c_mva01 = upper3_5 & c2_format & (dcpr_if.inst16[12:10] == 3'b011) & (dcpr_if.inst16[6:5] == 3'b11)
    

    // Others
    //assign illegal = dcpr_if.inst16 == 16'd0;
    assign c_nop = upper3_0 & (dcpr_if.inst16[12:2] == 11'd0) & c1_format;
    assign c_ebreak = upper3_4 & c2_format & dcpr_if.inst16[12] & dcpr_if.inst16[11:2] == 10'd0;

    // Instruction type
    assign rtype = c_mv | c_add | c_and | c_or | c_xor | c_sub;
    assign itype = c_addi | c_addi16sp | c_addi14spn | c_slli | c_andi | c_srli
                   | c_lw | c_flw | c_lwsp | c_flwsp | c_li | c_nop | c_srai | c_fld | c_fldsp;
    assign stype = c_sw | c_swsp | c_fsw | c_fswsp | c_fsd | c_fsdsp;
    assign btype = c_beqz | c_bnez;
    assign utype = c_lui;
    assign jtype = c_j | c_jal | c_jr | c_jalr;
    assign mtype = c_push | c_pop | c_popretz | c_popret | c_mvsa01 | c_mva01;

    //Immediate Generation
    assign imm_i_c = {dcpr_if.inst16[12], dcpr_if.inst16[6:2]}; 
    assign imm_j = {
        dcpr_if.inst16[12],
        dcpr_if.inst16[8],
        dcpr_if.inst16[10:9],
        dcpr_if.inst16[6],
        dcpr_if.inst16[7],
        dcpr_if.inst16[2],
        dcpr_if.inst16[11],
        dcpr_if.inst16[5:3]
    };
    assign imm_b = {
        dcpr_if.inst16[12],
        dcpr_if.inst16[6:5],
        dcpr_if.inst16[2],
        dcpr_if.inst16[11:10],
        dcpr_if.inst16[4:3]
    };
    assign offset_c = {dcpr_if.inst16[5], dcpr_if.inst16[12:10], dcpr_if.inst16[6]};
    assign offset_csp = (c_swsp | c_fswsp) ? {dcpr_if.inst16[8:7], dcpr_if.inst16[12:9]}
                                             : {dcpr_if.inst16[3:2], dcpr_if.inst16[12], dcpr_if.inst16[6:4]};
    assign offset_c_df = {dcpr_if.inst16[6:5], dcpr_if.inst16[12:10]};
    assign offset_csp_df = c_fsdsp ? {dcpr_if.inst16[9:7], dcpr_if.inst16[12:10]}
                                     : {dcpr_if.inst16[4:2], dcpr_if.inst16[12], dcpr_if.inst16[6:5]};

    //Push/Pop variable assignment
    assign rlist = dcpr_if.inst16[7:4];
    assign sp_adjust = {dcpr_if.inst16[3:2], 4'd0}; 
    assign r1s = dcpr_if.inst16[9:7]; 
    assign r2s = dcpr_if.inst16[4:2];

    //Push/Pop State Machine
    

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

    

    // Sign Extend immediate
    always_comb begin
        if (c_srai) imm_i = {7'b0100000, imm_i_c[4:0]};
        else if (c_srli | c_slli) imm_i = {7'b0000000, imm_i_c[4:0]};
        else if (c_addi16sp)
            imm_i = {
                {2{dcpr_if.inst16[12]}},
                {
                    dcpr_if.inst16[12],
                    dcpr_if.inst16[4:3],
                    dcpr_if.inst16[5],
                    dcpr_if.inst16[2],
                    dcpr_if.inst16[6]
                },
                4'd0
            };
        else if (c_addi14spn)
            imm_i = {
                2'd0,
                {
                    dcpr_if.inst16[10:7],
                    dcpr_if.inst16[12],
                    dcpr_if.inst16[11],
                    dcpr_if.inst16[5],
                    dcpr_if.inst16[6]
                },
                2'd0
            };
        else imm_i = {{6{imm_i_c[5]}}, imm_i_c};
    end

    // Sign Extend offset
    assign offset = (c_sw | c_lw | c_fsw | c_flw) ? {5'd0, offset_c, 2'd0}
                                                    : {4'd0, offset_csp, 2'd0};
    assign offset_df = (c_fld | c_fsd) ? {4'd0, offset_c_df, 3'd0} : {3'd0, offset_csp_df, 3'd0};
    assign jump_offset = {{9{imm_j[10]}}, imm_j, 1'b0};
    assign branch_offset = {{4{imm_b[7]}}, imm_b, 1'b0};

    // Select funct3 in 32 bit instruction
    always_comb begin
        //        if (c_addi | c_addi16sp | c_addi14spn | c_add | c_sub | c_mv | c_li | c_nop | c_beqz) funct3 = 3'b000;
        if (c_slli | c_bnez) funct3 = 3'b001;
        else if (c_andi | c_and) funct3 = 3'b111;
        else if (c_srli | c_srai) funct3 = 3'b101;
        else if (c_or) funct3 = 3'b110;
        else if (c_xor) funct3 = 3'b100;
        else if (c_sw | c_fsw | c_swsp | c_fswsp | c_lw | c_flw | c_lwsp | c_flwsp) funct3 = 3'b010;
        else if (c_fld | c_fsd | c_fldsp | c_fsdsp) funct3 = 3'b011;
        else funct3 = 3'b000;
    end

    // Select register
    assign rd = (c_srli | c_srai | c_and | c_or | c_xor | c_sub | c_sw | c_lw | c_fsw | c_fsd | c_flw | c_fld | c_beqz | c_bnez | c_andi)
                ? {2'd1, dcpr_if.inst16[9:7]} : dcpr_if.inst16[11:7];
    assign rs2 = (c_mv | c_add) ? dcpr_if.inst16[6:2] : {2'd1, dcpr_if.inst16[4:2]};

    // Encode full 32 bit instruction
    always_comb begin
        if (rtype) begin
            if (c_sub) dcpr_if.inst32 = {7'b0100000, rs2, rd, funct3, rd, 7'b0110011};
            else if (c_mv) dcpr_if.inst32 = {7'b0000000, rs2, 5'd0, funct3, rd, 7'b0110011};
            else dcpr_if.inst32 = {7'b0000000, rs2, rd, funct3, rd, 7'b0110011};
        end else if (itype) begin
            if (c_addi16sp) dcpr_if.inst32 = {imm_i, 5'd2, funct3, 5'd2, 7'b0010011};
            else if (c_addi14spn) dcpr_if.inst32 = {imm_i, 5'd2, funct3, rs2, 7'b0010011};
            else if (c_li) dcpr_if.inst32 = {imm_i, 5'd0, funct3, rd, 7'b0010011};
            else if (c_lw) dcpr_if.inst32 = {offset, rd, funct3, rs2, 7'b0000011};
            else if (c_flw) dcpr_if.inst32 = {offset, rd, funct3, rs2, 7'b0000111};
            else if (c_fld) dcpr_if.inst32 = {offset_df, rd, funct3, rs2, 7'b0000111};
            else if (c_lwsp) dcpr_if.inst32 = {offset, 5'd2, funct3, rd, 7'b0000011};
            else if (c_flwsp) dcpr_if.inst32 = {offset, 5'd2, funct3, rd, 7'b0000111};
            else if (c_fldsp) dcpr_if.inst32 = {offset_df, 5'd2, funct3, rd, 7'b0000111};
            else if (c_nop) dcpr_if.inst32 = {17'd0, funct3, 5'd0, 7'b0010011};
            else dcpr_if.inst32 = {imm_i, rd, funct3, rd, 7'b0010011};
        end else if (stype) begin
            if (c_sw) dcpr_if.inst32 = {offset[11:5], rs2, rd, funct3, offset[4:0], 7'b0100011};
            else if (c_fsw)
                dcpr_if.inst32 = {offset[11:5], rs2, rd, funct3, offset[4:0], 7'b0100111};
            else if (c_fsd)
                dcpr_if.inst32 = {offset_df[11:5], rs2, rd, funct3, offset_df[4:0], 7'b0100111};
            else if (c_fswsp)
                dcpr_if.inst32 = {
                    offset[11:5], dcpr_if.inst16[6:2], 5'd2, funct3, offset[4:0], 7'b0100111
                };
            else if (c_fsdsp)
                dcpr_if.inst32 = {
                    offset_df[11:5], dcpr_if.inst16[6:2], 5'd2, funct3, offset_df[4:0], 7'b0100111
                };
            else
                dcpr_if.inst32 = {
                    offset[11:5], dcpr_if.inst16[6:2], 5'd2, funct3, offset[4:0], 7'b0100011
                };
        end else if (btype)
            dcpr_if.inst32 = {
                branch_offset[12],
                branch_offset[10:5],
                5'd0,
                rd,
                funct3,
                branch_offset[4:1],
                branch_offset[11],
                7'b1100011
            };
        else if (utype) dcpr_if.inst32 = {{{14{imm_i_c[5]}}, imm_i_c}, rd, 7'b0110111};
        else if (jtype) begin
            if (c_j)
                dcpr_if.inst32 = {
                    jump_offset[20],
                    jump_offset[10:1],
                    jump_offset[11],
                    jump_offset[19:12],
                    5'd0,
                    7'b1101111
                };
            else if (c_jal)
                dcpr_if.inst32 = {
                    jump_offset[20],
                    jump_offset[10:1],
                    jump_offset[11],
                    jump_offset[19:12],
                    5'd1,
                    7'b1101111
                };
            else if (c_jr) dcpr_if.inst32 = {12'd0, rd, 3'd0, 5'd0, 7'b1100111};
            else dcpr_if.inst32 = {12'd0, rd, 3'd0, 5'd1, 7'b1100111};
        end else if (c_ebreak) dcpr_if.inst32 = {12'b000000000001, 5'd0, 3'd0, 5'd0, 7'b1110011};
        else dcpr_if.inst32 = 32'd0;
    end

    assign dcpr_if.c_ena = dcpr_if.inst16[1:0] != 2'b11;
endmodule

