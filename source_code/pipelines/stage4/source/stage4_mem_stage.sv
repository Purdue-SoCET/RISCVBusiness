
`include "stage4_hazard_unit_if.vh"
`include "stage4_mem_pipe_if.vh"
`include "generic_bus_if.vh"
`include "predictor_pipeline_if.vh"
`include "cache_control_if.vh"
`include "prv_pipeline_if.vh"

module stage4_mem_stage(
    input CLK,
    input nRST,
    stage4_mem_pipe_if.mem ex_mem_if,
    stage4_hazard_unit_if.mem hazard_if,
    stage4_forwarding_unit_if.mem fw_if,
    generic_bus_if.cpu dgen_bus_if,
    prv_pipeline_if.pipe prv_pipe_if,
    cache_control_if.pipeline cc_if,
    predictor_pipeline_if.update predict_if,
    output logic halt,
    output logic wfi
);

    import rv32i_types_pkg::*;
    import pma_types_1_12_pkg::*;

    /***************
    * Branch Update
    ****************/
    assign predict_if.update_predictor = ex_mem_if.ex_mem_reg.branch;
    assign predict_if.prediction = ex_mem_if.ex_mem_reg.prediction;
    assign predict_if.branch_result = ex_mem_if.ex_mem_reg.branch_taken;
    assign predict_if.update_addr = ex_mem_if.ex_mem_reg.brj_addr;




    /*************
    * Data Access
    **************/
    word_t store_swapped;
    word_t dload_ext;
    logic mal_addr;
    logic [1:0] byte_offset;
    logic [3:0] byte_en, byte_en_temp, byte_en_standard;



    // TODO: RISC-MGMT
    assign dgen_bus_if.ren = ex_mem_if.ex_mem_reg.dren && !hazard_if.suppress_data;
    assign dgen_bus_if.wen = ex_mem_if.ex_mem_reg.dwen && !hazard_if.suppress_data;
    assign dgen_bus_if.byte_en = byte_en;
    assign dgen_bus_if.addr = ex_mem_if.ex_mem_reg.port_out;
    assign byte_offset = ex_mem_if.ex_mem_reg.port_out[1:0];

    // TODO: RISC-MGMT
    assign byte_en_temp = byte_en_standard;

    // Address alignment
    always_comb begin
        if (byte_en == 4'hf) mal_addr = (dgen_bus_if.addr[1:0] != 2'b00);
        else if (byte_en == 4'h3 || byte_en == 4'hc) begin
            mal_addr = (dgen_bus_if.addr[1:0] == 2'b01 || dgen_bus_if.addr[1:0] == 2'b11);
        end else mal_addr = 1'b0;
    end

    endian_swapper store_swap(
        .word_in(ex_mem_if.ex_mem_reg.rs2_data),
        .word_out(store_swapped)
    );

    dmem_extender dmem_ext(
        .dmem_in(dgen_bus_if.rdata),
        .load_type(ex_mem_if.ex_mem_reg.load_type),
        .byte_en(byte_en),
        .ext_out(dload_ext)
    );

    always_comb begin : LOAD_TYPE
        case (ex_mem_if.ex_mem_reg.load_type)
            LB, LBU: begin
                case (byte_offset)
                    2'b00:   byte_en_standard = 4'b0001;
                    2'b01:   byte_en_standard = 4'b0010;
                    2'b10:   byte_en_standard = 4'b0100;
                    2'b11:   byte_en_standard = 4'b1000;
                    default: byte_en_standard = 4'b0000;
                endcase
            end

            LH, LHU: begin
                case (byte_offset)
                    2'b00:   byte_en_standard = 4'b0011;
                    2'b10:   byte_en_standard = 4'b1100;
                    default: byte_en_standard = 4'b0000;
                endcase
            end

            LW: begin
                byte_en_standard = 4'b1111;
            end

            default: byte_en_standard = 4'b0000;
        endcase
    end : LOAD_TYPE

    // TODO: RISC-MGMT
    always_comb begin : STORE_TYPE
        case(ex_mem_if.ex_mem_reg.load_type)
            LB: dgen_bus_if.wdata = {4{ex_mem_if.ex_mem_reg.rs2_data[7:0]}};
            LH: dgen_bus_if.wdata = {2{ex_mem_if.ex_mem_reg.rs2_data[15:0]}};
            LW: dgen_bus_if.wdata = ex_mem_if.ex_mem_reg.rs2_data;
            default: dgen_bus_if.wdata = '0;
        endcase
    end : STORE_TYPE

    // Endianness
    generate
        if(BUS_ENDIANNESS == "big") begin : g_data_bus_be
            assign byte_en = byte_en_temp;
        end else if(BUS_ENDIANNESS == "little") begin : g_data_bus_le
            assign byte_en = ex_mem_if.ex_mem_reg.dren ? byte_en_temp
                                                    : {byte_en_temp[0], byte_en_temp[1],
                                                       byte_en_temp[2], byte_en_temp[3]};
        end
    endgenerate


    /******************
    * Cache management
    *******************/
    logic ifence_reg;
    logic ifence_pulse;
    logic iflushed, iflushed_next;
    logic dflushed, dflushed_next;
    logic iflush_done_reg, dflush_done_reg;

    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            ifence_reg <= 1'b0;
            iflushed <= 1'b1;
            dflushed <= 1'b1;
        end else begin
            ifence_reg <= ex_mem_if.ex_mem_reg.ifence;
            iflushed <= iflushed_next;
            dflushed <= dflushed_next;
        end
    end

    assign ifence_pulse  = ex_mem_if.ex_mem_reg.ifence & ~ifence_reg;
    assign cc_if.icache_flush = ifence_pulse;
    assign cc_if.dcache_flush = ifence_pulse;
    // holds iflushed/dflushed high when done, resets to 0 on a pulse
    always_comb begin
        iflushed_next = iflushed;
        dflushed_next = dflushed;
        if (ifence_pulse) begin
            iflushed_next = 0;
            dflushed_next = 0;
        end
        if (cc_if.iflush_done)
            iflushed_next = 1;
        if (cc_if.dflush_done)
            dflushed_next = 1;
    end

    /************************
    * Hazard/Forwarding Unit
    *************************/
    // Note: Some hazard unit signals are assigned below in the CSR section
    assign hazard_if.d_mem_busy = dgen_bus_if.busy;
    assign hazard_if.ifence = ex_mem_if.ex_mem_reg.ifence;
    assign hazard_if.fence_stall = ifence_reg && !(iflushed && dflushed);
    assign hazard_if.dren = ex_mem_if.ex_mem_reg.dren;
    assign hazard_if.dwen = ex_mem_if.ex_mem_reg.dwen;
    assign hazard_if.jump = ex_mem_if.ex_mem_reg.jump;
    assign hazard_if.branch = ex_mem_if.ex_mem_reg.branch;
    assign hazard_if.halt = ex_mem_if.ex_mem_reg.halt;
    assign hazard_if.rd_m = ex_mem_if.ex_mem_reg.rd_m;
    assign hazard_if.reg_write = ex_mem_if.ex_mem_reg.reg_write;
    assign hazard_if.csr_read = prv_pipe_if.valid_write;
    assign hazard_if.token_mem = 0; // TODO: RISC-MGMT
    assign hazard_if.mispredict = ex_mem_if.ex_mem_reg.prediction ^ ex_mem_if.ex_mem_reg.branch_taken;
    //assign hazard_if.pc = ex_mem_if.ex_mem_reg.pc;

    assign halt = ex_mem_if.ex_mem_reg.halt;
    assign fw_if.rd_m = ex_mem_if.ex_mem_reg.rd_m;
    assign fw_if.reg_write = ex_mem_if.reg_write;
    assign fw_if.load = (ex_mem_if.ex_mem_reg.dren || ex_mem_if.ex_mem_reg.dwen);


    /******
    * CSRs
    *******/
    assign prv_pipe_if.swap = ex_mem_if.ex_mem_reg.csr_swap;
    assign prv_pipe_if.clr = ex_mem_if.ex_mem_reg.csr_clr;
    assign prv_pipe_if.set = ex_mem_if.ex_mem_reg.csr_set;
    assign prv_pipe_if.read_only = ex_mem_if.ex_mem_reg.csr_read_only;
    assign prv_pipe_if.wdata = ex_mem_if.ex_mem_reg.csr_imm ? {27'h0, ex_mem_if.ex_mem_reg.zimm} : ex_mem_if.ex_mem_reg.rs1_data;
    assign prv_pipe_if.csr_addr = ex_mem_if.ex_mem_reg.csr_addr;
    assign prv_pipe_if.valid_write = (prv_pipe_if.swap | prv_pipe_if.clr
                                        | prv_pipe_if.set) & ~hazard_if.ex_mem_stall;
    assign prv_pipe_if.instr = (ex_mem_if.ex_mem_reg.instr != '0);

    assign hazard_if.fault_insn = ex_mem_if.ex_mem_reg.fault_insn;
    assign hazard_if.mal_insn = ex_mem_if.ex_mem_reg.mal_insn;
    assign hazard_if.illegal_insn = ex_mem_if.ex_mem_reg.illegal_insn || prv_pipe_if.invalid_priv_isn;
    assign hazard_if.fault_l = ex_mem_if.ex_mem_reg.dren && dgen_bus_if.error;
    assign hazard_if.mal_l = ex_mem_if.ex_mem_reg.dren & mal_addr;
    assign hazard_if.fault_s = ex_mem_if.ex_mem_reg.dwen && dgen_bus_if.error;
    assign hazard_if.mal_s = ex_mem_if.ex_mem_reg.dwen & mal_addr;
    assign hazard_if.breakpoint = ex_mem_if.ex_mem_reg.breakpoint;
    assign hazard_if.env = ex_mem_if.ex_mem_reg.ecall_insn;
    assign hazard_if.ret = ex_mem_if.ex_mem_reg.ret_insn;
    assign hazard_if.wfi = ex_mem_if.ex_mem_reg.wfi_insn;
    assign hazard_if.badaddr = (hazard_if.fault_insn || hazard_if.mal_insn) ? ex_mem_if.ex_mem_reg.badaddr : dgen_bus_if.addr;

    // NEW
    assign hazard_if.pc_m = ex_mem_if.ex_mem_reg.pc;
    assign hazard_if.valid_m = ex_mem_if.ex_mem_reg.valid;
    assign ex_mem_if.pc4 = ex_mem_if.ex_mem_reg.pc4;

    // Memory protection (doesn't consider RISC-MGMT)
    assign prv_pipe_if.dren  = ex_mem_if.ex_mem_reg.dren;
    assign prv_pipe_if.dwen  = ex_mem_if.ex_mem_reg.dwen;
    assign prv_pipe_if.daddr = ex_mem_if.ex_mem_reg.port_out;
    assign prv_pipe_if.d_acc_width = WordAcc;

    // TODO: Currently omitting SparCE

    /***********
    * Writeback
    ************/
    assign ex_mem_if.brj_addr = ex_mem_if.ex_mem_reg.brj_addr;
    assign ex_mem_if.reg_write = ex_mem_if.ex_mem_reg.reg_write;
    assign ex_mem_if.rd_m = ex_mem_if.ex_mem_reg.rd_m;

    always_comb begin
        // TODO: RISC-MGMT
        case (ex_mem_if.ex_mem_reg.w_sel)
            3'd0:    ex_mem_if.reg_wdata = dload_ext;
            3'd1:    ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.pc4;
            3'd2:    ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.imm_U;
            3'd3:    ex_mem_if.reg_wdata = ex_mem_if.ex_mem_reg.port_out;
            3'd4:    ex_mem_if.reg_wdata = prv_pipe_if.rdata;
            default: ex_mem_if.reg_wdata = '0;
        endcase

        // Forwarding unit
        case (ex_mem_if.ex_mem_reg.w_sel)
            3'd1:    fw_if.rd_mem_data = ex_mem_if.ex_mem_reg.pc4;
            3'd2:    fw_if.rd_mem_data = ex_mem_if.ex_mem_reg.imm_U;
            3'd3:    fw_if.rd_mem_data = ex_mem_if.ex_mem_reg.port_out;
            3'd4:    fw_if.rd_mem_data = prv_pipe_if.rdata;
            default: fw_if.rd_mem_data = '0;
        endcase
    end

    /**************
    * CPU Tracking
    ***************/
    logic wb_stall;
    logic [2:0] funct3;
    logic [11:0] funct12;
    logic instr_30;

    // TODO: Fix up hazard unit
    assign funct3 = ex_mem_if.ex_mem_reg.instr[14:12];
    assign funct12 = ex_mem_if.ex_mem_reg.instr[31:20];
    assign instr_30 = ex_mem_if.ex_mem_reg.instr[30];
    assign wb_stall = hazard_if.ex_mem_stall & ~hazard_if.jump & ~hazard_if.branch; // TODO: Is this right?


endmodule
