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

`include "risc_mgmt_execute_if.vh"

module rv32m_execute (
    input logic CLK,
    nRST,
    //risc mgmt connection
    risc_mgmt_execute_if.ext eif,
    //stage to stage connection
    input rv32m_pkg::decode_execute_t idex,
    output rv32m_pkg::execute_memory_t exmem
);

    import rv32m_pkg::*;
    import rv32i_types_pkg::*;

    /* Static RISC-MGMT assignments */

    assign eif.exception = 1'b0;
    assign eif.reg_w = 1'b1;
    assign eif.branch_jump = 1'b0;

    /* Operand Saver to detect new request */

    // operand saver
    word_t op_a, op_b, op_a_save, op_b_save;
    logic [2:0] operation, operation_save;
    logic [1:0] is_signed_save, is_signed_curr, is_signed;
    logic operand_diff;

    assign op_a = operand_diff ? eif.rdata_s_0 : op_a_save;
    assign op_b = operand_diff ? eif.rdata_s_1 : op_b_save;
    assign operand_diff   = ((op_a_save != eif.rdata_s_0) ||
                          (op_b_save != eif.rdata_s_1) ||
                          (is_signed_save != is_signed_curr) ||
                          (operation_save != {idex.mul, idex.div, idex.rem})) &&
                          idex.start ;
    assign is_signed_curr = idex.usign_usign ? 2'b00 : (idex.sign_sign ? 2'b11 : 2'b10);
    assign is_signed = operand_diff ? is_signed_curr : is_signed_save;
    assign operation = operand_diff ? {idex.mul, idex.div, idex.rem} : operation_save;

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            op_a_save      <= '0;
            op_b_save      <= '0;
            is_signed_save <= '0;
            operation_save <= '0;
        end else if (operand_diff) begin
            op_a_save      <= eif.rdata_s_0;
            op_b_save      <= eif.rdata_s_1;
            is_signed_save <= is_signed_curr;
            operation_save <= {idex.mul, idex.div, idex.rem};
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
    assign mul_start    = operand_diff && operation[2];

    // Module instantiations
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
    assign overflow  = (dividend == 32'h8000_0000) && (divisor == 32'hffff_ffff) && idex.sign_sign;
    assign div_zero  = (divisor == 32'h0);
    assign div_start = operand_diff && ~operation[2] & ~overflow & ~div_zero;

    radix4_divider div_i (
        .CLK(CLK),
        .nRST(nRST),
        .divisor(divisor),
        .dividend(dividend),
        .is_signed(idex.sign_sign),
        .start(div_start),
        .remainder(remainder),
        .quotient(quotient),
        .finished(div_finished)
    );

    /* Result */

    always_comb begin
        casez (operation)
            3'b1??: begin  // MUL
                eif.busy = ~mul_finished;
                eif.reg_wdata = idex.lower_word ? product[WORD_SIZE-1:0] : product[(WORD_SIZE*2)-1 : WORD_SIZE];
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

endmodule
