module srt_div #(
    parameter int WIDTH = 32,
    parameter bit SUPPORT_SIGNED = 1'b1,
    parameter int BITS_PER_CYCLE = 2
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
    import srt_qsel_rom_pkg::*;

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
    localparam int CORR_CNT_W = $clog2(REM_WIDTH + 1);
    // address width for the q selection table
    localparam int QSEL_ADDR_W = 2 * SRT_MAX_DIGIT;

    typedef enum logic [1:0] {
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
    logic signed [REM_WIDTH+BITS_PER_CYCLE:0] d_ext_wide;
    logic signed [REM_WIDTH:0] rem_x2;
    logic signed [REM_WIDTH+BITS_PER_CYCLE:0] rem_x2_ext;
    logic signed [REM_WIDTH+BITS_PER_CYCLE:0] d_mult_lut [0:(2*SRT_MAX_DIGIT-1)];
    logic qd_neg;
    logic [$clog2(SRT_MAX_DIGIT + 1)-1:0] qd_mag;
    logic signed [REM_WIDTH+BITS_PER_CYCLE:0] qdigit_mul_ext;
    logic [QSEL_ADDR_W-1:0] qsel_addr;
    logic [REM_WIDTH-1:0] d_u;
    logic [REM_WIDTH-1:0] corr_num_q;
    logic [REM_WIDTH-1:0] corr_num_d;
    logic [REM_WIDTH-1:0] corr_rem_u_q;
    logic [REM_WIDTH-1:0] corr_rem_u_d;
    logic [REM_WIDTH-1:0] corr_quot_u_q;
    logic [REM_WIDTH-1:0] corr_quot_u_d;
    logic [CORR_CNT_W-1:0] corr_cnt_q;
    logic [CORR_CNT_W-1:0] corr_cnt_d;
    logic corr_neg_q;
    logic corr_neg_d;
    logic [REM_WIDTH-1:0] corr_rem_shift_u;
    logic [REM_WIDTH-1:0] corr_q_adjust_u;
    logic signed [REM_WIDTH-1:0] rem_corr_s;
    logic signed [QUOT_ACC_WIDTH-1:0] qacc_corr_s;
    logic [WIDTH-1:0] q_mag_u;
    logic [WIDTH-1:0] r_mag_u;
    int bit_hi;
    int idx;
    int threshold;

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

    assign quotient = quotient_q;
    assign remainder = remainder_q;

    assign in_ready = (state_q == S_IDLE);
    assign out_valid = (state_q == S_DONE);

    assign div_by_zero = div_by_zero_q;

    // precompute for run/correction
    always_comb begin
        d_ext = $signed({{(REM_WIDTH-WIDTH){1'b0}}, divisor_q});
        d_ext_wide = {{(BITS_PER_CYCLE+1){d_ext[REM_WIDTH-1]}}, d_ext};
        bit_hi = 0;
        next_bits = '0;
        rem_shifted = '0;
        rem_x2 = '0;
        rem_x2_ext = '0;
        qd_neg = 1'b0;
        qd_mag = '0;
        qdigit_mul_ext = '0;
        for (idx = 0; idx < 2*SRT_MAX_DIGIT; idx++) begin
            d_mult_lut[idx] = '0;
        end
        qsel_addr = '0;
        q_digit = '0;
        rem_next = rem_q;
        qacc_next = qacc_q;
        d_u = {{(REM_WIDTH-WIDTH){1'b0}}, divisor_q};
        corr_rem_shift_u = {corr_rem_u_q[REM_WIDTH-2:0], corr_num_q[REM_WIDTH-1]};
        corr_q_adjust_u = corr_quot_u_q;
        rem_corr_s = rem_q;
        qacc_corr_s = qacc_q;
        q_mag_u = qacc_q[WIDTH-1:0];
        r_mag_u = rem_q[WIDTH-1:0];
        threshold = 0;

        if (state_q == S_RUN) begin
            // pull next dividend bits from msb to lsb over NUM_ITERS cycles
            bit_hi = EVEN_WIDTH - 1 - (iter_q * BITS_PER_CYCLE);
            next_bits = dividend_q[bit_hi -: BITS_PER_CYCLE];
            // trial remainder = previous remainder * radix + incoming bits
            rem_shifted = (rem_q <<< BITS_PER_CYCLE) + $signed({{(REM_WIDTH-BITS_PER_CYCLE){1'b0}}, next_bits});

            // use doubled remainder to keep threshold compares integers
            rem_x2 = $signed({rem_shifted, 1'b0});
            rem_x2_ext = $signed({{BITS_PER_CYCLE{rem_x2[REM_WIDTH]}}, rem_x2});

            // Build all needed divisor multiples once, then reuse for q-select and update.
            d_mult_lut[0] = '0;
            for (idx = 1; idx < 2*SRT_MAX_DIGIT; idx++) begin
                d_mult_lut[idx] = d_mult_lut[idx-1] + d_ext_wide;
            end

            // qsel address packs positive thresholds then negative thresholds
            for (idx = 0; idx < SRT_MAX_DIGIT; idx++) begin
                threshold = (2 * SRT_MAX_DIGIT - 1) - idx;
                qsel_addr[QSEL_ADDR_W-1-idx] = (rem_x2_ext >= d_mult_lut[threshold]);

                threshold = SRT_MAX_DIGIT + idx;
                qsel_addr[SRT_MAX_DIGIT-1-idx] = (rem_x2_ext >= -d_mult_lut[threshold]);
            end
            q_digit = srt_qsel_lookup($unsigned(qsel_addr), SRT_MAX_DIGIT);

            qd_neg = q_digit[QDIG_W-1];
            qd_mag = qd_neg ? $unsigned(-q_digit) : $unsigned(q_digit);
            qdigit_mul_ext = d_mult_lut[qd_mag];
            if (qd_neg) begin
                qdigit_mul_ext = -qdigit_mul_ext;
            end

            rem_next = rem_shifted - qdigit_mul_ext[REM_WIDTH-1:0];
            qacc_next = (qacc_q <<< BITS_PER_CYCLE) + q_digit;
        end

        if ((state_q == S_CORR) && (corr_cnt_q == '0)) begin
            // Final one-pass correction so 0 <= remainder < divisor.
            if (corr_neg_q) begin
                if (corr_rem_u_q != '0) begin
                    corr_q_adjust_u = corr_quot_u_q + {{(REM_WIDTH-1){1'b0}}, 1'b1};
                    rem_corr_s = $signed(d_u - corr_rem_u_q);
                end else begin
                    rem_corr_s = '0;
                end
                qacc_corr_s = qacc_q - $signed({{(QUOT_ACC_WIDTH-REM_WIDTH){1'b0}}, corr_q_adjust_u});
            end else begin
                rem_corr_s = $signed(corr_rem_u_q);
                qacc_corr_s = qacc_q + $signed({{(QUOT_ACC_WIDTH-REM_WIDTH){1'b0}}, corr_q_adjust_u});
            end

            q_mag_u = qacc_corr_s[WIDTH-1:0];
            r_mag_u = rem_corr_s[WIDTH-1:0];
        end
    end

    // next-state/datapath decisions
    always_comb begin
        state_d = state_q;
        iter_d = iter_q;
        quotient_d = quotient_q;
        remainder_d = remainder_q;
        div_by_zero_d = div_by_zero_q;
        dividend_d = dividend_q;
        divisor_d = divisor_q;
        rem_d = rem_q;
        qacc_d = qacc_q;
        quot_neg_d = quot_neg_q;
        rem_neg_d = rem_neg_q;
        corr_num_d = corr_num_q;
        corr_rem_u_d = corr_rem_u_q;
        corr_quot_u_d = corr_quot_u_q;
        corr_cnt_d = corr_cnt_q;
        corr_neg_d = corr_neg_q;

        case (state_q)
            S_IDLE: begin
                if (in_valid) begin
                    quotient_d = '0;
                    remainder_d = '0;
                    iter_d = '0;
                    rem_d = '0;
                    qacc_d = '0;
                    corr_num_d = '0;
                    corr_rem_u_d = '0;
                    corr_quot_u_d = '0;
                    corr_cnt_d = '0;
                    corr_neg_d = 1'b0;

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
                rem_d = rem_next;
                qacc_d = qacc_next;
                iter_d = iter_q + 1'b1;

                if (iter_q == NUM_ITERS - 1) begin
                    // correction pass after the last digit is generated
                    corr_neg_d = rem_next[REM_WIDTH-1];
                    if (rem_next[REM_WIDTH-1]) begin
                        corr_num_d = $unsigned(-rem_next);
                    end else begin
                        corr_num_d = $unsigned(rem_next);
                    end
                    corr_rem_u_d = '0;
                    corr_quot_u_d = '0;
                    corr_cnt_d = CORR_CNT_W'(REM_WIDTH);
                    state_d = S_CORR;
                end
            end

            S_CORR: begin
                if (corr_cnt_q != '0) begin
                    corr_num_d = {corr_num_q[REM_WIDTH-2:0], 1'b0};
                    corr_cnt_d = corr_cnt_q - {{(CORR_CNT_W-1){1'b0}}, 1'b1};

                    if (corr_rem_shift_u >= d_u) begin
                        corr_rem_u_d = corr_rem_shift_u - d_u;
                        corr_quot_u_d = {corr_quot_u_q[REM_WIDTH-2:0], 1'b1};
                    end else begin
                        corr_rem_u_d = corr_rem_shift_u;
                        corr_quot_u_d = {corr_quot_u_q[REM_WIDTH-2:0], 1'b0};
                    end
                end else begin
                    if (SUPPORT_SIGNED) begin
                        quotient_d = quot_neg_q ? ((~q_mag_u) + {{(WIDTH-1){1'b0}}, 1'b1}) : q_mag_u;
                        remainder_d = rem_neg_q ? ((~r_mag_u) + {{(WIDTH-1){1'b0}}, 1'b1}) : r_mag_u;
                    end else begin
                        quotient_d = q_mag_u;
                        remainder_d = r_mag_u;
                    end
                    state_d = S_DONE;
                end
            end

            S_DONE: begin
                // hold output stable until consumer accepts it
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
            qacc_q <= '0;
            divisor_q <= '0;
            quot_neg_q <= 1'b0;
            rem_neg_q <= 1'b0;
            corr_num_q <= '0;
            corr_rem_u_q <= '0;
            corr_quot_u_q <= '0;
            corr_cnt_q <= '0;
            corr_neg_q <= 1'b0;
        end else begin
            state_q <= state_d;
            iter_q <= iter_d;
            quotient_q <= quotient_d;
            remainder_q <= remainder_d;
            div_by_zero_q <= div_by_zero_d;
            dividend_q <= dividend_d;
            divisor_q <= divisor_d;
            rem_q <= rem_d;
            qacc_q <= qacc_d;
            quot_neg_q <= quot_neg_d;
            rem_neg_q <= rem_neg_d;
            corr_num_q <= corr_num_d;
            corr_rem_u_q <= corr_rem_u_d;
            corr_quot_u_q <= corr_quot_u_d;
            corr_cnt_q <= corr_cnt_d;
            corr_neg_q <= corr_neg_d;
        end
    end

endmodule
