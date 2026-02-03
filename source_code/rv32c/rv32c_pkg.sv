
package rv32c_pkg;
    // op bits
    localparam logic [1:0]  RVC_C0 = 2'b00,
                            RVC_C1 = 2'b01,
                            RVC_C2 = 2'b10;

    // func bits, CR format
    localparam logic [3:0]  RVC_CR_FUNC_EBREAK  = 4'b1001,
                            RVC_CR_FUNC_ADD     = 4'b1001,
                            RVC_CR_FUNC_JALR    = 4'b1001,
                            RVC_CR_FUNC_MV      = 4'b1000,
                            RVC_CR_FUNC_JR      = 4'b1000;

    localparam logic [2:0]  RVC_CIW_FUNC_ADDI4SPN = 3'b000;

                            // CL-type
    localparam logic [2:0]  RVC_CL_FUNC_FLD = 3'b001,
                            RVC_CL_FUNC_LQ  = 3'b001,
                            RVC_CL_FUNC_LW  = 3'b010,
                            RVC_CL_FUNC_FLW = 3'b011,
                            RVC_CL_FUNC_LD  = 3'b011,
                            // CS-type
                            RVC_CS_FUNC_FSD = 3'b101,
                            RVC_CS_FUNC_FSQ = 3'b101,
                            RVC_CS_FUNC_SW  = 3'b110,
                            RVC_CS_FUNC_FSW = 3'b111,
                            RVC_CS_FUNC_SD  = 3'b111;

    localparam logic [2:0]  RVC_CI_FUNC_ADDI     = 3'b000,
                            RVC_CI_FUNC_NOP      = 3'b000,
                            RVC_CI_FUNC_ADDIW    = 3'b001,
                            RVC_CI_FUNC_ADDI16SP = 3'b011,
                            RVC_CI_FUNC_LI       = 3'b010,
                            RVC_CI_FUNC_LUI      = 3'b011,
                            RVC_CI_FUNC_SRLI     = 3'b100,
                            RVC_CI_FUNC_SRAI     = 3'b100,
                            RVC_CI_FUNC_SLLI     = 3'b000,
                            // SP-relative load/store
                            RVC_CI_FUNC_FLDSP    = 3'b001,
                            RVC_CI_FUNC_LWSP     = 3'b010,
                            RVC_CI_FUNC_FLWSP    = 3'b011,
                            RVC_CI_FUNC_LDSP     = 3'b011,
                            RVC_CI_FUNC_FSDSP    = 3'b101,
                            RVC_CI_FUNC_SWSP     = 3'b110,
                            RVC_CI_FUNC_FSWSP    = 3'b111,
                            RVC_CI_FUNC_SDSP     = 3'b111;

    localparam logic [7:0]  RVC_CA_FUNC_SUB      = 8'b1000_1100,
                            RVC_CA_FUNC_XOR      = 8'b1000_1101,
                            RVC_CA_FUNC_OR       = 8'b1000_1110,
                            RVC_CA_FUNC_AND      = 8'b1000_1111,
                            RVC_CA_FUNC_SUBW     = 8'b1001_1100,
                            RVC_CA_FUNC_ADDW     = 8'b1001_1101;

    localparam logic [2:0]  RVC_CB_FUNC_BEQZ     = 3'b110,
                            RVC_CB_FUNC_BNEZ     = 3'b111,
                            RVC_CB_FUNC_ANDI     = 3'b100;

    localparam logic [2:0]  RVC_CJ_FUNC_J        = 3'b101,
                            RVC_CJ_FUNC_JAL      = 3'b001;


    localparam logic [31:0] UNIMP = 32'h0;

    function automatic logic [4:0] decompress_regselect(logic [2:0] rs);
        // 000 -> x8 (f8)
        // 001 -> x9 (f9)
        // ...
        // 111 -> x15 (f15)
        // below equivalent to 5'd8 + rs
        return {2'b01, rs};
    endfunction

    typedef struct packed {
        logic [15 : 12] funct4;
        logic [11 : 7]  rs1; // full-size
        logic [6 : 2]   rs2; // full-size
        logic [1 : 0]   op;
    } rvc_cr_t;

    function automatic logic [31:0] decompress_cr(logic [15:0] compressed);
        // C.JR, C.JALR, C.MV, C.ADD, C.EBREAK
        // CR-format is always op == C2.
        // CR-format has 2 valid functs, overloaded to 5 insns
        rvc_cr_t ifmt = compressed;
        assert(ifmt.op == RVC_C2);
        assert(ifmt.funct4 == RVC_CR_FUNC_ADD || ifmt.funct4 == RVC_CR_FUNC_MV);

        // instruction determined on rs1/rs2
        // C.ADD/C.MV: rs2 != 0. rs1 != 0 -> HINT
        // C.JR/C.JALR: rs2 == 0 && rs1 != 0
        // C.EBREAK: rs1 == rs2 == 0
        if(ifmt.funct4 == RVC_CR_FUNC_EBREAK && ifmt.rs1 == 0 && ifmt.rs2 == 0) begin
            // C.EBREAK
            rv32i_types_pkg::systype_t ofmt;
            ofmt.csr = rv32i_types_pkg::EBREAK;
            ofmt.rs1_zimm = 5'd0;
            ofmt.funct3 = rv32i_types_pkg::PRIV;
            ofmt.rd = 5'd0;
            ofmt.opcode = rv32i_types_pkg::SYSTEM;

            return ofmt;
        end else if(ifmt.rs2 == 0) begin
            // C.JR -> jalr x0, 0(rs1)
            // C.JALR -> jalr x1, 0(rs1)
            // C.JR x0 is reserved
            rv32i_types_pkg::itype_t ofmt;
            ofmt.imm11_00 = 12'h0;
            ofmt.rs1 = ifmt.rs1;
            ofmt.funct3 = 3'b000;
            ofmt.rd = (ifmt.funct4 == RVC_CR_FUNC_JALR) ? 5'd1 : 5'd0;
            ofmt.opcode = rv32i_types_pkg::JALR;

            // jalr rd, imm(x0) is reserved
            if(ifmt.funct4 == RVC_CR_FUNC_JR && ifmt.rs1 == 5'd0) begin
                return UNIMP;
            end

            return ofmt;
        end else begin
            // C.ADD -> add rs1, rs1, rs2
            // C.MV  -> add rs1, x0, rs2
            // C.ADD and C.MV with rs1 (rd) set to 0 is HINT
            rv32i_types_pkg::rtype_t ofmt;
            ofmt.funct7 = 7'b000_0000;
            ofmt.rs2 = ifmt.rs2;
            ofmt.rs1 = (ifmt.funct4 == RVC_CR_FUNC_ADD) ? ifmt.rs1 : 5'd0;
            ofmt.funct3 = rv32i_types_pkg::ADDSUB;
            ofmt.rd = ifmt.rs1;
            ofmt.opcode = rv32i_types_pkg::REGREG;

            return ofmt;
        end
    endfunction


    typedef struct packed {
        logic [15:13] funct3;
        logic [12:5] nzuimm;
        logic [4:2] rd;
        logic [1:0] op;
    } rvc_ciw_t;

    function automatic logic [31:0] decompress_ciw(logic [15:0] compress);
        // only ADDI4SPN -> addi rd', x2, imm
        rvc_ciw_t ifmt = compress;
        rv32i_types_pkg::itype_t ofmt;
        assert(ifmt.op == RVC_C0 && ifmt.funct3 == RVC_CIW_FUNC_ADDI4SPN);

        // canonical illegal instruction
        if(compress == 16'b0) begin
            return UNIMP;
        // addi4spn rd != 0, 0 is reserved
        end else if(ifmt.nzuimm == 0) begin
            return UNIMP;
        end

        ofmt.imm11_00 = {2'b00, ifmt.nzuimm[10:7], ifmt.nzuimm[12:11], ifmt.nzuimm[5], ifmt.nzuimm[6], 2'b00};
        ofmt.rs1 = 5'd2;
        ofmt.funct3 = rv32i_types_pkg::ADDI;
        ofmt.rd = decompress_regselect(ifmt.rd);
        ofmt.opcode = rv32i_types_pkg::IMMED;

        return ofmt;
    endfunction

    // CL and CS are same format,
    // just rd vs. rs2
    typedef struct packed {
        logic [15:13] funct3;
        logic [12:10] imm3;
        logic [9:7] rs1;
        logic [6:5] imm2;
        logic [4:2] rs2;
        logic [1:0] op;
    } rvc_cl_cs_t;

    function automatic logic [31:0] decompress_cl(logic [15:0] compressed);
        // CL format is register-based loads
        // CL format are C0 op
        // CL and CS are *heavily* overloaded
        // based on RV32/64/128. This assumes
        // RV32 *only* for now.
        rvc_cl_cs_t ifmt = compressed;
        rv32i_types_pkg::itype_t ofmt;
        assert(ifmt.op == RVC_C0
                && ifmt.funct3 != 3'b000
                && ifmt.funct3 != 3'b100
                && ifmt.funct3[15] == 1'b0);

        ofmt.imm11_00 = (ifmt.funct3 == RVC_CL_FUNC_FLD)
                        ? {4'b0000, ifmt.imm2, ifmt.imm3, 3'b000}
                        : {5'b0000, ifmt.imm2[5], ifmt.imm3, ifmt.imm2[6], 2'b00};
        ofmt.rs1 = decompress_regselect(ifmt.rs1);
        ofmt.funct3 = (ifmt.funct3 == RVC_CL_FUNC_LW || ifmt.funct3 == RVC_CL_FUNC_FLW)
                        ? rv32i_types_pkg::LW
                        : rv32i_types_pkg::LD;
        ofmt.rd  = decompress_regselect(ifmt.rs2);
        ofmt.opcode = (ifmt.funct3 == RVC_CL_FUNC_FLD || ifmt.funct3 == RVC_CL_FUNC_FLW)
                        ? rv32i_types_pkg::LOAD_FP
                        : rv32i_types_pkg::LOAD;


        return ofmt;
    endfunction

    function automatic logic [31:0] decompress_cs(logic [15:0] compressed);
        // CS format is register-based stores
        // CS format are C0 op
        // CL and CS are *heavily* overloaded
        // based on RV32/64/128. This assumes
        // RV32 *only* for now.
        rvc_cl_cs_t ifmt = compressed;
        rv32i_types_pkg::stype_t ofmt;
        logic [11:0] imm12;
        assert(ifmt.op == RVC_C0 && ifmt.funct3 != 3'b000 && ifmt.funct3 != 3'b100 && ifmt.funct3[15] == 1'b1);

        // layout: hi - imm[5:3], lo - imm[2|6] for SW, imm[7:6] for SD
        // ignore SD -- RV64 only, overlaps FLW
        imm12 = (ifmt.funct3 == RVC_CS_FUNC_FSD)
                        ? {4'b0000, ifmt.imm2, ifmt.imm3, 3'b000}
                        : {5'b00000, ifmt.imm2[5], ifmt.imm3, ifmt.imm2[6], 2'b00};
        ofmt.imm11_05 = imm12[11:5];
        ofmt.imm04_00 = imm12[4:0];
        ofmt.rs1 = decompress_regselect(ifmt.rs1);
        ofmt.funct3 = (ifmt.funct3 == RVC_CS_FUNC_SW || ifmt.funct3 == RVC_CS_FUNC_FSW)
                        ? rv32i_types_pkg::SW
                        : rv32i_types_pkg::SD;
        ofmt.rs2 = decompress_regselect(ifmt.rs2);
        ofmt.opcode = (ifmt.funct3 == RVC_CS_FUNC_FSD || ifmt.funct3 == RVC_CS_FUNC_FSW)
                        ? rv32i_types_pkg::STORE_FP
                        : rv32i_types_pkg::STORE;

        return ofmt;
    endfunction

    typedef struct packed {
        logic [15:13] funct3;
        logic imm1;
        logic [11:7] rd;
        logic [6:2] imm5;
        logic [1:0] op;
    } rvc_ci_t;

    function automatic logic [31:0] decompress_ci_load(logic [15:0] compressed);
        rvc_ci_t ifmt = compressed;
        rv32i_types_pkg::itype_t ofmt;
        assert(ifmt.op == RVC_C2);
        assert(ifmt.funct3 == RVC_CI_FUNC_LWSP
            || ifmt.funct3 == RVC_CI_FUNC_FLWSP
            || ifmt.funct3 == RVC_CI_FUNC_FLDSP);

        // lw -> lw rd, offset(x2)
        ofmt.imm11_00 = (ifmt.funct3 == RVC_CI_FUNC_LWSP || ifmt.funct3 == RVC_CI_FUNC_FLWSP)
                        ? {4'h0, ifmt.imm5[3:2], ifmt.imm1, ifmt.imm5[6:4], 2'b00}
                        : {3'b000, ifmt.imm5[4:2], ifmt.imm1, ifmt.imm5[6:5], 3'b000};
        ofmt.rs1 = 5'd2;
        ofmt.funct3 = (ifmt.funct3 == RVC_CI_FUNC_LWSP || ifmt.funct3 == RVC_CI_FUNC_FLWSP)
                        ? rv32i_types_pkg::LW
                        : 3'b011;
        ofmt.rd  = ifmt.rd;
        ofmt.opcode = (ifmt.funct3 == RVC_CI_FUNC_LWSP)
                    ? rv32i_types_pkg::LOAD
                    : rv32i_types_pkg::LOAD_FP;

        // lwsp x0, imm is reserved
        if(ifmt.funct3 == RVC_CI_FUNC_LWSP && ifmt.rd == 5'd0) begin
            return UNIMP;
        end

        return ofmt;
    endfunction

    // FIXME: Missing instructions
    function automatic logic [31:0] decompress_ci_arith(logic [15:0] compressed);
        rvc_ci_t ifmt = compressed;
        // C.ADDI -> addi rd, rd, imm
        // C.ADDIW is C.JAL in RV32C, a CJ-type instruction
        // C.ADDI16SP -> addi x2, x2, imm
        // C.SRLI -> srli rd', rd', shamt
        // C.SRAI -> srai rd', rd', shamt
        //              sr*i uses different encoding where
        //              top 2b of rd are func2, rd is a 3b
        //              compressed register name
        // C.SLLI -> slli rd', rd', shamt
        //              shamt[5] == 0, shamt[5] == 1 -> CUSTOM
        //              rd == 0 -> HINT (unless shamt[5] == 1)
        // C.LI   -> addi rd, x0, imm (rd == x0 -> HINT)
        // C.LUI  -> lui rd, imm (rd != {x0, x2}, imm != 0)
        //              rd == x0 -> HINT
        //              imm == 0 -> RESERVED
        //              rd == x2 -> C.ADDI16SP
        // C.NOP -> nop (addi x0, x0, 0)
        assert((ifmt.op == RVC_C2 && ifmt.funct3 == RVC_CI_FUNC_SLLI)
            || ifmt.op == RVC_C1);

        if(ifmt.op == RVC_C1 &&
            (ifmt.funct3 == RVC_CI_FUNC_ADDI
            || ifmt.funct3 == RVC_CI_FUNC_NOP
            || ifmt.funct3 == RVC_CI_FUNC_LI)) begin
            rv32i_types_pkg::itype_t ofmt;
            ofmt.imm11_00 = {{6{ifmt.imm1}}, ifmt.imm1, ifmt.imm5};
            ofmt.funct3 = rv32i_types_pkg::ADDI;
            ofmt.rs1 = (ifmt.funct3 == RVC_CI_FUNC_LI) ? 5'h0 : ifmt.rd;
            ofmt.rd = ifmt.rd;
            ofmt.opcode = rv32i_types_pkg::IMMED;

            return ofmt;
        end else if(ifmt.funct3 == RVC_CI_FUNC_SLLI
                    || ifmt.funct3 == RVC_CI_FUNC_SRLI
                    || ifmt.funct3 == RVC_CI_FUNC_SRAI) begin
            rv32i_types_pkg::itype_t ofmt;
            logic is_sra = (ifmt.funct3 == RVC_CI_FUNC_SRAI) && ifmt.rd[11:10] == 2'b01;
            logic is_srl = (ifmt.funct3 == RVC_CI_FUNC_SRLI) && ifmt.rd[11:10] == 2'b00;
            logic is_sll = (ifmt.funct3 == RVC_CI_FUNC_SLLI) && ifmt.op == RVC_C2;
            //assert(is_sra || is_srl || is_sll);
            ofmt.imm11_00 = is_sra
                                ? {6'b01_0000, ifmt.imm1, ifmt.imm5}
                                : {6'b00_0000, ifmt.imm1, ifmt.imm5};
            ofmt.rs1 = (is_sra || is_srl)
                        ? decompress_regselect(ifmt.rd[9:7])
                        : ifmt.rd;
            ofmt.rd = ofmt.rs1;
            ofmt.funct3 = (ifmt.funct3 == RVC_CI_FUNC_SLLI)
                        ? rv32i_types_pkg::SLLI
                        : rv32i_types_pkg::SRI;
            ofmt.opcode = rv32i_types_pkg::IMMED;

            return ofmt;
        end else if(ifmt.funct3 == RVC_CI_FUNC_ADDI16SP
            && ifmt.rd == 5'd2) begin
            rv32i_types_pkg::itype_t ofmt;
            // immediate is sign-extended
            ofmt.imm11_00 = {{2{ifmt.imm1}}, ifmt.imm1, ifmt.imm5[4:3], ifmt.imm5[5],
                ifmt.imm5[2], ifmt.imm5[6], 4'h0};
            ofmt.funct3 = rv32i_types_pkg::ADDI;
            ofmt.rs1 = 5'd2;
            ofmt.rd = 5'd2;
            ofmt.opcode = rv32i_types_pkg::IMMED;

            if({ifmt.imm1, ifmt.imm5} == 'd0) begin
                return UNIMP;
            end

            return ofmt;
        end else if(ifmt.funct3 == RVC_CI_FUNC_LUI) begin
            rv32i_types_pkg::utype_t ofmt;
            ofmt.imm31_12 = {{14{ifmt.imm1}}, ifmt.imm1, ifmt.imm5};
            ofmt.rd = ifmt.rd;
            ofmt.opcode = rv32i_types_pkg::LUI;

            // lui rd, 0 is reserved
            if({ifmt.imm1, ifmt.imm5} == 'd0) begin
                return UNIMP;
            end

            return ofmt;
        end else begin
            return UNIMP;
        end
    endfunction

    typedef struct packed {
        logic [15:13] funct3;
        logic [12:7] imm;
        logic [6:2] rs2;
        logic [1:0] op;
    } rvc_css_t;

    function automatic logic [31:0] decompress_css(logic [15:0] compressed);
        rvc_css_t ifmt = compressed;
        rv32i_types_pkg::stype_t ofmt;
        logic [11:0] imm;

        assert(ifmt.op == RVC_C2);
        assert(ifmt.funct3 == RVC_CI_FUNC_SWSP
            || ifmt.funct3 == RVC_CI_FUNC_FSWSP
            || ifmt.funct3 == RVC_CI_FUNC_FSDSP);
        // sw -> sw rs2, offset(x2)
        imm = (ifmt.funct3 == RVC_CI_FUNC_SWSP || ifmt.funct3 == RVC_CI_FUNC_FSWSP)
                        ? {4'h0, ifmt.imm[8:7], ifmt.imm[12:9], 2'b00}
                        : {3'b000, ifmt.imm[9:7], ifmt.imm[12:10], 3'b000};
        ofmt.imm11_05 = imm[11:5];
        ofmt.imm04_00 = imm[4:0];
        ofmt.rs1 = 5'd2;
        ofmt.funct3 = (ifmt.funct3 == RVC_CI_FUNC_SWSP || ifmt.funct3 == RVC_CI_FUNC_FSWSP)
                        ? rv32i_types_pkg::SW
                        : 3'b011;
        ofmt.rs2  = ifmt.rs2;
        ofmt.opcode = (ifmt.funct3 == RVC_CI_FUNC_SWSP)
                    ? rv32i_types_pkg::STORE
                    : rv32i_types_pkg::STORE_FP;

        return ofmt;
    endfunction

    typedef struct packed {
        logic [15:10] funct6;
        logic [9:7] rd;
        logic [6:5] funct2;
        logic [4:2] rs2;
        logic [1:0] op;
    } rvc_ca_t;

    function automatic logic [31:0] decompress_ca(logic [15:0] compressed);
        rvc_ca_t ifmt = compressed;
        rv32i_types_pkg::rtype_t ofmt;
        logic [7:0] funct_ext = {ifmt.funct6, ifmt.funct2};

        assert(ifmt.op == RVC_C1);
        assert(ifmt.funct6[15:13] == 3'b100);

        // C.AND, C.OR, C.XOR, C.SUB, C.ADDW, C.SUBW
        // -> OP rd', rd', rs2'
        // bit 30 determines add/subtract
        // C.ADDW, C.SUBW reserved in RV32C
        ofmt.funct7 = (funct_ext == RVC_CA_FUNC_SUB) ? 7'b010_0000 : 7'b000_0000;
        ofmt.rs2 = decompress_regselect(ifmt.rs2);
        ofmt.rs1 = decompress_regselect(ifmt.rd);
        casez(funct_ext)
            RVC_CA_FUNC_AND: ofmt.funct3 = rv32i_types_pkg::AND;
            RVC_CA_FUNC_OR:  ofmt.funct3 = rv32i_types_pkg::OR;
            RVC_CA_FUNC_XOR: ofmt.funct3 = rv32i_types_pkg::XOR;
            RVC_CA_FUNC_SUB: ofmt.funct3 = rv32i_types_pkg::ADDSUB;
            default: return UNIMP;
        endcase
        ofmt.rd  = decompress_regselect(ifmt.rd);
        ofmt.opcode = rv32i_types_pkg::REGREG;

        return ofmt;
    endfunction

    typedef struct packed {
        logic [15:13] funct3;
        logic imm1;
        logic [11:10] funct2;
        logic [9:7] rd;
        logic [6:2] imm5;
        logic [1:0] op;
    } rvc_cb_t;

    function automatic logic [31:0] decompress_cb(logic [15:0] compressed);
        rvc_cb_t ifmt = compressed;
        assert(ifmt.op == RVC_C1);
        assert(ifmt.funct3 == RVC_CB_FUNC_BEQZ
            || ifmt.funct3 == RVC_CB_FUNC_BNEZ
            || (ifmt.funct3 == RVC_CB_FUNC_ANDI && ifmt.funct2 == 2'b10));


        if(ifmt.funct3 == RVC_CB_FUNC_ANDI) begin
            // C.ANDI -> andi rd', rd', imm
            rv32i_types_pkg::itype_t ofmt;
            ofmt.imm11_00 = {{6{ifmt.imm1}}, ifmt.imm1, ifmt.imm5};
            ofmt.rs1 = decompress_regselect(ifmt.rd);
            ofmt.funct3 = rv32i_types_pkg::ANDI;
            ofmt.rd  = decompress_regselect(ifmt.rd);
            ofmt.opcode = rv32i_types_pkg::IMMED;

            return ofmt;
        end else begin
            // C.BEQZ -> beq rs1', x0, offset
            // C.BNEZ -> bne rs1', x0, offset
            // CB format has 2 different formats;
            // in the branch format, 'funct2' is
            // an extension of the imm1 (imm3)
            rv32i_types_pkg::sbtype_t ofmt;
            logic [12:0] imm =
                    {{4{ifmt.imm1}}, ifmt.imm1, ifmt.imm5[6:5], ifmt.imm5[2], ifmt.funct2, ifmt.imm5[4:3], 1'b0};
            ofmt.imm12 = imm[12];
            ofmt.imm10_05 = imm[10:5];
            ofmt.rs2 = 5'd0;
            ofmt.rs1 = decompress_regselect(ifmt.rd);
            ofmt.funct3 = (ifmt.funct3 == RVC_CB_FUNC_BEQZ) ? rv32i_types_pkg::BEQ : rv32i_types_pkg::BNE;
            ofmt.imm04_01 = imm[4:1];
            ofmt.imm11 = imm[11];
            ofmt.opcode = rv32i_types_pkg::BRANCH;

            return ofmt;
        end
    endfunction

    typedef struct packed {
        logic [15:13] funct3;
        logic [12:2] imm;
        logic [1:0] op;
    } rvc_cj_t;

    function automatic logic [31:0] decompress_cj(logic [15:0] compressed);
        rvc_cj_t ifmt = compressed;
        rv32i_types_pkg::ujtype_t ofmt;
        assert(ifmt.op == RVC_C1);
        assert(ifmt.funct3 == RVC_CJ_FUNC_J || ifmt.funct3 == RVC_CJ_FUNC_JAL);
        // imm layout is [11|4|9:8|10|6|7|3:1|5]
        ofmt.imm20 = ifmt.imm[12];
        ofmt.imm10_01 =
            {ifmt.imm[8], ifmt.imm[10:9], ifmt.imm[6], ifmt.imm[7], ifmt.imm[2], ifmt.imm[11], ifmt.imm[5:3]};
        ofmt.imm11 = ifmt.imm[12];
        ofmt.imm19_12 = {8{ifmt.imm[12]}};
        ofmt.rd = (ifmt.funct3 == RVC_CJ_FUNC_JAL) ? 5'd1 : 5'd0;
        ofmt.opcode = rv32i_types_pkg::JAL;

        return ofmt;
    endfunction
endpackage
