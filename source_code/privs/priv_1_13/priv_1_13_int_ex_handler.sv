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
    logic exception;

    int_code_t int_src;
    logic interrupt, clear_interrupt;
    logic interrupt_fired;

    // Determine the source of the interrupt
    always_comb begin
        interrupt = 1'b1;
        int_src = SOFT_INT_S;

        if (prv_intern_if.ext_int_m) begin
            int_src = EXT_INT_M;
        end
        else if (prv_intern_if.soft_int_m) begin
            int_src = SOFT_INT_M;
        end
        else if (prv_intern_if.timer_int_m) begin
            int_src = TIMER_INT_M;
        end
        else if (prv_intern_if.ext_int_s) begin
            int_src = EXT_INT_S;
        end
        else if (prv_intern_if.soft_int_s) begin
            int_src = SOFT_INT_S;
        end
        else if (prv_intern_if.timer_int_s) begin
            int_src = TIMER_INT_S;
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

        if (prv_intern_if.breakpoint)
            ex_src = BREAKPOINT;
        else if (prv_intern_if.fault_insn_page)
            ex_src = INSN_PAGE;
        else if (prv_intern_if.fault_insn_access)
            ex_src = INSN_ACCESS;
        else if (prv_intern_if.illegal_insn)
            ex_src = ILLEGAL_INSN;
        else if (prv_intern_if.mal_insn)
            ex_src = INSN_MAL;
        else if (prv_intern_if.env_u)
            ex_src = ENV_CALL_U;
        else if (prv_intern_if.env_s)
            ex_src = ENV_CALL_S;
        else if (prv_intern_if.env_m)
            ex_src = ENV_CALL_M;
        else if (prv_intern_if.mal_s)
            ex_src = S_ADDR_MAL;
        else if (prv_intern_if.mal_l)
            ex_src = L_ADDR_MAL;
        else if (prv_intern_if.fault_store_page)
            ex_src = STORE_PAGE;
        else if (prv_intern_if.fault_load_page)
            ex_src = LOAD_PAGE;
        else if (prv_intern_if.fault_s)
            ex_src = S_FAULT;
        else if (prv_intern_if.fault_l)
            ex_src = L_FAULT;
        else if (prv_intern_if.ex_rmgmt)
            ex_src = ex_code_t'(prv_intern_if.ex_rmgmt_cause);
        else
            exception = 1'b0;
    end

    // Output info to pipe_ctrl
    assign prv_intern_if.intr = exception | interrupt_fired;

    // Only output an interrupt if said interrupt is enabled
    assign interrupt_fired = (prv_intern_if.curr_mstatus.mie &
                                ((prv_intern_if.curr_mie.mtie & prv_intern_if.curr_mip.mtip)
                                    | (prv_intern_if.curr_mie.msie & prv_intern_if.curr_mip.msip)
                                    | (prv_intern_if.curr_mie.meie & prv_intern_if.curr_mip.meip)));

    // Register updates on Interrupts/Exceptions
    assign prv_intern_if.inject_mcause = exception | interrupt_fired;
    assign prv_intern_if.next_mcause.interrupt = ~exception;
    assign prv_intern_if.next_mcause.cause = exception ? ex_src : int_src;

    assign prv_intern_if.inject_mip = interrupt | clear_interrupt;
    always_comb begin
        prv_intern_if.next_mip = prv_intern_if.curr_mip;

        if (prv_intern_if.ext_int_m) prv_intern_if.next_mip.meip = 1'b1;
        else if (prv_intern_if.clear_ext_int_m) prv_intern_if.next_mip.meip = 1'b0;

        if (prv_intern_if.soft_int_m) prv_intern_if.next_mip.msip = 1'b1;
        else if (prv_intern_if.clear_soft_int_m) prv_intern_if.next_mip.msip = 1'b0;

        if (prv_intern_if.timer_int_m) prv_intern_if.next_mip.mtip = 1'b1;
        else if (prv_intern_if.clear_timer_int_m) prv_intern_if.next_mip.mtip = 1'b0;

        if (prv_intern_if.ext_int_s) prv_intern_if.next_mip.seip = 1'b1;
        else if (prv_intern_if.clear_ext_int_s) prv_intern_if.next_mip.seip = 1'b0;

        if (prv_intern_if.soft_int_s) prv_intern_if.next_mip.ssip = 1'b1;
        else if (prv_intern_if.clear_soft_int_s) prv_intern_if.next_mip.ssip = 1'b0;

        if (prv_intern_if.timer_int_s) prv_intern_if.next_mip.stip = 1'b1;
        else if (prv_intern_if.clear_timer_int_s) prv_intern_if.next_mip.stip = 1'b0;
    end

    assign prv_intern_if.inject_mstatus = prv_intern_if.intr | prv_intern_if.mret;

    always_comb begin
        prv_intern_if.next_mstatus = prv_intern_if.curr_mstatus;
        // interrupt has truly been registered and it is time to go to the vector table
        if (prv_intern_if.intr) begin
            // when a trap is taken mpie is set to the current mie
            prv_intern_if.next_mstatus.mpie = prv_intern_if.curr_mstatus.mie;
            prv_intern_if.next_mstatus.mie = 1'b0;
        end else if (prv_intern_if.mret) begin
            prv_intern_if.next_mstatus.mpie = 1'b0; // leaving the vector table
            prv_intern_if.next_mstatus.mie = prv_intern_if.curr_mstatus.mpie;
        end

        // We need to change mstatus bits for mode changes
        if (prv_intern_if.intr) begin // If we are receiving an exception or interrupt
            prv_intern_if.next_mstatus.mpp = prv_intern_if.curr_privilege_level;
        end else if (prv_intern_if.mret) begin // If we are going back from a trap
            prv_intern_if.next_mstatus.mpp = U_MODE; // We must set mpp to the least privileged mode possible
            if (prv_intern_if.curr_mstatus.mpp != M_MODE) begin
                prv_intern_if.next_mstatus.mprv = 1'b0;
            end
        end
    end

    assign prv_intern_if.inject_mepc = exception | interrupt_fired;
    assign prv_intern_if.next_mepc = prv_intern_if.epc;

    assign prv_intern_if.inject_mtval = (prv_intern_if.mal_l | prv_intern_if.fault_l
                                        | prv_intern_if.mal_s | prv_intern_if.fault_s
                                        | prv_intern_if.illegal_insn
                                        | prv_intern_if.fault_insn_access
                                        | prv_intern_if.mal_insn
                                        | prv_intern_if.breakpoint
                                        | prv_intern_if.ex_rmgmt)
                                        & prv_intern_if.pipe_clear;
    assign prv_intern_if.next_mtval = prv_intern_if.curr_mtval;

endmodule
