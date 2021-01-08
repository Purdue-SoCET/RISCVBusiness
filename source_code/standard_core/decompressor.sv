module decompressor
(
    input logic [15:0] inst16,
    output logic [31:0] inst32
);
    logic c0_format, c1_format, c2_format;
    logic upper3_0, upper3_1, upper3_2, upper3_3, upper3_4, upper3_5, upper3_6, upper3_7;
    logic c_addi, c_addi16sp, c_addi14spn, c_slli, c_andi, c_srli, c_srai;
    logic c_mv, c_add, c_and, c_or, c_xor, c_sub;
    logic c_lw, c_sw, c_lwsp, c_swsp, c_flw, c_fsw, c_flwsp, c_fswsp, c_fld, c_fsd, c_fldsp, c_fsdsp;
    logic c_j, c_jal, c_jr, c_jalr, c_beqz, c_bnez;
    logic c_li, c_lui, c_nop, c_ebreak;
    logic rtype, itype, stype, btype, utype, jtype;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [5:0] imm_i_c;
    logic [11:0] imm_i;
    logic [10:0] imm_j;
    logic [7:0] imm_b;
    logic [4:0] rd, rs2;
    logic [4:0] offset_c, offset_c_df;
    logic [5:0] offset_csp, offset_csp_df;
    logic [11:0] offset, offset_df;
    logic [20:0] jump_offset;
    logic [12:0] branch_offset;

    assign c0_format = inst16[1:0] == 2'b00;
    assign c1_format = inst16[1:0] == 2'b01;
    assign c2_format = inst16[1:0] == 2'b10;

    assign upper3_0 = inst16[15:13] == 3'b000;
    assign upper3_1 = inst16[15:13] == 3'b001;
    assign upper3_2 = inst16[15:13] == 3'b010;
    assign upper3_3 = inst16[15:13] == 3'b011;
    assign upper3_4 = inst16[15:13] == 3'b100;
    assign upper3_5 = inst16[15:13] == 3'b101;
    assign upper3_6 = inst16[15:13] == 3'b110;
    assign upper3_7 = inst16[15:13] == 3'b111;

    // Immediate
    assign c_addi = upper3_0 & (inst16[11:7] != 5'd0) & c1_format;
    assign c_addi16sp = upper3_3 & (inst16[11:7] == 5'd2) & c1_format;
    assign c_addi14spn = upper3_0 & (inst16[12:5] != 8'd0) & c0_format;
    assign c_slli = upper3_0 & c2_format;
    assign c_andi = upper3_4 & c1_format & (inst16[11:10] == 2'd2);
    assign c_srli = upper3_4 & c1_format & (inst16[11:10] == 2'd0);
    assign c_srai = upper3_4 & c1_format & (inst16[11:10] == 2'd1);

    // Register
    assign c_mv = upper3_4 & c2_format & inst16[12] == 1'b0 & inst16[6:2] != 5'd0;
    assign c_add = upper3_4 & c2_format & inst16[12] & inst16[6:2] != 5'd0 & inst16[11:7] != 5'd0;
    assign c_and = upper3_4 & c1_format & (inst16[11:10] == 2'd3) & (inst16[6:5] == 2'd3);
    assign c_or = upper3_4 & c1_format & (inst16[11:10] == 2'd3) & (inst16[6:5] == 2'd2);
    assign c_xor = upper3_4 & c1_format & (inst16[11:10] == 2'd3) & (inst16[6:5] == 2'd1);
    assign c_sub = upper3_4 & c1_format & (inst16[11:10] == 2'd3) & (inst16[6:5] == 2'd0);

    // Load/Store
    assign c_lw = upper3_2 & c0_format;
    assign c_sw = upper3_6 & c0_format;
    assign c_flw = upper3_3 & c0_format;
    assign c_fsw = upper3_7 & c0_format;
    assign c_fld = upper3_1 & c0_format;
    assign c_fsd = upper3_5 & c0_format;
    assign c_lwsp = upper3_2 & c2_format;
    assign c_swsp = upper3_6 & c2_format;   
    assign c_flwsp = upper3_3 & c2_format;
    assign c_fswsp = upper3_7 & c2_format; 
    assign c_fldsp = upper3_1 & c2_format;
    assign c_fsdsp = upper3_5 & c2_format; 

    // Control Transfer
    assign c_j = upper3_5 & c1_format;
    assign c_jal = upper3_1 & c1_format;
    assign c_jr = upper3_4 & inst16[12] == 1'b0 & inst16[6:2] == 5'd0 & c2_format;
    assign c_jalr = upper3_4 & c2_format & inst16[12] & inst16[6:2] == 5'd0 & inst16[11:7] != 5'd0;
    assign c_beqz = upper3_6 & c1_format;
    assign c_bnez = upper3_7 & c1_format; 

    // Constant Generation
    assign c_li = upper3_2 & c1_format;
    assign c_lui = upper3_3 & (inst16[11:7] != 5'd0) & (inst16[11:7] != 5'd2) & c1_format;

    // Others
    //assign illegal = inst16 == 16'd0;
    assign c_nop = upper3_0 & (inst16[11:7] == 5'd0) & c1_format;
    assign c_ebreak = upper3_4 & c2_format & inst16[12] & inst16[11:2] == 10'd0;

    // Inst type
    assign rtype = c_mv | c_add | c_and | c_or | c_xor | c_sub;
    assign itype = c_addi | c_addi16sp | c_addi14spn | c_slli | c_andi | c_srli | c_lw | c_flw | c_lwsp | c_flwsp | c_li | c_nop | c_srai | c_fld | c_fldsp;
    assign stype = c_sw | c_swsp | c_fsw | c_fswsp | c_fsd | c_fsdsp;
    assign btype = c_beqz | c_bnez;
    assign utype = c_lui;
    assign jtype = c_j | c_jal | c_jr | c_jalr;

    assign imm_i_c = {inst16[12], inst16[6:2]};
    assign imm_j = {inst16[12], inst16[8], inst16[10:9], inst16[6], inst16[7], inst16[2], inst16[11], inst16[5:3]};
    assign imm_b = {inst16[12], inst16[6:5], inst16[2], inst16[11:10], inst16[4:3]}; 
    assign offset_c = {inst16[5], inst16[12:10], inst16[6]};
    assign offset_csp = (c_swsp | c_fswsp) ? {inst16[8:7], inst16[12:9]} : {inst16[3:2], inst16[12], inst16[6:4]};
    assign offset_c_df = {inst16[6:5], inst16[12:10]};
    assign offset_csp_df = c_fsdsp ? {inst16[9:7], inst16[12:10]} : {inst16[4:2], inst16[12], inst16[6:5]};

    // Sign Extend immediate 
    always_comb begin
        if (c_srai) imm_i = {7'b0100000, imm_i_c[4:0]};
 	else if (c_srli | c_slli) imm_i = {7'b0000000, imm_i_c[4:0]};
	else if (c_addi16sp) imm_i = {{2{inst16[12]}}, {inst16[12], inst16[4:3], inst16[5], inst16[2], inst16[6]}, 4'd0};
	else if (c_addi14spn) imm_i = {{2{inst16[12]}}, {inst16[10:7], inst16[12], inst16[11], inst16[5], inst16[6]}, 2'd0};
        else imm_i = {{6{imm_i_c[5]}}, imm_i_c};
    end

    // Sign Extend offset
    assign offset = (c_sw | c_lw | c_fsw | c_flw) ? {5'd0, offset_c, 2'd0} : {4'd0, offset_csp, 2'd0};
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
 	else if (c_fld| c_fsd | c_fldsp | c_fsdsp) funct3 = 3'b011;
        else funct3 = 3'b000;
    end

    // Select register
    assign rd = (c_srli | c_srli | c_srai | c_and | c_or | c_xor | c_sub | c_sw | c_lw | c_fsw | c_fsd | c_flw | c_fld | c_beqz | c_bnez | c_andi) ? {2'd0, inst16[9:7]} : inst16[11:7];
    assign rs2 = (c_mv |  c_add) ? inst16[6:2] : {2'd0, inst16[4:2]};

    // Encode full 32 bit instruction
    always_comb begin
        if (rtype) begin
	    if (c_sub) inst32 = {7'b0100000, rs2, rd, funct3, rd, 7'b0110011};
	    else if (c_mv) inst32 = {7'b0000000, rs2, 5'd0, funct3, rd, 7'b0110011};
	    else inst32 = {7'b0000000, rs2, rd, funct3, rd, 7'b0110011};
        end else if (itype) begin 
   	    if (c_addi16sp) inst32 = {imm_i, 5'd2, funct3, 5'd2, 7'b0010011};
   	    else if (c_addi14spn) inst32 = {imm_i, 5'd2, funct3, {2'd0, inst16[4:2]}, 7'b0010011};
   	    else if (c_li) inst32 = {imm_i, 5'd0, funct3, rd, 7'b0010011};
   	    else if (c_lw) inst32 = {offset, rd, funct3, {2'd0, inst16[4:2]}, 7'b0000011};
   	    else if (c_flw) inst32 = {offset, rd, funct3, {2'd0, inst16[4:2]}, 7'b0000111};
   	    else if (c_fld) inst32 = {offset_df, rd, funct3, {2'd0, inst16[4:2]}, 7'b0000111};
   	    else if (c_lwsp) inst32 = {offset, 5'd2, funct3, rd, 7'b0000011};
   	    else if (c_flwsp) inst32 = {offset, 5'd2, funct3, rd, 7'b0000111};
   	    else if (c_fldsp) inst32 = {offset_df, 5'd2, funct3, rd, 7'b0000111};
   	    else if (c_nop) inst32 = {17'd0, funct3, 5'd0, 7'b0010011};
 	    else inst32 = {imm_i, rd, funct3, rd, 7'b0010011};
        end else if (stype) begin
	    if (c_sw) inst32 = {offset[11:5], {2'd0, inst16[4:2]}, rd, funct3, offset[4:0], 7'b0100011};
	    else if (c_fsw) inst32 = {offset[11:5], {2'd0, inst16[4:2]}, rd, funct3, offset[4:0], 7'b0100111};
	    else if (c_fsd) inst32 = {offset_df[11:5], {2'd0, inst16[4:2]}, rd, funct3, offset_df[4:0], 7'b0100111};
	    else if (c_fswsp) inst32 = {offset[11:5], inst16[6:2], 5'd2, funct3, offset[4:0], 7'b0100111};
	    else if (c_fsdsp) inst32 = {offset_df[11:5], inst16[6:2], 5'd2, funct3, offset_df[4:0], 7'b0100111};
	    else inst32 = {offset[11:5], inst16[6:2], 5'd2, funct3, offset[4:0], 7'b0100011};
        end else if (btype) inst32 = {branch_offset[12], branch_offset[10:5], 5'd0, rd, funct3, branch_offset[4:1], branch_offset[11], 7'b1100011};
        else if (utype) inst32 = {{{14{imm_i_c[5]}}, imm_i_c}, rd, 7'b0110111};
        else if (jtype) begin
	    if (c_j) inst32 = {jump_offset[20], jump_offset[10:1], jump_offset[11], jump_offset[19:12], 5'd0, 7'b1101111};
	    else if (c_jal) inst32 = {jump_offset[20], jump_offset[10:1], jump_offset[11], jump_offset[19:12], 5'd1, 7'b1101111};
	    else if (c_jr) inst32 = {12'd0, rd, 3'd0, 5'd0, 7'b1100111};
	    else inst32 = {12'd0, rd, 3'd0, 5'd1, 7'b1100111};
	end else if (c_ebreak) inst32 = {12'b000000000001, 5'd0, 3'd0, 5'd0, 7'b1110011};
   	else inst32 = 32'd0;
    end
endmodule

