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
    bus_if.response d_bus,
    bus_if.response i_bus,
    bus_if.request out_bus
);

    /* State Declaration */
    typedef enum {
        IDLE,
        INSTR_REQ,
        INSTR_DATA_REQ,
        INSTR_WAIT,
        DATA_REQ,
        DATA_INSTR_REQ,
        DATA_WAIT,
        CANCEL_REQ_WAIT
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
                //if (d_bus.trans == bus_pkg::NONSEQ) next_state = DATA_REQ;
                //else if (i_bus.trans == bus_pkg::NONSEQ) next_state = INSTR_REQ;
                if (d_bus.trans == bus_pkg::NONSEQ) next_state = DATA_WAIT;
                else if (i_bus.trans == bus_pkg::NONSEQ) next_state = INSTR_WAIT;
                else next_state = IDLE;
            end

            /*
            INSTR_REQ: begin
                if (~(i_bus.trans == bus_pkg::NONSEQ || i_bus.trans == bus_pkg::SEQ))  // Abort request, received an interrupt
                    next_state = IDLE;
                //else if (d_bus.trans == bus_pkg::NONSEQ) next_state = INSTR_DATA_REQ;
                else next_state = INSTR_WAIT;
            end

            INSTR_DATA_REQ: begin
                if (~out_bus.busy) next_state = DATA_WAIT;
                else next_state = INSTR_DATA_REQ;
            end

            DATA_REQ: begin
                if (i_bus.ren) next_state = DATA_INSTR_REQ;
                else next_state = DATA_WAIT;
            end

            DATA_INSTR_REQ: begin
                // Abort request, received an interrupt
                if(!i_bus.ren && out_bus.busy == 1'b0)
                    next_state = IDLE;
                else if (out_bus.busy == 1'b0) next_state = INSTR_WAIT;
                else next_state = DATA_INSTR_REQ;
            end
            */

            INSTR_WAIT: begin
                if (~out_bus.busy ) begin
                    if (i_bus.trans == bus_pkg::SEQ) next_state = INSTR_REQ;
                    else if (d_bus.trans == bus_pkg::NONSEQ) next_state = DATA_WAIT;
                    else next_state = IDLE;
                end
                else if(~(i_bus.trans == bus_pkg::NONSEQ || i_bus.trans == bus_pkg::SEQ)) next_state = CANCEL_REQ_WAIT;
                else next_state = INSTR_WAIT;
            end

            DATA_WAIT: begin
                if (~out_bus.busy ) begin
                    if (d_bus.trans == bus_pkg::SEQ) next_state = DATA_REQ;
                    else if (i_bus.trans == bus_pkg::NONSEQ) next_state = INSTR_WAIT;
                    else next_state = IDLE;
                end
                else next_state = DATA_WAIT;
            end

            CANCEL_REQ_WAIT: begin
                if(~out_bus.busy) begin
                    next_state = IDLE;
                end else begin
                    next_state = CANCEL_REQ_WAIT;
                end
            end

            default: next_state = IDLE;
        endcase
    end

    /* State Output Logic */
    always_comb begin
        case (current_state)
            IDLE: begin
                if(i_bus.trans == bus_pkg::NONSEQ) begin
                    out_bus.trans           = i_bus.trans;
                    out_bus.addr            = i_bus.addr;
                    out_bus.size            = i_bus.size;
                    out_bus.write_enable    = 1'b0;
                end else if(d_bus.trans == bus_pkg::NONSEQ) begin
                    out_bus.trans           = d_bus.trans;
                    out_bus.write_enable    = d_bus.write_enable;
                    out_bus.addr            = d_bus.addr;
                    out_bus.size            = d_bus.size;
                end else begin
                    out_bus.trans           = bus_pkg::IDLE;
                    out_bus.addr            = 0;
                    out_bus.size            = bus_pkg::WORD;
                    out_bus.write_enable    = 1'b0;
                end
                d_bus.busy      = 1'b0;
                d_bus.error     = 1'b0;
                i_bus.busy      = 1'b0;
                i_bus.error     = 1'b0;
            end

            //-- INSTRUCTION REQUEST --//
            // Byte enable is relevant to data phase
            /*
            INSTR_REQ: begin
                out_bus.wen     = i_bus.wen;
                out_bus.ren     = i_bus.ren;
                out_bus.addr    = i_bus.addr;
                out_bus.byte_en = i_bus.byte_en;
                d_bus.busy      = 1'b1;
                d_bus.error     = 1'b0;
                i_bus.busy      = 1'b1;
                i_bus.error     = 1'b0;
            end
            INSTR_DATA_REQ: begin
                out_bus.wen     = d_bus.wen;
                out_bus.ren     = d_bus.ren;
                out_bus.addr    = d_bus.addr;
                out_bus.byte_en = i_bus.byte_en;
                i_bus.busy      = out_bus.busy;
                i_bus.error     = out_bus.error;
                d_bus.busy      = 1'b1;
                d_bus.error     = 1'b0;
            end
            */
            INSTR_WAIT: begin
                out_bus.trans           = i_bus.trans;
                out_bus.write_enable    = 0;
                out_bus.addr            = i_bus.addr;
                out_bus.size            = i_bus.size;
                d_bus.busy      = 1'b1;
                d_bus.error     = 1'b0;
                i_bus.busy      = out_bus.busy;
                i_bus.error     = out_bus.error;
            end

            //-- DATA REQUEST --//
            /*
            DATA_REQ: begin
                out_bus.wen     = d_bus.wen;
                out_bus.ren     = d_bus.ren;
                out_bus.addr    = d_bus.addr;
                out_bus.byte_en = d_bus.byte_en;
                d_bus.busy      = 1'b1;
                d_bus.error     = 1'b0;
                i_bus.busy      = 1'b1;
                i_bus.error     = 1'b0;
            end
            DATA_INSTR_REQ: begin
                out_bus.wen     = i_bus.wen;
                out_bus.ren     = i_bus.ren;
                out_bus.addr    = i_bus.addr;
                out_bus.byte_en = d_bus.byte_en;
                d_bus.busy      = out_bus.busy;
                d_bus.error     = out_bus.error;
                i_bus.busy      = 1'b1;
                i_bus.error     = 1'b0;
            end
            */
            DATA_WAIT: begin
                out_bus.trans           = d_bus.trans;
                out_bus.write_enable    = d_bus.write_enable;
                out_bus.addr            = d_bus.addr;
                out_bus.size            = d_bus.size;
                i_bus.busy              = 1'b1;
                i_bus.error             = 1'b0;
                d_bus.busy              = out_bus.busy;
                d_bus.error             = out_bus.error;
            end

            CANCEL_REQ_WAIT: begin
                out_bus.trans           = bus_pkg::IDLE;
                out_bus.write_enable    = 0;
                out_bus.addr            = 0;
                out_bus.size            = bus_pkg::WORD;
                i_bus.busy              = 1;
                i_bus.error             = 0;
                d_bus.busy              = 1;
                d_bus.error             = 0;
            end

            default: begin
                out_bus.trans           = bus_pkg::IDLE;
                out_bus.write_enable     = 0;
                out_bus.addr            = 0;
                out_bus.size            = bus_pkg::WORD;
                d_bus.busy              = 1'b1;
                d_bus.error             = 1'b0;
                i_bus.busy              = 1'b1;
                i_bus.error             = 1'b0;
            end
        endcase
    end

    generate
        if (BUS_ENDIANNESS == "big") begin : g_mc_bus_be
            assign wdata = d_bus.wdata;
            assign rdata = out_bus.rdata;
        end else if (BUS_ENDIANNESS == "little") begin : g_mc_bus_le
            logic [31:0] little_endian_wdata, little_endian_rdata;
            endian_swapper wswap (
                .word_in(d_bus.wdata),
                .word_out(little_endian_wdata)
            );
            endian_swapper rswap (
                .word_in(out_bus.rdata),
                .word_out(little_endian_rdata)
            );
            assign wdata = little_endian_wdata;
            assign rdata = little_endian_rdata;
        end
    endgenerate

    assign out_bus.wdata = wdata;
    assign d_bus.rdata   = rdata;
    assign i_bus.rdata   = rdata;
endmodule
