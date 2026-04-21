module srt_div #(
    parameter int WIDTH = 32,
    parameter bit SUPPORT_SIGNED = 1'b1,
    parameter int BITS_PER_CYCLE = 4
) (
    input  logic CLK,
    input  logic nRST,
    input  logic in_valid,
    input  logic [WIDTH-1:0] dividend,
    input  logic [WIDTH-1:0] divisor,
    input  logic out_ready,
    output logic in_ready,
    output logic out_valid,
    output logic [WIDTH-1:0] quotient,
    output logic [WIDTH-1:0] remainder,
    output logic div_by_zero
);
    localparam int SRT_MAX_DIGIT = 1 << (BITS_PER_CYCLE - 1);
    localparam int QDIG_W = BITS_PER_CYCLE + 1;
    // number of SRT iterations needed to cover WIDTH bits
    localparam int NUM_ITERS = (WIDTH + BITS_PER_CYCLE - 1) / BITS_PER_CYCLE;
    // pad width to an even number so 2-bit slices are always valid
    localparam int EVEN_WIDTH = NUM_ITERS * BITS_PER_CYCLE;
    localparam int PAD_BITS = EVEN_WIDTH - WIDTH;
    // extra guard bits keep partial remainder and quotient accumulation safe
    localparam int REM_WIDTH = WIDTH + BITS_PER_CYCLE + 3;
    localparam int QUOT_ACC_WIDTH = EVEN_WIDTH + BITS_PER_CYCLE + 3;
    // address width for the q selection table
    localparam int QSEL_ADDR_W = 2 * SRT_MAX_DIGIT;

    typedef enum logic [2:0] {
        S_IDLE,
        S_RUN,
        S_CORR,
        S_DONE
    } state_t;

    state_t state_q;
    state_t state_d;
    logic [$clog2(NUM_ITERS + 1)-1:0] iter_q;
    logic [$clog2(NUM_ITERS + 1)-1:0] iter_d;
    logic [WIDTH-1:0] quotient_q;
    logic [WIDTH-1:0] quotient_d;
    logic [WIDTH-1:0] remainder_q;
    logic [WIDTH-1:0] remainder_d;
    logic div_by_zero_q;
    logic div_by_zero_d;

    logic [EVEN_WIDTH-1:0] dividend_q;
    logic [EVEN_WIDTH-1:0] dividend_d;
    logic [WIDTH-1:0] divisor_q;
    logic [WIDTH-1:0] divisor_d;
    logic signed [REM_WIDTH-1:0] rem_q;
    logic signed [REM_WIDTH-1:0] rem_d;
    logic [REM_WIDTH-1:0] rem_sum_q;
    logic [REM_WIDTH-1:0] rem_sum_d;
    logic [REM_WIDTH-1:0] rem_carry_q;
    logic [REM_WIDTH-1:0] rem_carry_d;
    logic signed [QUOT_ACC_WIDTH-1:0] qacc_q;
    logic signed [QUOT_ACC_WIDTH-1:0] qacc_d;

    logic [WIDTH-1:0] in_dividend;
    logic [WIDTH-1:0] in_divisor;
    logic in_sign;
    logic quot_neg_q;
    logic quot_neg_d;
    logic rem_neg_q;
    logic rem_neg_d;
    logic [BITS_PER_CYCLE-1:0] next_bits;
    logic signed [REM_WIDTH-1:0] rem_shifted;
    logic signed [QDIG_W-1:0] q_digit;
    logic signed [REM_WIDTH-1:0] rem_next;
    logic signed [QUOT_ACC_WIDTH-1:0] qacc_next;
    logic signed [REM_WIDTH-1:0] d_ext;
    logic signed [REM_WIDTH:0] rem_x2;
    logic signed [REM_WIDTH+BITS_PER_CYCLE:0] d_mul_ext;
    logic [QSEL_ADDR_W-1:0] qsel_addr;
    logic [REM_WIDTH-1:0] rem_sum_shift;
    logic [REM_WIDTH-1:0] rem_carry_shift;
    logic [REM_WIDTH-1:0] rem_sum_next;
    logic [REM_WIDTH-1:0] rem_carry_next;
    logic signed [REM_WIDTH-1:0] rem_est;
    logic signed [REM_WIDTH:0] rem_est_w;
    logic signed [REM_WIDTH-1:0] q_term;
    logic [REM_WIDTH-1:0] q_term_mag;
    logic signed [REM_WIDTH:0] rem_bin;
    logic signed [REM_WIDTH:0] rem_bin_corr;
    logic signed [QUOT_ACC_WIDTH-1:0] qacc_corr;
    logic [REM_WIDTH:0] corr_num;
    logic [REM_WIDTH:0] corr_den;
    logic [REM_WIDTH:0] corr_q;
    logic [REM_WIDTH:0] corr_r;
    logic [REM_WIDTH:0] corr_trial;
    logic signed [QUOT_ACC_WIDTH-1:0] corr_q_ext;
    logic [REM_WIDTH-1:0] d_u;
    int bit_hi;
    int idx;
    int threshold;
    int digit_mag;
    int corr_bit;

    function automatic logic [WIDTH-1:0] tc_abs(input logic [WIDTH-1:0] v);
        if (v[WIDTH-1]) begin
            tc_abs = (~v) + {{(WIDTH-1){1'b0}}, 1'b1};
        end else begin
            tc_abs = v;
        end
    endfunction

    initial begin
        if ((BITS_PER_CYCLE < 1) || (BITS_PER_CYCLE > 4)) begin
            $error("srt_div: BITS_PER_CYCLE must be 1 (radix 2), 2 (radix 4), 3 (radix 8), or 4 (radix 16), got %0d", BITS_PER_CYCLE);
        end
    end

    generate
        if (SUPPORT_SIGNED) begin : gen_signed
            assign in_dividend = tc_abs(dividend);
            assign in_divisor = tc_abs(divisor);
            assign in_sign = dividend[WIDTH-1] ^ divisor[WIDTH-1];
        end else begin : gen_no_sign
            assign in_dividend = dividend;
            assign in_divisor = divisor;
            assign in_sign = 1'b0;
        end
    endgenerate

    carry_save_adder #(
        .BIT_WIDTH(REM_WIDTH)
    ) rem_csa_i (
        .x(rem_sum_shift),
        .y(rem_carry_shift),
        .z(q_term),
        .cout(rem_carry_next),
        .sum(rem_sum_next)
    );

    assign quotient = quotient_q;
    assign remainder = remainder_q;

    assign in_ready = (state_q == S_IDLE);
    assign out_valid = (state_q == S_DONE);
    
    assign div_by_zero = div_by_zero_q;

    
    // precompute for run/final normalize
    always_comb begin
        bit_hi = 0;
        next_bits = '0;
        rem_x2 = '0;
        d_mul_ext = '0;
        qsel_addr = '0;
        q_digit = '0;
        rem_next = rem_q;
        qacc_next = qacc_q;
        d_ext = $signed({{(REM_WIDTH-WIDTH){1'b0}}, divisor_q});
        d_u = {{(REM_WIDTH-WIDTH){1'b0}}, divisor_q};
        threshold = 0;
        digit_mag = 0;
        q_term_mag = '0;
        q_term = '0;
        rem_est = '0;
        rem_est_w = '0;
        rem_bin = '0;
        rem_bin_corr = '0;
        qacc_corr = qacc_q;
        corr_num = '0;
        corr_den = '0;
        corr_q = '0;
        corr_r = '0;
        corr_trial = '0;
        corr_q_ext = '0;
        rem_sum_shift = '0;
        rem_carry_shift = '0;

        if (state_q == S_RUN) begin
            bit_hi = EVEN_WIDTH - 1 - (iter_q * BITS_PER_CYCLE);
            next_bits = dividend_q[bit_hi -: BITS_PER_CYCLE];
            rem_sum_shift = (rem_sum_q <<< BITS_PER_CYCLE) | {{(REM_WIDTH-BITS_PER_CYCLE){1'b0}}, next_bits};
            rem_carry_shift = rem_carry_q <<< BITS_PER_CYCLE;

            rem_est_w = $signed({rem_sum_shift[REM_WIDTH-1], rem_sum_shift}) + $signed({rem_carry_shift[REM_WIDTH-1], rem_carry_shift});
            rem_est = rem_est_w[REM_WIDTH-1:0];
            rem_x2 = rem_est_w <<< 1;

            for (idx = 0; idx < SRT_MAX_DIGIT; idx++) begin
                threshold = (2 * SRT_MAX_DIGIT - 1) - idx;
                d_mul_ext = $signed(threshold) * d_ext;
                qsel_addr[QSEL_ADDR_W-1-idx] = (rem_x2 >= d_mul_ext);

                threshold = SRT_MAX_DIGIT + idx;
                d_mul_ext = $signed(threshold) * d_ext;
                qsel_addr[SRT_MAX_DIGIT-1-idx] = (rem_x2 >= -d_mul_ext);
            end
            q_digit = srt_qsel_rom_pkg::srt_qsel_lookup(qsel_addr, SRT_MAX_DIGIT);

            digit_mag = q_digit < 0 ? -q_digit : q_digit;
            case (digit_mag)
                0: q_term_mag = '0;
                1: q_term_mag = d_u;
                2: q_term_mag = d_u << 1;
                3: q_term_mag = (d_u << 1) + d_u;
                4: q_term_mag = d_u << 2;
                5: q_term_mag = (d_u << 2) + d_u;
                6: q_term_mag = (d_u << 2) + (d_u << 1);
                7: q_term_mag = (d_u << 2) + (d_u << 1) + d_u;
                8: q_term_mag = d_u << 3;
                default: q_term_mag = '0;
            endcase
            q_term = (q_digit >= 0) ? -$signed(q_term_mag) : $signed(q_term_mag);
            qacc_next = (qacc_q <<< BITS_PER_CYCLE) + q_digit;
        end else if (state_q == S_CORR) begin
            rem_bin = $signed(rem_sum_q) + $signed(rem_carry_q);
            corr_den = {1'b0, d_u};
            corr_num = rem_bin[REM_WIDTH] ? $unsigned(-rem_bin) : $unsigned(rem_bin);
            corr_q = '0;
            corr_r = '0;

            if (corr_den != '0) begin
                for (corr_bit = REM_WIDTH; corr_bit >= 0; corr_bit--) begin
                    corr_trial = {corr_r[REM_WIDTH-1:0], corr_num[corr_bit]};
                    if (corr_trial >= corr_den) begin
                        corr_r = corr_trial - corr_den;
                        corr_q[corr_bit] = 1'b1;
                    end else begin
                        corr_r = corr_trial;
                    end
                end
            end

            corr_q_ext = $signed(corr_q[QUOT_ACC_WIDTH-1:0]);
            if (rem_bin < 0) begin
                if (corr_r == '0) begin
                    qacc_corr = qacc_q - corr_q_ext;
                    rem_bin_corr = '0;
                end else begin
                    qacc_corr = qacc_q - corr_q_ext - 1;
                    rem_bin_corr = $signed(corr_den - corr_r);
                end
            end else begin
                qacc_corr = qacc_q + corr_q_ext;
                rem_bin_corr = $signed(corr_r);
            end

            if (corr_den == '0) begin
                qacc_corr = qacc_q;
                rem_bin_corr = '0;
                end
        end
    end

    // next-state/datapath decisions
    always_comb begin
        state_d = state_q;
        iter_d = iter_q;
        div_by_zero_d = div_by_zero_q;
        dividend_d = dividend_q;
        divisor_d = divisor_q;
        rem_d = rem_q;
        qacc_d = qacc_q;
        quot_neg_d = quot_neg_q;
        rem_neg_d = rem_neg_q;
        quotient_d = quotient_q;
        remainder_d = remainder_q;
        rem_sum_d = rem_sum_q;
        rem_carry_d = rem_carry_q;

        case (state_q)
            S_IDLE: begin
                if (in_valid) begin
                    quotient_d = '0;
                    remainder_d = '0;
                    iter_d = '0;
                    rem_d = '0;
                    qacc_d = '0;
                    rem_sum_d = '0;
                    rem_carry_d = '0;

                    dividend_d = {{PAD_BITS{1'b0}}, in_dividend};
                    divisor_d = in_divisor;
                    quot_neg_d = in_sign;
                    rem_neg_d = SUPPORT_SIGNED ? dividend[WIDTH-1] : 1'b0;

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

            S_RUN: begin
                rem_sum_d = rem_sum_next;
                rem_carry_d = rem_carry_next;
                qacc_d = qacc_next;
                iter_d = iter_q + 1'b1;

                if (iter_q == NUM_ITERS - 1) begin
                    state_d = S_CORR;
                end
            end

            S_CORR: begin
                if (SUPPORT_SIGNED) begin
                    quotient_d = quot_neg_q ? ((~qacc_corr[WIDTH-1:0]) + {{(WIDTH-1){1'b0}}, 1'b1}) : qacc_corr[WIDTH-1:0];
                    remainder_d = rem_neg_q ? ((~rem_bin_corr[WIDTH-1:0]) + {{(WIDTH-1){1'b0}}, 1'b1}) : rem_bin_corr[WIDTH-1:0];
                end else begin
                    quotient_d = qacc_corr[WIDTH-1:0];
                    remainder_d = rem_bin_corr[WIDTH-1:0];
                end
                state_d = S_DONE;
            end

            S_DONE: begin
                if (out_ready) begin
                    state_d = S_IDLE;
                end
            end

            default: begin
                state_d = S_IDLE;
            end
        endcase
    end



    // register update with async reset
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            state_q <= S_IDLE;
            iter_q <= '0;
            quotient_q <= '0;
            remainder_q <= '0;
            div_by_zero_q <= 1'b0;
            dividend_q <= '0;
            rem_q <= '0;
            rem_sum_q <= '0;
            rem_carry_q <= '0;
            qacc_q <= '0;
            divisor_q <= '0;
            quot_neg_q <= 1'b0;
            rem_neg_q <= 1'b0;
        end else begin
            state_q <= state_d;
            iter_q <= iter_d;
            quotient_q <= quotient_d;
            remainder_q <= remainder_d;
            div_by_zero_q <= div_by_zero_d;
            dividend_q <= dividend_d;
            divisor_q <= divisor_d;
            rem_q <= rem_d;
            rem_sum_q <= rem_sum_d;
            rem_carry_q <= rem_carry_d;
            qacc_q <= qacc_d;
            quot_neg_q <= quot_neg_d;
            rem_neg_q <= rem_neg_d;
        end
    end

endmodule

// made on earth by humans
/*

 /\______/\
== .    . ==
     uu

*/



