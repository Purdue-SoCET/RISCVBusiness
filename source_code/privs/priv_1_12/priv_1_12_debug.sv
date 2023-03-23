module priv_1_12_debug (
    input logic CLK, nRST,
    priv_1_12_internal_if.debug prv_intern_if,
    priv_ext_if.ext priv_ext_if
);
    import machine_mode_types_1_12_pkg::*;

    csr_reg_t dpc, nxt_dpc;
    csr_reg_t epc_4;
    //nxt_dpc_int, nxt_dpc_pipe;
    csr_reg_t dscratch0, dscratch1, nxt_dscratch0, nxt_dscratch1;
    dcsr_t dcsr, nxt_dcsr;
    dcsr_t dcsr_mask;
    // nxt_dpc_int dpc value obtained from interrupt_exception unit, nxt_dpc_pipe value from pipeline(due to csr instructions)

    always_ff @( posedge CLK, negedge nRST ) begin
        if(nRST == 1'b0) begin
            // debug PC
            dpc <= '0;

            // Debug scratch registers
            dscratch0 <= '0;
            dscratch1 <= '0;

            // Debug Control and status register
            dcsr.xdebugver <= 4'd4;
                //TODO; cheeck ebreakm/s/u
            dcsr.ebreakm <= 0;
            dcsr.ebreaks <= 0;
            dcsr.ebreaku <= 0;
            dcsr.stepie <= 0;   // WARL
                //TODO: implement stopcount/time?
            dcsr.stopcount <= 0;// WARL
            dcsr.stoptime <= 0; // WARL
            dcsr.cause <= '0;
            dcsr.mprven <= 0;   // WARL, ingore mprv in status
            dcsr.nmip <= 0;
            dcsr.step <= 0;
                // TODO: this will record the current priv_level when enter the debug mode
                // A debugger can change this value to change the hart’s privilege level when
                // exiting Debug Mode.
            dcsr.prv <= M_MODE;
        end
        else begin
            dpc <= nxt_dpc;
            dscratch0 <= nxt_dscratch0;
            dscratch1 <= nxt_dscratch1;
            dcsr <= nxt_dcsr;
        end
    end

    // for for dcsr WARL check
    assign dcsr_mask = dcsr_t'(priv_ext_if.value_in & {4'b0, 12'b0, 1'b1, 1'b0, 2'b11, 3'b0, 3'b000, 1'b0, 1'b1, 1'b0, 3'b111});
            //                                         31:28          15    14  13:12  11:9    8:6     5     4     3     2:0
            //                                         xdebugver    ebrkm      ebrks/u stpie  cause        mrpven nmip    prv
    //                                                                        stopc/t 

    assign epc_4 = prv_intern_if.next_dpc + 4'b0100;

    always_comb begin: next_logic
        priv_ext_if.ack = 1'b0;

        nxt_dpc = dpc;
        nxt_dscratch0 = dscratch0;
        nxt_dscratch1 = dscratch1;
        nxt_dcsr = dcsr;

        // handle csr write
        if (prv_intern_if.curr_priv_dmode) begin
            case (priv_ext_if.csr_addr)
            12'h7b0: begin
                // dcsr
                priv_ext_if.ack = 1'b1;
                if(priv_ext_if.csr_active) begin
                    // WARL check
                    nxt_dcsr = dcsr | dcsr_mask;

                    if(nxt_dcsr.prv == S_MODE || nxt_dcsr.prv == RESERVED_MODE) begin
                        // S, and H modes are not supported
                        nxt_dcsr.prv = dcsr.prv;
                    end
                end
            end
            12'h7b1: begin
                // dpc
                priv_ext_if.ack = 1'b1;
                if(priv_ext_if.csr_active) begin
                    nxt_dpc = priv_ext_if.value_in;
                end
            end
            12'h7b2: begin
                priv_ext_if.ack = 1'b1;
                if(priv_ext_if.csr_active) begin
                    nxt_dscratch0 = priv_ext_if.value_in;
                end
            end
            12'h7b3: begin
                priv_ext_if.ack = 1'b1;
                if(priv_ext_if.csr_active) begin
                    nxt_dscratch1 = priv_ext_if.value_in;
                end
            end
            endcase
        end

        // handle inject signal from int_ex_hanlder unit
        if(prv_intern_if.inject_dpc) begin
            if(prv_intern_if.next_mcause == BREAKPOINT) begin
                nxt_dpc = epc_4;
            end
            else begin
                nxt_dpc = prv_intern_if.next_dpc;
            end
        end

        // dcsr cause
        if(prv_intern_if.inject_mcause) begin
            if(prv_intern_if.next_mcause.interrupt) begin
                if(prv_intern_if.next_mcause.cause == DEBUG_INT_M) begin
                    // enter debug due to haltreq was set
                    nxt_dcsr.cause = 3'b011;
                end
                
                // TODO:
                    // enter due to resethaltreq
                    // cause = 2
            end
            else begin
                if(prv_intern_if.next_mcause.cause == BREAKPOINT) begin
                    // enter debug due to ebreak
                    nxt_dcsr.cause = 3'b001;
                end
                
                // TODO:
                    // enter due to single step
                    // cause = 0

            end
        end

        // dcsr nmip
        nxt_dcsr.nmip = 1'b0;

        // dcsr prv
        if (prv_intern_if.intr && prv_intern_if.curr_priv_dmode != 1'b1) begin
            // this may capture the curr priv level when not debug mode, but it does not matter
            // when debug mode is entered, .intr will be high, curr_priv_dmode will be low
            
            nxt_dcsr.prv = prv_intern_if.curr_privilege_level;
        end
    end

    always_comb begin: value_out_logic
        priv_ext_if.value_out = dscratch0;
        case (priv_ext_if.csr_addr[1:0])
            2'b00: priv_ext_if.value_out = dcsr;
            2'b01: priv_ext_if.value_out = dpc;
            2'b10: priv_ext_if.value_out = dscratch0;
            2'b11: priv_ext_if.value_out = dscratch1;
        endcase
    end

    assign priv_ext_if.invalid_csr = 1'b0;

    assign prv_intern_if.curr_dpc = dpc;
    assign prv_intern_if.curr_dcsr = dcsr;
    assign prv_intern_if.ebreakm_debug = dcsr.ebreakm;
    assign prv_intern_if.ebreaks_debug = dcsr.ebreaks;
    assign prv_intern_if.ebreaku_debug = dcsr.ebreaku;
    
endmodule

