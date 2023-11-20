
`include "stage3_hazard_unit_if.vh"
`include "stage3_mem_pipe_if.vh"
`include "generic_bus_if.vh"
`include "predictor_pipeline_if.vh"
`include "cache_control_if.vh"
`include "prv_pipeline_if.vh"
`include "load_store_controller_if.vh"

module stage3_mem_stage(
    input CLK,
    input nRST,
    stage3_mem_pipe_if.mem ex_mem_if,
    stage3_hazard_unit_if.mem hazard_if,
    stage3_forwarding_unit_if.mem fw_if,
    generic_bus_if.cpu dgen_bus_if,
    prv_pipeline_if.pipe prv_pipe_if,
    cache_control_if.pipeline cc_if,
    predictor_pipeline_if.update predict_if,
    output logic halt,
    output logic wfi
);

    import rv32i_types_pkg::*;
    import pma_types_1_12_pkg::*;
    import stage3_types_pkg::ex_mem_t;

    ex_mem_t current_instr;
    logic queue_full, mal_addr;
    logic [4:0] [3:0] queue_rd_m;
    word_t dload_ext;

    /***************
    * Branch Update
    ****************/
    assign predict_if.update_predictor = current_instr.branch;
    assign predict_if.prediction = current_instr.prediction;
    assign predict_if.branch_result = current_instr.branch_taken;
    assign predict_if.update_addr = current_instr.brj_addr;




    /*************
    * Data Access
    **************/

    load_store_controller_if lsc_if();

    assign lsc_if.ex_mem_stall = hazard_if.ex_mem_stall;
    assign lsc_if.suppress_data = hazard_if.suppress_data;
    assign lsc_if.ex_mem_reg = ex_mem_if.ex_mem_reg;
    assign current_instr = lsc_if.current_instr;
    assign queue_full = lsc_if.queue_full;
    assign mal_addr = lsc_if.mal_addr;
    assign queue_rd_m = lsc_if.queue_rd_m;
    assign dload_ext = lsc_if.dload_ext;

    load_store_controller LSC (.*);
/*
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
*/

    /******************
    * Cache management
    *******************/
/*
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
*/

    /************************
    * Hazard/Forwarding Unit
    *************************/
    // Note: Some hazard unit signals are assigned below in the CSR section
    assign hazard_if.d_mem_busy = dgen_bus_if.busy;
    assign hazard_if.ifence = current_instr.ifence;
    assign hazard_if.fence_stall = lsc_if.ifence_reg && !(lsc_if.iflushed && lsc_if.dflushed);
    assign hazard_if.dren = current_instr.dren;
    assign hazard_if.dwen = current_instr.dwen;
    assign hazard_if.jump = current_instr.jump;
    assign hazard_if.branch = current_instr.branch;
    assign hazard_if.halt = current_instr.halt;
    assign hazard_if.rd_m[0] = current_instr.rd_m;
    assign hazard_if.reg_write = current_instr.reg_write;
    assign hazard_if.csr_read = prv_pipe_if.valid_write;
    assign hazard_if.token_mem = 0; // TODO: RISC-MGMT
    assign hazard_if.mispredict = current_instr.prediction ^ current_instr.branch_taken;
    //assign hazard_if.pc = ex_mem_if.ex_mem_reg.pc;

    assign halt = current_instr.halt;
    assign fw_if.rd_m = current_instr.rd_m;
    // assign fw_if.reg_write = ex_mem_if.reg_write;
    assign fw_if.reg_write = current_instr.reg_write;
    assign fw_if.load = (current_instr.dren || current_instr.dwen);


    /******
    * CSRs
    *******/
    assign prv_pipe_if.swap = current_instr.csr_swap;
    assign prv_pipe_if.clr = current_instr.csr_clr;
    assign prv_pipe_if.set = current_instr.csr_set;
    assign prv_pipe_if.read_only = current_instr.csr_read_only;
    assign prv_pipe_if.wdata = current_instr.csr_imm ? {27'h0, current_instr.zimm} : current_instr.rs1_data;
    assign prv_pipe_if.csr_addr = current_instr.csr_addr;
    assign prv_pipe_if.valid_write = (prv_pipe_if.swap | prv_pipe_if.clr
                                        | prv_pipe_if.set) & ~hazard_if.ex_mem_stall;
    assign prv_pipe_if.instr = (current_instr.instr != '0);

    assign hazard_if.fault_insn = current_instr.fault_insn;
    assign hazard_if.mal_insn = current_instr.mal_insn;
    assign hazard_if.illegal_insn = current_instr.illegal_insn || prv_pipe_if.invalid_priv_isn;
    assign hazard_if.fault_l = current_instr.dren && dgen_bus_if.error;
    assign hazard_if.mal_l = current_instr.dren & mal_addr;
    assign hazard_if.fault_s = current_instr.dwen && dgen_bus_if.error;
    assign hazard_if.mal_s = current_instr.dwen & mal_addr;
    assign hazard_if.breakpoint = current_instr.breakpoint;
    assign hazard_if.env = current_instr.ecall_insn;
    assign hazard_if.ret = current_instr.ret_insn;
    assign hazard_if.wfi = current_instr.wfi_insn;
    assign hazard_if.badaddr = (hazard_if.fault_insn || hazard_if.mal_insn) ? current_instr.badaddr : dgen_bus_if.addr;

    // NEW
    assign hazard_if.pc_m = current_instr.pc;
    assign hazard_if.valid_m = current_instr.valid;
    assign ex_mem_if.pc4 = current_instr.pc4;

    // Memory protection (doesn't consider RISC-MGMT)
    assign prv_pipe_if.dren  = current_instr.dren;
    assign prv_pipe_if.dwen  = current_instr.dwen;
    assign prv_pipe_if.daddr = current_instr.port_out;
    assign prv_pipe_if.d_acc_width = WordAcc;

    // TODO: Currently omitting SparCE

    /***********
    * Writeback
    ************/
    assign ex_mem_if.brj_addr = current_instr.brj_addr;
    assign ex_mem_if.reg_write = current_instr.reg_write;
    assign ex_mem_if.rd_m = current_instr.rd_m;

    always_comb begin
        // TODO: RISC-MGMT
        case (current_instr.w_sel)
            3'd0:    ex_mem_if.reg_wdata = dload_ext;
            3'd1:    ex_mem_if.reg_wdata = current_instr.pc4;
            3'd2:    ex_mem_if.reg_wdata = current_instr.imm_U;
            3'd3:    ex_mem_if.reg_wdata = current_instr.port_out;
            3'd4:    ex_mem_if.reg_wdata = prv_pipe_if.rdata;
            default: ex_mem_if.reg_wdata = '0;
        endcase

        // Forwarding unit
        case (current_instr.w_sel)
            3'd1:    fw_if.rd_mem_data = current_instr.pc4;
            3'd2:    fw_if.rd_mem_data = current_instr.imm_U;
            3'd3:    fw_if.rd_mem_data = current_instr.port_out;
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
    assign funct3 = current_instr.instr[14:12];
    assign funct12 = current_instr.instr[31:20];
    assign instr_30 = current_instr.instr[30];
    assign wb_stall = hazard_if.ex_mem_stall & ~hazard_if.jump & ~hazard_if.branch; // TODO: Is this right?


endmodule
