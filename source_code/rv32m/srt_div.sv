module srt_div #( // genus run 58, reverted logic and removed bpc check and cleanup
    parameter int WIDTH = 32,
    parameter int BITS_PER_CYCLE = 3
) (
    input logic CLK,
    input logic nRST,
    input logic in_valid,
    input logic is_signed,
    input logic [WIDTH-1:0] dividend,
    input logic [WIDTH-1:0] divisor,
    input logic out_ready,
    output logic in_ready,
    output logic out_valid,
    output logic [WIDTH-1:0] quotient,
    output logic [WIDTH-1:0] remainder,
    output logic div_by_zero
);
    localparam int SRT_MAX_DIGIT = 1 << (BITS_PER_CYCLE - 1);
    localparam int QDIG_W = BITS_PER_CYCLE + 1;
    localparam int NUM_ITERS = (WIDTH + BITS_PER_CYCLE - 1) / BITS_PER_CYCLE;
    localparam int EVEN_WIDTH = NUM_ITERS * BITS_PER_CYCLE;
    localparam int PAD_BITS = EVEN_WIDTH - WIDTH;
    localparam int REM_WIDTH = WIDTH + 4;
    localparam int QUOT_ACC_WIDTH = EVEN_WIDTH + 1;
    localparam int SHIFT_W = $clog2(REM_WIDTH);

    typedef enum logic [2:0] {
        S_IDLE,
        S_RUN,
        S_CORR,
        S_DONE
    } state_t;

    state_t state_q, state_d;

    logic [$clog2(NUM_ITERS + 1)-1:0] iter_q, iter_d;
    logic [WIDTH-1:0] quotient_q, quotient_d;
    logic [WIDTH-1:0] remainder_q, remainder_d;
    logic div_by_zero_q, div_by_zero_d;
    logic [EVEN_WIDTH-1:0] dividend_q, dividend_d;
    logic [WIDTH-1:0] divisor_q, divisor_d;
    logic signed [REM_WIDTH:0] corr_rem_q, corr_rem_d;
    logic [REM_WIDTH-1:0] rem_sum_q, rem_sum_d;
    logic [REM_WIDTH-1:0] rem_carry_q, rem_carry_d;
    logic signed [QUOT_ACC_WIDTH-1:0] qacc_q, qacc_d;
    logic quot_neg_q, quot_neg_d;
    logic rem_neg_q, rem_neg_d;

    // correction step registers
    logic [REM_WIDTH:0] corr_den_step_q, corr_den_step_d;
    logic [QUOT_ACC_WIDTH-1:0] corr_q_step_q, corr_q_step_d;

    // run-state wires
    logic [BITS_PER_CYCLE-1:0] next_bits;
    logic signed [QDIG_W-1:0] q_digit;
    logic signed [QUOT_ACC_WIDTH-1:0] qacc_next;
    logic signed [REM_WIDTH:0] rem_x2;
    logic [REM_WIDTH-1:0] rem_sum_shift, rem_sum_next;
    logic [REM_WIDTH-1:0] rem_carry_shift, rem_carry_next;
    logic signed [REM_WIDTH-1:0] rem_est;
    logic signed [REM_WIDTH:0] rem_est_w;
    logic signed [REM_WIDTH-1:0] q_term;
    logic [REM_WIDTH-1:0] q_term_mag;
    logic [REM_WIDTH-1:0] d_u, d_x1, d_x2;
    int bit_hi, digit_mag;

    // correction wires
    logic [REM_WIDTH:0] corr_abs_rem;
    logic [REM_WIDTH:0] corr_den;

    function automatic logic [WIDTH-1:0] tc_abs(input logic [WIDTH-1:0] v);
        return v[WIDTH-1] ? (~v + {{(WIDTH-1){1'b0}}, 1'b1}) : v;
    endfunction

    // index of highest set bit in a (rem_width+1)-wide value
    function automatic logic [SHIFT_W-1:0] msb_pos(input logic [REM_WIDTH:0] v);
        logic [SHIFT_W-1:0] pos;
        pos = '0;
        for (int i = 0; i <= REM_WIDTH; i++)
            if (v[i]) pos = SHIFT_W'(i);
        return pos;
    endfunction

    carry_save_adder #(.BIT_WIDTH(REM_WIDTH)) rem_csa_i (
        .x(rem_sum_shift), .y(rem_carry_shift), .z(q_term),
        .cout(rem_carry_next), .sum(rem_sum_next)
    );

    assign quotient = quotient_q;
    assign remainder = remainder_q;
    assign in_ready = (state_q == S_IDLE);
    assign out_valid = (state_q == S_DONE);
    assign div_by_zero = div_by_zero_q;

    // combinational datapath
    always_comb begin
        bit_hi = 0;
        next_bits = '0;
        rem_x2 = '0;
        q_digit = '0;
        qacc_next = qacc_q;
        d_u = {{(REM_WIDTH-WIDTH){1'b0}}, divisor_q};
        d_x1 = '0;
        d_x2 = '0;
        digit_mag = 0;
        q_term_mag = '0;
        q_term = '0;
        rem_est = '0;
        rem_est_w = '0;
        rem_sum_shift = '0;
        rem_carry_shift = '0;
        corr_abs_rem = '0;
        corr_den = '0;

        if (state_q == S_RUN) begin
            bit_hi = EVEN_WIDTH - 1 - (iter_q * BITS_PER_CYCLE);
            next_bits = dividend_q[bit_hi -: BITS_PER_CYCLE];
            rem_sum_shift = (rem_sum_q <<< BITS_PER_CYCLE) | {{(REM_WIDTH-BITS_PER_CYCLE){1'b0}}, next_bits};
            rem_carry_shift = rem_carry_q <<< BITS_PER_CYCLE;

            rem_est_w = $signed({rem_sum_shift[REM_WIDTH-1], rem_sum_shift}) + $signed({rem_carry_shift[REM_WIDTH-1], rem_carry_shift});
            rem_est = rem_est_w[REM_WIDTH-1:0];
            rem_x2 = rem_est_w <<< 1;

            d_x1 = d_u;
            d_x2 = d_u << 1;

            if (rem_x2 >= $signed({1'b0, (d_x2 + d_x1)})) q_digit = $signed(2);
            else if (rem_x2 >= $signed({1'b0, d_x2})) q_digit = $signed(1);
            else if (rem_x2 >= -$signed({1'b0, d_x2})) q_digit = '0;
            else if (rem_x2 >= -$signed({1'b0, (d_x2 + d_x1)})) q_digit = -$signed(1);
            else q_digit = -$signed(2);

            digit_mag = q_digit < 0 ? -q_digit : q_digit;
            case (digit_mag)
                0: q_term_mag = '0;
                1: q_term_mag = d_x1;
                default: q_term_mag = d_x2;
            endcase
            q_term = (q_digit >= 0) ? -$signed(q_term_mag) : $signed(q_term_mag);
            qacc_next = (qacc_q <<< BITS_PER_CYCLE) + q_digit;

        end else if (state_q == S_CORR) begin
            d_u = {{(REM_WIDTH-WIDTH){1'b0}}, divisor_q};
            corr_den = {1'b0, d_u};
            corr_abs_rem = corr_rem_q[REM_WIDTH] ? $unsigned(-corr_rem_q) : $unsigned(corr_rem_q);
        end
    end

    // next-state and datapath decisions
    always_comb begin
        state_d = state_q;
        iter_d = iter_q;
        div_by_zero_d = div_by_zero_q;
        dividend_d = dividend_q;
        divisor_d = divisor_q;
        corr_rem_d = corr_rem_q;
        qacc_d = qacc_q;
        quot_neg_d = quot_neg_q;
        rem_neg_d = rem_neg_q;
        quotient_d = quotient_q;
        remainder_d = remainder_q;
        rem_sum_d = rem_sum_q;
        rem_carry_d = rem_carry_q;
        corr_den_step_d = corr_den_step_q;
        corr_q_step_d = corr_q_step_q;

        case (state_q)
            // idle
            S_IDLE: begin
                if (in_valid) begin
                    logic [WIDTH-1:0] abs_divd;
                    logic [WIDTH-1:0] abs_divs;
                    abs_divd = (is_signed && dividend[WIDTH-1]) ? tc_abs(dividend) : dividend;
                    abs_divs = (is_signed && divisor[WIDTH-1])  ? tc_abs(divisor) : divisor;

                    quotient_d = '0;
                    remainder_d = '0;
                    iter_d = '0;
                    corr_rem_d = '0;
                    qacc_d = '0;
                    rem_sum_d = '0;
                    rem_carry_d = '0;

                    dividend_d = {{PAD_BITS{1'b0}}, abs_divd};
                    divisor_d = abs_divs;
                    quot_neg_d = is_signed && (dividend[WIDTH-1] ^ divisor[WIDTH-1]);
                    rem_neg_d = is_signed ? dividend[WIDTH-1] : 1'b0;

                    if (divisor == '0) begin
                        div_by_zero_d = 1'b1;
                        quotient_d = '1;
                        remainder_d = dividend;
                        state_d = S_DONE;
                    end else begin
                        div_by_zero_d = 1'b0;
                        state_d = S_RUN;
                    end
                end
            end

            // run
            S_RUN: begin
                rem_sum_d = rem_sum_next;
                rem_carry_d = rem_carry_next;
                qacc_d = qacc_next;
                iter_d = iter_q + 1'b1;

                if (iter_q == NUM_ITERS - 1) begin
                    // collapse csa remainder into signed value
                    logic signed [REM_WIDTH:0] final_rem;
                    logic [REM_WIDTH:0] abs_final;
                    logic [SHIFT_W-1:0] align;
                    logic [REM_WIDTH-1:0] d_u_loc;
                    logic [SHIFT_W-1:0] rem_msb, den_msb;

                    final_rem = $signed({rem_sum_next[REM_WIDTH-1], rem_sum_next}) + $signed({rem_carry_next[REM_WIDTH-1], rem_carry_next});
                    corr_rem_d = final_rem;

                    // set initial correction step from |remainder| msb
                    abs_final = final_rem[REM_WIDTH] ? $unsigned(-final_rem) : $unsigned(final_rem);
                    d_u_loc = {{(REM_WIDTH-WIDTH){1'b0}}, divisor_d};

                    rem_msb = msb_pos(abs_final);
                    den_msb = msb_pos({1'b0, d_u_loc});
                    align = (rem_msb >= den_msb) ? (rem_msb - den_msb) : '0;

                    corr_den_step_d = {1'b0, d_u_loc} << align;
                    corr_q_step_d = ({{(QUOT_ACC_WIDTH-1){1'b0}}, 1'b1}) << align;

                    state_d = S_CORR;
                end
            end

            // corr
            // binary non-restoring correction, one update per cycle
            S_CORR: begin
                if (corr_den != '0) begin
                    if (corr_rem_q >= $signed(corr_den_step_q)) begin
                        // remainder too large, subtract step
                        corr_rem_d = corr_rem_q - $signed(corr_den_step_q);
                        qacc_d = qacc_q + $signed(corr_q_step_q);

                    end else if (corr_rem_q < 0) begin
                        // remainder negative, add step
                        corr_rem_d = corr_rem_q + $signed(corr_den_step_q);
                        qacc_d = qacc_q - $signed(corr_q_step_q);

                    end else if (corr_den_step_q > corr_den) begin
                        // no correction at this step, shift down
                        corr_den_step_d = corr_den_step_q >> 1;
                        corr_q_step_d = corr_q_step_q >> 1;

                    end else begin
                        // done when remainder is in range
                        quotient_d = quot_neg_q ? (~qacc_q[WIDTH-1:0] + {{(WIDTH-1){1'b0}}, 1'b1}) : qacc_q[WIDTH-1:0];
                        remainder_d = rem_neg_q ? (~corr_rem_q[WIDTH-1:0] + {{(WIDTH-1){1'b0}}, 1'b1}) : corr_rem_q[WIDTH-1:0];
                        state_d = S_DONE;
                    end
                end else begin
                    // divisor zero is handled in idle; keep this safe path
                    quotient_d = quot_neg_q ? (~qacc_q[WIDTH-1:0] + {{(WIDTH-1){1'b0}}, 1'b1}) : qacc_q[WIDTH-1:0];
                    remainder_d = rem_neg_q ? (~corr_rem_q[WIDTH-1:0] + {{(WIDTH-1){1'b0}}, 1'b1}) : corr_rem_q[WIDTH-1:0];
                    state_d = S_DONE;
                end
            end

            // done
            S_DONE: begin
                if (out_ready)
                    state_d = S_IDLE;
            end

            default: state_d = S_IDLE;
        endcase
    end

    // registers (async reset)
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            state_q <= S_IDLE;
            iter_q <= '0;
            quotient_q <= '0;
            remainder_q <= '0;
            div_by_zero_q <= 1'b0;
            dividend_q <= '0;
            corr_rem_q <= '0;
            rem_sum_q <= '0;
            rem_carry_q <= '0;
            qacc_q <= '0;
            divisor_q <= '0;
            quot_neg_q <= 1'b0;
            rem_neg_q <= '0;
            corr_den_step_q <= '0;
            corr_q_step_q <= '0;
        end else begin
            state_q <= state_d;
            iter_q <= iter_d;
            quotient_q <= quotient_d;
            remainder_q <= remainder_d;
            div_by_zero_q <= div_by_zero_d;
            dividend_q <= dividend_d;
            divisor_q <= divisor_d;
            corr_rem_q <= corr_rem_d;
            rem_sum_q <= rem_sum_d;
            rem_carry_q <= rem_carry_d;
            qacc_q <= qacc_d;
            quot_neg_q <= quot_neg_d;
            rem_neg_q <= rem_neg_d;
            corr_den_step_q <= corr_den_step_d;
            corr_q_step_q <= corr_q_step_d;
        end
    end

endmodule