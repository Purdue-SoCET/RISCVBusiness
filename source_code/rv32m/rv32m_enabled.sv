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
*   Filename:     rv32m_execute.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/07/2017
*   Description:  Execute stage for standard RV32M
*/
`include "component_selection_defines.vh"

module rv32m_enabled (
    input CLK,
    input nRST,
    input rv32m_start,
    input rv32m_pkg::rv32m_op_t operation,
    input [31:0] rv32m_a,
    input [31:0] rv32m_b,
    output logic rv32m_done,
    output logic [31:0] rv32m_out
);

    import rv32m_pkg::*;
    import rv32i_types_pkg::*;


    /* Operand Saver to detect new request */
    word_t op_a, op_b, op_a_save, op_b_save;
    rv32m_op_t operation_save;
    logic operand_diff;
    logic is_multiply;
    logic is_divide;
    logic [1:0] is_signed;

    assign is_multiply = (operation == MUL) || (operation == MULH) || (operation == MULHU) || (operation == MULHSU);
    assign is_divide   = (operation == DIV) || (operation == DIVU) || (operation == REM) || (operation == REMU);
    assign op_a = operand_diff ? rv32m_a : op_a_save;
    assign op_b = operand_diff ? rv32m_b : op_b_save;
    assign operand_diff = rv32m_start
                            && ((op_a_save != rv32m_a) || (op_b_save != rv32m_b) || (operation_save != operation));

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            op_a_save      <= '0;
            op_b_save      <= '0;
            operation_save <= MUL;
        end else if (rv32m_start && rv32m_done) begin
            op_a_save      <= rv32m_a;
            op_b_save      <= rv32m_b;
            operation_save <= operation;
        end
    end

    /* MULTIPLICATION */
    word_t multiplicand, multiplier;
    logic [(WORD_SIZE*2)-1:0] product;
    logic mul_finished;
    logic mul_start;

    assign multiplicand = op_a;
    assign multiplier   = op_b;
    assign mul_start    = operand_diff && is_multiply && rv32m_start;

    // Module instantiations
    `ifdef PP_MUL32
        pp_mul32 mult_i (
            .CLK(CLK),
            .nRST(nRST),
            .multiplicand(multiplicand),
            .multiplier(multiplier),
            .product(product),
            .is_signed(is_signed),
            .start(mul_start),
            .finished(mul_finished)
        );
    `elsif SHIFT_ADD_MULTIPLIER
        shift_add_multiplier mult_i (
            .CLK(CLK),
            .nRST(nRST),
            .multiplicand(multiplicand),
            .multiplier(multiplier),
            .is_signed(is_signed),
            .start(mul_start),
            .product(product),
            .finished(mul_finished)
        );
    `else
        assert(0); // Build error
    `endif

    /* DIVISION / REMAINDER */
    logic overflow, div_zero, div_finished;
    word_t divisor, dividend;
    word_t quotient_signed, remainder_signed;
    word_t quotient_unsigned, remainder_unsigned;
    word_t quotient, remainder;
    logic div_by_zero_signed, div_by_zero_unsigned;
    logic div_valid_signed, div_valid_unsigned;
    logic div_ready_signed, div_ready_unsigned;
    logic div_start_signed, div_start_unsigned;
    logic is_divide_signed;
    logic div_inflight_q;
    logic div_inflight_d;
    logic div_mode_signed_q;
    logic div_mode_signed_d;
    logic div_resp_valid;
    logic div_start;

    assign divisor   = op_b;
    assign dividend  = op_a;
    assign overflow  = (dividend == 32'h8000_0000) && (divisor == 32'hffff_ffff) && is_signed[0];
    assign div_zero  = (divisor == 32'h0);
    assign div_start = operand_diff && is_divide && !overflow && !div_zero && rv32m_start;
    assign is_divide_signed = (operation == DIV) || (operation == REM);
    assign div_start_signed = div_start && !div_inflight_q && is_divide_signed;
    assign div_start_unsigned = div_start && !div_inflight_q && !is_divide_signed;

    srt_div #(
        .WIDTH(WORD_SIZE),
        .SUPPORT_SIGNED(1'b1),
        .BITS_PER_CYCLE(2)
    ) div_signed_i (
        .CLK(CLK),
        .nRST(nRST),
        .in_valid(div_start_signed),
        .in_ready(div_ready_signed),
        .out_valid(div_valid_signed),
        .out_ready(1'b1),
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient_signed),
        .remainder(remainder_signed),
        .div_by_zero(div_by_zero_signed)
    );

    srt_div #(
        .WIDTH(WORD_SIZE),
        .SUPPORT_SIGNED(1'b0),
        .BITS_PER_CYCLE(2)
    ) div_unsigned_i (
        .CLK(CLK),
        .nRST(nRST),
        .in_valid(div_start_unsigned),
        .in_ready(div_ready_unsigned),
        .out_valid(div_valid_unsigned),
        .out_ready(1'b1),
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient_unsigned),
        .remainder(remainder_unsigned),
        .div_by_zero(div_by_zero_unsigned)
    );

    assign div_resp_valid = div_mode_signed_q ? div_valid_signed : div_valid_unsigned;
    assign div_finished = div_resp_valid;
    assign quotient = div_mode_signed_q ? quotient_signed : quotient_unsigned;
    assign remainder = div_mode_signed_q ? remainder_signed : remainder_unsigned;

    always_comb begin
        div_inflight_d = div_inflight_q;
        div_mode_signed_d = div_mode_signed_q;

        if (!div_inflight_q && ((div_start_signed && div_ready_signed) || (div_start_unsigned && div_ready_unsigned))) begin
            div_inflight_d = 1'b1;
            div_mode_signed_d = is_divide_signed;
        end

        if (div_resp_valid) begin
            div_inflight_d = 1'b0;
        end
    end

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            div_inflight_q <= 1'b0;
            div_mode_signed_q <= 1'b0;
        end else begin
            div_inflight_q <= div_inflight_d;
            div_mode_signed_q <= div_mode_signed_d;
        end
    end

    /* Operation decoding */
    always_comb begin
        casez (operation)
            MUL, MULH, DIV, REM:    is_signed = 2'b11;
            MULHU, DIVU, REMU:      is_signed = 2'b00;
            MULHSU:                 is_signed = 2'b10;
            default:                is_signed = 2'b11;
        endcase
    end

    /* Result */
    always_comb begin
        if(rv32m_start) begin
            // Note: operand_diff on all these cases is to fix condition where
            // "done" flag asserted by FU due to previous op. RV32M will always
            // take at least 1 extra cycle if we aren't reusing a value.
            casez(operation)
                MUL: begin
                    rv32m_done = !operand_diff || mul_finished;
                    rv32m_out  = product[WORD_SIZE-1:0];
                end

                MULH, MULHU, MULHSU: begin
                    rv32m_done = !operand_diff || mul_finished;
                    rv32m_out  = product[(WORD_SIZE*2)-1 : WORD_SIZE];
                end

                // TODO: Is there a better way to decode this? Lots of repetition.
                DIV: begin
                    rv32m_done = !operand_diff || div_finished || div_zero || overflow;
                    rv32m_out  = div_zero ? 32'hffff_ffff : (overflow ? 32'h8000_0000 : quotient);
                end

                DIVU: begin
                    rv32m_done = !operand_diff || div_finished || div_zero || overflow;
                    rv32m_out  = div_zero ? 32'hffff_ffff : (overflow ? 32'h8000_0000 : quotient);
                end

                REM, REMU: begin
                    rv32m_done = !operand_diff || div_finished || div_zero || overflow;
                    rv32m_out  = div_zero ? dividend : (overflow ? 32'h0000_0000 : remainder);
                end

                default: begin
                    rv32m_done = 1'b1;
                    rv32m_out = 32'b0; // TODO: Should this return BAD3?
                end
            endcase
        end else begin
            rv32m_done = 1'b1;
            rv32m_out = 32'b0;
        end
    end

endmodule
