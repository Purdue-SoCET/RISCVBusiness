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

    word_t quotient_core;
    word_t remainder_core;

    logic div_valid_core, div_ready_core;
    logic div_start_core;
    logic div_in_valid;

    logic div_inflight_q;
    logic div_inflight_d;

    logic div_signed_req;

    logic div_resp_valid;

    assign divisor  = op_b;
    assign dividend = op_a;

    assign overflow = (dividend == 32'h8000_0000) &&
                      (divisor  == 32'hffff_ffff) &&
                      is_signed[0];

    assign div_zero = (divisor == 32'h0);

    assign div_start_core = operand_diff && is_divide && !overflow && !div_zero && rv32m_start;
    assign div_in_valid = div_start_core && !div_inflight_q && div_ready_core;

    assign div_signed_req = (operation == DIV) || (operation == REM);

    srt_div #(
        .WIDTH(WORD_SIZE),
        .BITS_PER_CYCLE(3)
    ) div_core_i (
        .CLK(CLK),
        .nRST(nRST),
        .is_signed(div_signed_req),
        .in_valid(div_in_valid),
        .in_ready(div_ready_core),
        .out_valid(div_valid_core),
        .out_ready(1'b1),
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient_core),
        .remainder(remainder_core),
        .div_by_zero()
    );

    assign div_resp_valid = div_inflight_q && div_valid_core;
    assign div_finished   = div_resp_valid;

    always_comb begin
        div_inflight_d = div_inflight_q;

        if (div_in_valid) begin
            div_inflight_d = 1'b1;
        end

        if (div_resp_valid) begin
            div_inflight_d = 1'b0;
        end
    end

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            div_inflight_q <= 1'b0;
        end else begin
            div_inflight_q <= div_inflight_d;
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
        if (rv32m_start) begin
            // Note: operand_diff on all these cases is to fix condition where
            // "done" flag asserted by FU due to previous op. RV32M will always
            // take at least 1 extra cycle if we aren't reusing a value.
            casez (operation)
                MUL: begin
                    rv32m_done = !operand_diff || mul_finished;
                    rv32m_out  = product[WORD_SIZE-1:0];
                end

                MULH, MULHU, MULHSU: begin
                    rv32m_done = !operand_diff || mul_finished;
                    rv32m_out  = product[(WORD_SIZE*2)-1 : WORD_SIZE];
                end

                DIV: begin
                    rv32m_done = !operand_diff || div_finished || div_zero || overflow;
                    rv32m_out  = div_zero ? 32'hffff_ffff :
                                 (overflow ? 32'h8000_0000 : quotient_core);
                end

                DIVU: begin
                    rv32m_done = !operand_diff || div_finished || div_zero || overflow;
                    rv32m_out  = div_zero ? 32'hffff_ffff :
                                 (overflow ? 32'h8000_0000 : quotient_core);
                end

                REM: begin
                    rv32m_done = !operand_diff || div_finished || div_zero || overflow;
                    rv32m_out  = div_zero ? dividend :
                                 (overflow ? 32'h0000_0000 : remainder_core);
                end

                REMU: begin
                    rv32m_done = !operand_diff || div_finished || div_zero || overflow;
                    rv32m_out  = div_zero ? dividend :
                                 (overflow ? 32'h0000_0000 : remainder_core);
                end

                default: begin
                    rv32m_done = 1'b1;
                    rv32m_out  = 32'b0;
                end
            endcase
        end else begin
            rv32m_done = 1'b1;
            rv32m_out  = 32'b0;
        end
    end

endmodule
