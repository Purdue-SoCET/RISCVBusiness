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
*   Filename:     memory_controller.sv
*
*   Created by:   John Skubic
*   Modified by:  Chuan Yean Tan
*   Email:        jskubic@purdue.edu , tan56@purdue.edu
*   Date Created: 09/12/2016
*   Description:  Memory controller and arbitration between instruction
*                 and data accesses
*/

`include "generic_bus_if.vh"
`include "component_selection_defines.vh"

module memory_controller (
    input logic CLK,
    nRST,
    generic_bus_if.generic_bus d_gen_bus_if,
    generic_bus_if.generic_bus i_gen_bus_if,
    generic_bus_if.cpu out_gen_bus_if
);

    /* State Declaration */
    typedef enum {
        IDLE,
        INSTR_REQ,
        INSTR_DATA_REQ,
        INSTR_WAIT,
        DATA_REQ,
        DATA_INSTR_REQ,
        DATA_WAIT
    } state_t;

    state_t current_state, next_state;

    /* Internal Signals */
    logic [31:0] wdata, rdata;

    always_ff @(posedge CLK, negedge nRST) begin
        if (nRST == 0) current_state <= IDLE;
        else current_state <= next_state;
    end

    /* State Transition Logic */
    /*
  * Note: After interrupts were integrated, receiving an interrupt forces IREN
  * to go low. On an instruction request, the FSM assumed IREN high, and unconditionally
  * proceeded to an instruction wait state (either INSTR_WAIT or INSTR_DATA_REQ). However,
  * since IREN was low, the AHB master did not actually receive a request, and therefore the
  * I-Bus would never see a "ready" condition; the AHB master would be locked in IDLE, and
  * this FSM would be locked in the instruction wait state forever.
  *
  * To fix, I added logic to abort an instruction request if the IREN signal was low in
  * the INSTR_REQ or DATA_INSTR_REQ state; this only happens on an interrupt, so simply aborting
  * the transaction on the next transition should be safe since the pipeline will be flushed anyways;
  * the instruction request in question should not be fetched since the next instruction should be from
  * the interrupt handler after the new PC is inserted.
  */
    always_comb begin
        case (current_state)
            IDLE: begin
                if (d_gen_bus_if.ren || d_gen_bus_if.wen) next_state = DATA_REQ;
                else if (i_gen_bus_if.ren) next_state = INSTR_REQ;
                else next_state = IDLE;
            end

            INSTR_REQ: begin
                if (!i_gen_bus_if.ren)  // Abort request, received an interrupt
                    next_state = IDLE;
                else if (d_gen_bus_if.ren || d_gen_bus_if.wen) next_state = INSTR_DATA_REQ;
                else next_state = INSTR_WAIT;
            end

            INSTR_DATA_REQ: begin
                if (out_gen_bus_if.busy == 1'b0) next_state = DATA_WAIT;
                else next_state = INSTR_DATA_REQ;
            end

            DATA_REQ: begin
                if (i_gen_bus_if.ren) next_state = DATA_INSTR_REQ;
                else next_state = DATA_WAIT;
            end

            DATA_INSTR_REQ: begin
                // Abort request, received an interrupt
                if(!i_gen_bus_if.ren && out_gen_bus_if.busy == 1'b0)
                    next_state = IDLE;
                else if (out_gen_bus_if.busy == 1'b0) next_state = INSTR_WAIT;
                else next_state = DATA_INSTR_REQ;
            end

            INSTR_WAIT: begin
                if (out_gen_bus_if.busy == 1'b0) begin
                    if (d_gen_bus_if.ren || d_gen_bus_if.wen) next_state = DATA_REQ;
                    else next_state = IDLE;
                end else if (d_gen_bus_if.ren || d_gen_bus_if.wen) next_state = INSTR_DATA_REQ;
                else next_state = INSTR_WAIT;
            end

            DATA_WAIT: begin
                if (out_gen_bus_if.busy == 1'b0) begin
                    if (i_gen_bus_if.ren) next_state = INSTR_REQ;
                    else next_state = IDLE;
                end else if (i_gen_bus_if.ren) next_state = DATA_INSTR_REQ;
                else next_state = DATA_WAIT;
            end

            default: next_state = IDLE;
        endcase
    end

    /* State Output Logic */
    always_comb begin
        case (current_state)
            IDLE: begin
                out_gen_bus_if.wen     = 0;
                out_gen_bus_if.ren     = 0;
                out_gen_bus_if.addr    = 0;
                out_gen_bus_if.byte_en = d_gen_bus_if.byte_en;
                d_gen_bus_if.busy      = 1'b1;
                i_gen_bus_if.busy      = 1'b1;
            end

            //-- INSTRUCTION REQUEST --//
            INSTR_REQ: begin
                out_gen_bus_if.wen     = i_gen_bus_if.wen;
                out_gen_bus_if.ren     = i_gen_bus_if.ren;
                out_gen_bus_if.addr    = i_gen_bus_if.addr;
                out_gen_bus_if.byte_en = i_gen_bus_if.byte_en;
                d_gen_bus_if.busy      = 1'b1;
                i_gen_bus_if.busy      = 1'b1;
            end
            INSTR_DATA_REQ: begin
                out_gen_bus_if.wen     = d_gen_bus_if.wen;
                out_gen_bus_if.ren     = d_gen_bus_if.ren;
                out_gen_bus_if.addr    = d_gen_bus_if.addr;
                out_gen_bus_if.byte_en = d_gen_bus_if.byte_en;
                i_gen_bus_if.busy      = out_gen_bus_if.busy;
                d_gen_bus_if.busy      = 1'b1;
            end
            INSTR_WAIT: begin
                out_gen_bus_if.wen     = 0;
                out_gen_bus_if.ren     = 0;
                out_gen_bus_if.addr    = 0;
                out_gen_bus_if.byte_en = i_gen_bus_if.byte_en;
                d_gen_bus_if.busy      = 1'b1;
                i_gen_bus_if.busy      = out_gen_bus_if.busy;
            end

            //-- DATA REQUEST --//
            DATA_REQ: begin
                out_gen_bus_if.wen     = d_gen_bus_if.wen;
                out_gen_bus_if.ren     = d_gen_bus_if.ren;
                out_gen_bus_if.addr    = d_gen_bus_if.addr;
                out_gen_bus_if.byte_en = d_gen_bus_if.byte_en;
                d_gen_bus_if.busy      = 1'b1;
                i_gen_bus_if.busy      = 1'b1;
            end
            DATA_INSTR_REQ: begin
                out_gen_bus_if.wen     = i_gen_bus_if.wen;
                out_gen_bus_if.ren     = i_gen_bus_if.ren;
                out_gen_bus_if.addr    = i_gen_bus_if.addr;
                out_gen_bus_if.byte_en = i_gen_bus_if.byte_en;
                d_gen_bus_if.busy      = out_gen_bus_if.busy;
                i_gen_bus_if.busy      = 1'b1;
            end
            DATA_WAIT: begin
                out_gen_bus_if.wen     = d_gen_bus_if.wen;
                out_gen_bus_if.ren     = d_gen_bus_if.ren;
                out_gen_bus_if.addr    = d_gen_bus_if.addr;
                out_gen_bus_if.byte_en = d_gen_bus_if.byte_en;
                i_gen_bus_if.busy      = 1'b1;
                d_gen_bus_if.busy      = out_gen_bus_if.busy;
            end
            default: begin
                out_gen_bus_if.wen     = 0;
                out_gen_bus_if.ren     = 0;
                out_gen_bus_if.addr    = 0;
                out_gen_bus_if.byte_en = d_gen_bus_if.byte_en;
                d_gen_bus_if.busy      = 1'b1;
                i_gen_bus_if.busy      = 1'b1;
            end
        endcase
    end

    generate
        if (BUS_ENDIANNESS == "big") begin : g_mc_bus_be
            assign wdata = d_gen_bus_if.wdata;
            assign rdata = out_gen_bus_if.rdata;
        end else if (BUS_ENDIANNESS == "little") begin : g_mc_bus_le
            logic [31:0] little_endian_wdata, little_endian_rdata;
            endian_swapper wswap (
                .word_in(d_gen_bus_if.wdata),
                .word_out(little_endian_wdata)
            );
            endian_swapper rswap (
                .word_in(out_gen_bus_if.rdata),
                .word_out(little_endian_rdata)
            );
            assign wdata = little_endian_wdata;
            assign rdata = little_endian_rdata;
        end
    endgenerate

    assign out_gen_bus_if.wdata = wdata;
    assign d_gen_bus_if.rdata   = rdata;
    assign i_gen_bus_if.rdata   = rdata;
endmodule
