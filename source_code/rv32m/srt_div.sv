module srt_div #( // V72 S_CORR removed PASSES AGGRESSIVE TESTS
    parameter int WIDTH = 32,
    parameter int BITS_PER_CYCLE = 3
) (
    input  logic CLK,
    input  logic nRST,
    input  logic in_valid,
    input  logic is_signed,
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
    localparam int NUM_ITERS = (WIDTH + BITS_PER_CYCLE - 1) / BITS_PER_CYCLE;
    localparam int EVEN_WIDTH = NUM_ITERS * BITS_PER_CYCLE;
    localparam int PAD_BITS = EVEN_WIDTH - WIDTH;
    // remainder width for headroom on max shift and comparison
    localparam int REM_WIDTH = WIDTH + 4; 

    typedef enum logic [1:0] {
        S_IDLE,
        S_RUN,
        S_DONE
    } state_t;

    state_t state_q, state_d;

    logic [$clog2(NUM_ITERS + 1)-1:0] iter_q, iter_d;
    logic [WIDTH-1:0] quotient_q, quotient_d;
    logic [WIDTH-1:0] remainder_q, remainder_d;
    logic div_by_zero_q, div_by_zero_d;
    
    logic [EVEN_WIDTH-1:0] dividend_q, dividend_d;
    logic [WIDTH-1:0] divisor_q, divisor_d;
    
    logic [REM_WIDTH-1:0] rem_sum_q, rem_sum_d;
    logic [REM_WIDTH-1:0] rem_carry_q, rem_carry_d;
    
    // on the fly conv reg
    logic [EVEN_WIDTH-1:0] Q_q, Q_d;
    logic [EVEN_WIDTH-1:0] QM_q, QM_d;
    
    logic quot_neg_q, quot_neg_d;
    logic rem_neg_q, rem_neg_d;

    // runstate combinational
    logic [EVEN_WIDTH-1:0] div_shift;
    logic [BITS_PER_CYCLE-1:0] next_bits;
    
    int q_digit;
    logic [REM_WIDTH-1:0] q_term_mag;
    logic [REM_WIDTH-1:0] q_term;
    logic [REM_WIDTH-1:0] rem_sum_shift, rem_sum_next;
    logic [REM_WIDTH-1:0] rem_carry_shift, rem_carry_next;
    
    logic signed [REM_WIDTH:0] rem_est_w;
    logic signed [REM_WIDTH:0] rem_x2;
    logic [REM_WIDTH-1:0] d_u;
    int digit_mag;

    // otfc wires
    logic [EVEN_WIDTH-1:0] Q_base, QM_base;
    logic [EVEN_WIDTH-1:0] Q_next, QM_next;
    logic [BITS_PER_CYCLE-1:0] q_bits, q_bits_minus_1;

    function automatic logic [WIDTH-1:0] tc_abs(input logic [WIDTH-1:0] v);
        return v[WIDTH-1] ? (~v + {{(WIDTH-1){1'b0}}, 1'b1}) : v;
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

    // otfc setup mapping
    assign q_bits = BITS_PER_CYCLE'(q_digit);
    assign q_bits_minus_1 = q_bits - 1'b1;
    
    assign Q_base  = (q_digit >= 0) ? Q_q : QM_q;
    assign QM_base = (q_digit > 0)  ? Q_q : QM_q;
    
    assign Q_next  = (Q_base  << BITS_PER_CYCLE) | {{(EVEN_WIDTH-BITS_PER_CYCLE){1'b0}}, q_bits};
    assign QM_next = (QM_base << BITS_PER_CYCLE) | {{(EVEN_WIDTH-BITS_PER_CYCLE){1'b0}}, q_bits_minus_1};

    // comb datapath
    always_comb begin
        div_shift = dividend_q >> (EVEN_WIDTH - BITS_PER_CYCLE - (iter_q * BITS_PER_CYCLE));
        next_bits = div_shift[BITS_PER_CYCLE-1:0];
        
        d_u = {{(REM_WIDTH-WIDTH){1'b0}}, divisor_q};
        
        rem_sum_shift = (rem_sum_q <<< BITS_PER_CYCLE) | {{(REM_WIDTH-BITS_PER_CYCLE){1'b0}}, next_bits};
        rem_carry_shift = rem_carry_q <<< BITS_PER_CYCLE;

        rem_est_w = $signed({rem_sum_shift[REM_WIDTH-1], rem_sum_shift}) + 
                    $signed({rem_carry_shift[REM_WIDTH-1], rem_carry_shift});
        rem_x2 = rem_est_w <<< 1;

        q_digit = 0;
        for (int i = SRT_MAX_DIGIT; i >= 1; i--) begin
            logic [REM_WIDTH:0] threshold;
            threshold = d_u * ((2 * i) - 1); // srt bound (i - 0.5) * D
            if (rem_x2 >= $signed({1'b0, threshold})) begin
                q_digit = i;
                break;
            end else if (rem_x2 <= -$signed({1'b0, threshold})) begin
                q_digit = -i;
                break;
            end
        end

        digit_mag = (q_digit < 0) ? -q_digit : q_digit;
        q_term_mag = d_u * digit_mag;
        q_term = (q_digit >= 0) ? -$signed({1'b0, q_term_mag}) : $signed({1'b0, q_term_mag});
    end

    // nexstate and datapath sequential decisions
    always_comb begin
        state_d = state_q;
        iter_d = iter_q;
        div_by_zero_d = div_by_zero_q;
        dividend_d = dividend_q;
        divisor_d = divisor_q;
        quotient_d  = quotient_q;
        remainder_d = remainder_q;
        rem_sum_d = rem_sum_q;
        rem_carry_d = rem_carry_q;
        Q_d = Q_q;
        QM_d = QM_q;
        quot_neg_d = quot_neg_q;
        rem_neg_d = rem_neg_q;

        case (state_q)
            S_IDLE: begin
                if (in_valid) begin
                    logic [WIDTH-1:0] abs_divd;
                    logic [WIDTH-1:0] abs_divs;
                    abs_divd = (is_signed && dividend[WIDTH-1]) ? tc_abs(dividend) : dividend;
                    abs_divs = (is_signed && divisor[WIDTH-1])  ? tc_abs(divisor) : divisor;

                    quotient_d = '0;
                    remainder_d = '0;
                    iter_d = '0;
                    rem_sum_d = '0;
                    rem_carry_d = '0;
                    Q_d = '0;
                    QM_d = '0;

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

            S_RUN: begin
                rem_sum_d = rem_sum_next;
                rem_carry_d = rem_carry_next;
                Q_d = Q_next;
                QM_d = QM_next;
                iter_d = iter_q + 1'b1;

                if (iter_q == NUM_ITERS - 1) begin
                    // eval final partial remainder NO MORE S_CORR :D
                    logic signed [REM_WIDTH:0] final_rem;
                    logic [REM_WIDTH:0] divisor_ext;
                    logic [WIDTH-1:0] raw_q;
                    logic [WIDTH-1:0] raw_rem;

                    final_rem = $signed({rem_sum_next[REM_WIDTH-1], rem_sum_next}) + 
                                $signed({rem_carry_next[REM_WIDTH-1], rem_carry_next});
                    divisor_ext = {{(REM_WIDTH + 1 - WIDTH){1'b0}}, divisor_q};

                    if (final_rem < 0) begin
                        // negative remainder -> restore remainder, pick decremented quotient QM
                        raw_q = QM_next[WIDTH-1:0];
                        raw_rem = final_rem[WIDTH-1:0] + divisor_q; 
                    end else if ($unsigned(final_rem) >= $unsigned(divisor_ext)) begin
                        // too big remainder -> subtract divisor, increment quotient
                        raw_q = Q_next[WIDTH-1:0] + {{(WIDTH-1){1'b0}}, 1'b1};
                        raw_rem = final_rem[WIDTH-1:0] - divisor_q;
                    end else begin
                        raw_q = Q_next[WIDTH-1:0];
                        raw_rem = final_rem[WIDTH-1:0];
                    end

                    quotient_d = quot_neg_q ? (~raw_q + {{(WIDTH-1){1'b0}}, 1'b1}) : raw_q;
                    remainder_d = rem_neg_q  ? (~raw_rem + {{(WIDTH-1){1'b0}}, 1'b1}) : raw_rem;

                    state_d = S_DONE;
                end
            end

            S_DONE: begin
                if (out_ready) state_d = S_IDLE;
            end

            default: state_d = S_IDLE;
        endcase
    end

    // async reset registers
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            state_q <= S_IDLE;
            iter_q <= '0;
            quotient_q <= '0;
            remainder_q <= '0;
            div_by_zero_q <= 1'b0;
            dividend_q <= '0;
            rem_sum_q <= '0;
            rem_carry_q <= '0;
            Q_q <= '0;
            QM_q <= '0;
            divisor_q <= '0;
            quot_neg_q <= 1'b0;
            rem_neg_q <= '0;
        end else begin
            state_q <= state_d;
            iter_q <= iter_d;
            quotient_q <= quotient_d;
            remainder_q <= remainder_d;
            div_by_zero_q <= div_by_zero_d;
            dividend_q <= dividend_d;
            divisor_q <= divisor_d;
            rem_sum_q <= rem_sum_d;
            rem_carry_q <= rem_carry_d;
            Q_q <= Q_d;
            QM_q <= QM_d;
            quot_neg_q <= quot_neg_d;
            rem_neg_q <= rem_neg_d;
        end
    end

endmodule