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
*   Filename:     priv_1_13_int_ex_handler.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 09/26/2024
*   Description:  Main interrupt and exception handler block
*/

`include "priv_1_13_internal_if.vh"

module priv_1_13_int_ex_handler (
    input CLK, nRST,
    priv_1_13_internal_if.int_ex_handler prv_intern_if
);

    import machine_mode_types_1_13_pkg::*;
    import rv32i_types_pkg::*;

    ex_code_t ex_src;
    logic [30:0] ex_src_bit;
    logic exception;

    int_code_t int_src;
    logic [30:0] int_src_bit;
    logic interrupt, clear_interrupt;
    logic interrupt_fired, interrupt_fired_s;

    // Determine the source of the interrupt
    always_comb begin
        interrupt = 1'b1;
        int_src = SOFT_INT_S;
        int_src_bit = '0;

        if (prv_intern_if.ext_int_m) begin
            int_src = EXT_INT_M;
            int_src_bit = 1 << EXT_INT_M;
        end
        else if (prv_intern_if.soft_int_m) begin
            int_src = SOFT_INT_M;
            int_src_bit = 1 << SOFT_INT_M;
        end
        else if (prv_intern_if.timer_int_m) begin
            int_src = TIMER_INT_M;
            int_src_bit = 1 << TIMER_INT_M;
        end
        else if (prv_intern_if.ext_int_s) begin
            int_src = EXT_INT_S;
            int_src_bit = 1 << EXT_INT_S;
        end
        else if (prv_intern_if.soft_int_s) begin
            int_src = SOFT_INT_S;
            int_src_bit = 1 << SOFT_INT_S;
        end
        else if (prv_intern_if.timer_int_s) begin
            int_src = TIMER_INT_S;
            int_src_bit = 1 << TIMER_INT_S;
        end
        else begin
            interrupt = 1'b0;
        end
    end

    assign clear_interrupt = (prv_intern_if.clear_timer_int_m | prv_intern_if.clear_soft_int_m
                             | prv_intern_if.clear_ext_int_m  | prv_intern_if.clear_timer_int_s
                             | prv_intern_if.clear_soft_int_s | prv_intern_if.clear_ext_int_s);

    // Determine whether an exception occured
    always_comb begin
        exception = 1'b1;
        ex_src = INSN_MAL;
        ex_src_bit = '0;

        if (prv_intern_if.breakpoint) begin
            ex_src = BREAKPOINT;
            ex_src_bit = 1 << BREAKPOINT;
        end else if (prv_intern_if.fault_insn_page) begin
            ex_src = INSN_PAGE;
            ex_src_bit = 1 << INSN_PAGE;
        end else if (prv_intern_if.fault_insn_access) begin
            ex_src = INSN_ACCESS;
            ex_src_bit = 1 << INSN_ACCESS;
        end else if (prv_intern_if.illegal_insn) begin
            ex_src = ILLEGAL_INSN;
            ex_src_bit = 1 << ILLEGAL_INSN;
        end else if (prv_intern_if.mal_insn) begin
            ex_src = INSN_MAL;
            ex_src_bit = 1 << INSN_MAL;
        end else if (prv_intern_if.env_u) begin
            ex_src = ENV_CALL_U;
            ex_src_bit = 1 << ENV_CALL_U;
        end else if (prv_intern_if.env_s) begin
            ex_src = ENV_CALL_S;
            ex_src_bit = 1 << ENV_CALL_S;
        end else if (prv_intern_if.env_m) begin
            ex_src = ENV_CALL_M;
            ex_src_bit = 1 << ENV_CALL_M;
        end else if (prv_intern_if.mal_s) begin
            ex_src = S_ADDR_MAL;
            ex_src_bit = 1 << S_ADDR_MAL;
        end else if (prv_intern_if.mal_l) begin
            ex_src = L_ADDR_MAL;
            ex_src_bit = 1 << L_ADDR_MAL;
        end else if (prv_intern_if.fault_store_page) begin
            ex_src = STORE_PAGE;
            ex_src_bit = 1 << STORE_PAGE;
        end else if (prv_intern_if.fault_load_page) begin
            ex_src = LOAD_PAGE;
            ex_src_bit = 1 << LOAD_PAGE;
        end else if (prv_intern_if.fault_s) begin
            ex_src = S_FAULT;
            ex_src_bit = 1 << S_FAULT;
        end else if (prv_intern_if.fault_l) begin
            ex_src = L_FAULT;
            ex_src_bit = 1 << L_FAULT;
        end else if (prv_intern_if.ex_rmgmt) begin
            ex_src = ex_code_t'(prv_intern_if.ex_rmgmt_cause);
            ex_src_bit = 1 << ex_src;
        end else
            exception = 1'b0;
    end

    // Output info to pipe_ctrl
    assign prv_intern_if.intr = exception | interrupt_fired | interrupt_fired_s;

    // if not m-mode intr and (deleg ex or deleg int and has right conditions to go to S-Mode)
    assign prv_intern_if.intr_to_s = !interrupt_fired & 
                                        ((|{prv_intern_if.curr_medeleg[30:0] & ex_src_bit} & exception) |
                                            ((|{prv_intern_if.curr_mideleg[30:0] & int_src_bit & SIE_MASK}) & interrupt_fired_s &
                                                ((prv_intern_if.curr_privilege_level == S_MODE & prv_intern_if.curr_mstatus.sie) |
                                                 (prv_intern_if.curr_privilege_level < S_MODE))));

    // Only output an interrupt if said interrupt is enabled
    assign interrupt_fired = (prv_intern_if.curr_mstatus.mie &
                                ((prv_intern_if.curr_mie.mtie & prv_intern_if.curr_mip.mtip) |
                                 (prv_intern_if.curr_mie.msie & prv_intern_if.curr_mip.msip) |
                                 (prv_intern_if.curr_mie.meie & prv_intern_if.curr_mip.meip)));
    assign interrupt_fired_s = (prv_intern_if.curr_mstatus.sie &
                                ((prv_intern_if.curr_mie.stie & prv_intern_if.curr_mip.stip) |
                                 (prv_intern_if.curr_mie.ssie & prv_intern_if.curr_mip.ssip) |
                                 (prv_intern_if.curr_mie.seie & prv_intern_if.curr_mip.seip)));

    // Register updates on Interrupts/Exceptions
    always_comb begin
        prv_intern_if.inject_mcause         = '0;
        prv_intern_if.next_mcause.interrupt = '0;
        prv_intern_if.next_mcause.cause     = '0;
        prv_intern_if.inject_scause         = '0;
        prv_intern_if.next_scause.interrupt = '0;
        prv_intern_if.next_scause.cause     = '0;

        // set cause for trap into X-mode
        if (prv_intern_if.intr_to_s) begin
            prv_intern_if.inject_scause         = (exception | interrupt_fired_s) && !prv_intern_if.ex_mem_stall;
            prv_intern_if.next_scause.interrupt = ~exception;
            prv_intern_if.next_scause.cause     = exception ? ex_src : int_src;
        end else begin
            prv_intern_if.inject_mcause         = (exception | interrupt_fired) && !prv_intern_if.ex_mem_stall;
            prv_intern_if.next_mcause.interrupt = ~exception;
            prv_intern_if.next_mcause.cause     = exception ? ex_src : int_src;
        end
    end

    assign prv_intern_if.inject_mip = interrupt | clear_interrupt;
    always_comb begin
        prv_intern_if.next_mip = prv_intern_if.curr_mip;

        if (prv_intern_if.ext_int_m) prv_intern_if.next_mip.meip = 1'b1;
        else if (prv_intern_if.clear_ext_int_m) prv_intern_if.next_mip.meip = 1'b0;

        if (prv_intern_if.soft_int_m) prv_intern_if.next_mip.msip = 1'b1;
        else if (prv_intern_if.clear_soft_int_m) prv_intern_if.next_mip.msip = 1'b0;

        if (prv_intern_if.timer_int_m) prv_intern_if.next_mip.mtip = 1'b1;
        else if (prv_intern_if.clear_timer_int_m) prv_intern_if.next_mip.mtip = 1'b0;

        // From note in priv_1_13_csr.sv: Supervisor interrupts change mip fields
        if (prv_intern_if.ext_int_s) prv_intern_if.next_mip.seip = 1'b1;
        else if (prv_intern_if.clear_ext_int_s) prv_intern_if.next_mip.seip = 1'b0;

        if (prv_intern_if.soft_int_s) prv_intern_if.next_mip.ssip = 1'b1;
        else if (prv_intern_if.clear_soft_int_s) prv_intern_if.next_mip.ssip = 1'b0;

        if (prv_intern_if.timer_int_s) prv_intern_if.next_mip.stip = 1'b1;
        else if (prv_intern_if.clear_timer_int_s) prv_intern_if.next_mip.stip = 1'b0;
    end

    assign prv_intern_if.inject_mstatus = (prv_intern_if.intr | prv_intern_if.mret | prv_intern_if.sret) && !prv_intern_if.ex_mem_stall;

    // xstatus injections
    always_comb begin
        prv_intern_if.next_mstatus = prv_intern_if.curr_mstatus;
        // interrupt has truly been registered and it is time to go to the vector table
        if (prv_intern_if.intr) begin
            // when a trap is taken mpie is set to the current mie
            if (prv_intern_if.intr_to_s) begin
                prv_intern_if.next_mstatus.spie = prv_intern_if.curr_mstatus.sie;
                prv_intern_if.next_mstatus.sie  = 1'b0;
            end else begin
                prv_intern_if.next_mstatus.mpie = prv_intern_if.curr_mstatus.mie;
                prv_intern_if.next_mstatus.mie  = 1'b0;
            end
        end else if (prv_intern_if.mret) begin
            prv_intern_if.next_mstatus.mpie = 1'b0; // leaving the vector table
            prv_intern_if.next_mstatus.mie  = prv_intern_if.curr_mstatus.mpie;
        end else if (prv_intern_if.sret) begin
            prv_intern_if.next_mstatus.spie = 1'b1; // not sure why this is different from mpie in mret?
            prv_intern_if.next_mstatus.sie  = prv_intern_if.curr_mstatus.spie;
        end

        // We need to change mstatus bits for mode changes
        if (prv_intern_if.intr) begin // If we are receiving an exception or interrupt
            if (prv_intern_if.intr_to_s) begin
                prv_intern_if.next_mstatus.spp = prv_intern_if.curr_privilege_level != U_MODE;
            end else begin
                prv_intern_if.next_mstatus.mpp = prv_intern_if.curr_privilege_level;
            end
        end else if (prv_intern_if.mret) begin // If we are going back from a trap
            prv_intern_if.next_mstatus.mpp = U_MODE; // We must set mpp to the least privileged mode possible
            if (prv_intern_if.curr_mstatus.mpp != M_MODE) begin
                prv_intern_if.next_mstatus.mprv = 1'b0;
            end
        end else if (prv_intern_if.sret) begin
            prv_intern_if.next_mstatus.spp = 1'b0;
        end
    end

    // xepc injections
    always_comb begin
        prv_intern_if.inject_mepc = '0;
        prv_intern_if.next_mepc   = '0;
        prv_intern_if.inject_sepc = '0;
        prv_intern_if.next_sepc   = '0;

        if (prv_intern_if.intr_to_s) begin
            prv_intern_if.inject_sepc = (exception | interrupt_fired_s) && !prv_intern_if.ex_mem_stall;
            prv_intern_if.next_sepc   = prv_intern_if.epc;
        end else begin
            prv_intern_if.inject_mepc = (exception | interrupt_fired) && !prv_intern_if.ex_mem_stall;
            prv_intern_if.next_mepc   = prv_intern_if.epc;
        end
    end

    // xtval injections
    always_comb begin
        prv_intern_if.inject_mtval = '0;
        prv_intern_if.next_mtval   = '0;
        prv_intern_if.inject_stval = '0;
        prv_intern_if.next_stval   = '0;

        if (prv_intern_if.intr_to_s) begin
            prv_intern_if.inject_stval = (prv_intern_if.mal_l | prv_intern_if.fault_l
                                        | prv_intern_if.mal_s | prv_intern_if.fault_s
                                        | prv_intern_if.illegal_insn
                                        | prv_intern_if.fault_insn_access
                                        | prv_intern_if.fault_load_page
                                        | prv_intern_if.fault_store_page
                                        | prv_intern_if.fault_insn_page
                                        | prv_intern_if.mal_insn
                                        | prv_intern_if.breakpoint
                                        | prv_intern_if.ex_rmgmt)
                                        & prv_intern_if.pipe_clear;
            prv_intern_if.next_stval = prv_intern_if.curr_stval;
        end else begin
            prv_intern_if.inject_mtval = (prv_intern_if.mal_l | prv_intern_if.fault_l
                                        | prv_intern_if.mal_s | prv_intern_if.fault_s
                                        | prv_intern_if.illegal_insn
                                        | prv_intern_if.fault_insn_access
                                        | prv_intern_if.fault_load_page
                                        | prv_intern_if.fault_store_page
                                        | prv_intern_if.fault_insn_page
                                        | prv_intern_if.mal_insn
                                        | prv_intern_if.breakpoint
                                        | prv_intern_if.ex_rmgmt)
                                        & prv_intern_if.pipe_clear;
            prv_intern_if.next_mtval = prv_intern_if.curr_mtval;
        end
        
    end

endmodule