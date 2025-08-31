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
*   Filename:     priv_pipe_control.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 09/26/2024
*   Description:  Controls when the pipeline should jump to a different
                   address after an exception or interrupt
*/

`include "priv_internal_if.vh"

module priv_pipe_control (
    priv_internal_if.pipe_ctrl prv_intern_if
);

    import priv_isa_types_pkg::*;
    import rv32i_types_pkg::*;

    assign prv_intern_if.insert_pc = prv_intern_if.mret | prv_intern_if.sret | prv_intern_if.intr;

    always_comb begin
        prv_intern_if.priv_pc = '0;

        if (prv_intern_if.intr) begin
            // if interrupt into s mode else m mode
            if (prv_intern_if.intr_to_s) begin
                if (prv_intern_if.curr_stvec.mode == VECTORED & prv_intern_if.next_scause.interrupt) begin
                    prv_intern_if.priv_pc = (prv_intern_if.curr_stvec.base << 2)
                                                + (prv_intern_if.next_scause.cause << 2);
                end else begin
                    prv_intern_if.priv_pc = prv_intern_if.curr_stvec.base << 2;
                end
            end else begin
                if (prv_intern_if.curr_mtvec.mode == VECTORED & prv_intern_if.next_mcause.interrupt) begin
                    prv_intern_if.priv_pc = (prv_intern_if.curr_mtvec.base << 2)
                                                + (prv_intern_if.next_mcause.cause << 2);
                end else begin
                    prv_intern_if.priv_pc = prv_intern_if.curr_mtvec.base << 2;
                end
            end
        end else if (prv_intern_if.mret) begin
            prv_intern_if.priv_pc = prv_intern_if.curr_mepc; // Leaving ISR
        end else if (prv_intern_if.sret) begin
            prv_intern_if.priv_pc = prv_intern_if.curr_sepc; // Leaving ISR
        end
    end

endmodule