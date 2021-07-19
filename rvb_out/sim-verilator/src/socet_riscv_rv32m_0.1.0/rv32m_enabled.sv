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
    output logic rv32m_busy,
    output logic [31:0] rv32m_out
);

    import rv32m_pkg::*;
    import rv32i_types_pkg::*;


    /* Operand Saver to detect new request */

    // operand saver
    word_t op_a, op_b, op_a_save, op_b_save;
    rv32m_op_t operation_save;
    //logic [2:0] operation, operation_save;
    //logic [1:0] is_signed_save, is_signed_curr, is_signed;
    logic operand_diff;
    logic is_multiply;
    logic is_divide;
    logic [1:0] is_signed;

    assign is_multiply = (operation == MUL) || (operation == MULH) || (operation == MULHU) || (operation == MULHSU);
    assign is_divide   = (operation == DIV) || (operation == DIVU) || (operation == REM) || (operation == REMU);


    assign op_a = operand_diff ? rv32m_a : op_a_save;
    assign op_b = operand_diff ? rv32m_b : op_b_save;
    assign operand_diff = rv32m_start && ((op_a_save != rv32m_a) || (op_b_save != rv32m_b) || (operation_save != operation));
    /*assign operand_diff   = ((op_a_save != rv32m_a) ||
                          (op_b_save != rv32m_b) ||
                          (is_signed_save != is_signed_curr) ||
                          (operation_save != {idex.mul, idex.div, idex.rem})) &&
                          idex.start ;
    assign is_signed_curr = idex.usign_usign ? 2'b00 : (idex.sign_sign ? 2'b11 : 2'b10);
    // Is signed + operation = func3? Seems like we could potentially just save off the func3 wholesale
    assign is_signed = operand_diff ? is_signed_curr : is_signed_save;
    assign operation = operand_diff ? {idex.mul, idex.div, idex.rem} : operation_save;*/

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            op_a_save      <= '0;
            op_b_save      <= '0;
            //is_signed_save <= '0;
            operation_save <= MUL;
        end else if (operand_diff) begin
            op_a_save      <= rv32m_a;
            op_b_save      <= rv32m_b;
            //is_signed_save <= is_signed_curr;
            operation_save <= operation;
        end
    end


    /* MULTIPLICATION */

    // multiplier signals
    word_t multiplicand, multiplier;
    logic [(WORD_SIZE*2)-1:0] product;
    logic mul_finished;
    logic mul_start;

    assign multiplicand = op_a;
    assign multiplier   = op_b;
    assign mul_start    = operand_diff && is_multiply && rv32m_start;

    // Module instantiations
    // TODO: Case for which multiplier/divider to use
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


    /* DIVISION / REMAINDER */

    logic overflow, div_zero, div_finished;
    word_t divisor, dividend, quotient, remainder, divisor_save, dividend_save;
    logic div_operand_diff;
    logic div_start;

    assign divisor   = op_b;
    assign dividend  = op_a;
    assign overflow  = (dividend == 32'h8000_0000) && (divisor == 32'hffff_ffff) && is_signed[0];
    assign div_zero  = (divisor == 32'h0);
    assign div_start = operand_diff && is_divide && !overflow && !div_zero && rv32m_start;

    radix4_divider div_i (
        .CLK(CLK),
        .nRST(nRST),
        .divisor(divisor),
        .dividend(dividend),
        .is_signed(is_signed[0]), // For division, only 00 or 11, input is 1 bit, so take one of the bits for "is_signed" (arbitrary)
        .start(div_start),
        .remainder(remainder),
        .quotient(quotient),
        .finished(div_finished)
    );

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
                    rv32m_busy = operand_diff || !mul_finished;
                    rv32m_out  = product[WORD_SIZE-1:0];
                end

                MULH, MULHU, MULHSU: begin
                    rv32m_busy = operand_diff || !mul_finished;
                    rv32m_out  = product[(WORD_SIZE*2)-1 : WORD_SIZE];
                end

                // TODO: Is there a better way to decode this? Lots of repetition.
                DIV: begin
                    rv32m_busy = operand_diff || (!div_finished && !div_zero && !overflow);
                    rv32m_out  = div_zero ? 32'hffff_ffff : (overflow ? 32'h8000_0000 : quotient);
                end

                DIVU: begin
                    rv32m_busy = operand_diff || (!div_finished && !div_zero && !overflow);
                    rv32m_out  = div_zero ? 32'h7fff_ffff : (overflow ? 32'h8000_0000 : quotient);
                end

                REM, REMU: begin
                    rv32m_busy = operand_diff || (!div_finished && !div_zero && !overflow);
                    rv32m_out  = div_zero ? dividend : (overflow ? 32'h0000_0000 : remainder);
                end

                default: begin
                    rv32m_busy = 1'b0;
                    rv32m_out = 32'b0; // TODO: Should this return BAD3?
                end
            endcase
        end else begin
            rv32m_busy = 1'b0;
            rv32m_out = 32'b0;
        end
    end

    /*
    always_comb begin
        casez (operation)
            3'b1??: begin  // MUL
                eif.busy = ~mul_finished;
                eif.reg_wdata = idex.lower_word ?
                                    product[WORD_SIZE-1:0]
                                    : product[(WORD_SIZE*2)-1 : WORD_SIZE];
            end
            3'b01?: begin  // DIV
                eif.busy = ~div_finished & ~(div_zero | overflow);
                if (div_zero) begin
                    eif.reg_wdata = idex.sign_sign ? 32'hffff_ffff : 32'h7fff_ffff;
                end else if (overflow) begin
                    eif.reg_wdata = 32'h8000_0000;
                end else begin
                    eif.reg_wdata = quotient;
                end
            end
            3'b001: begin  // REM
                eif.busy = ~div_finished & ~(div_zero | overflow);
                if (div_zero) begin
                    eif.reg_wdata = dividend;
                end else if (overflow) begin
                    eif.reg_wdata = 32'h0000_0000;
                end else begin
                    eif.reg_wdata = remainder;
                end
            end
            default: begin
                eif.busy = 1'b0;
                eif.reg_wdata = 32'hBAD3_BAD3;
            end
        endcase
    end
    */

endmodule
