`timescale 1ns/10ps

module tb_srt_divider;
    parameter int TEST_WIDTH = 32;
    parameter bit TEST_SIGNED = 1'b0;
    localparam int WIDTH = TEST_WIDTH;
    localparam time CLOCK_PERIOD = 10ns;

    typedef enum int {
        MODE_AUTO = 0,
        MODE_EXHAUSTIVE = 1,
        MODE_RANDOM = 2
    } run_mode_t;

    logic tb_CLK;
    logic tb_nRST;
    logic tb_in_valid;
    logic [WIDTH-1:0] tb_dividend;
    logic [WIDTH-1:0] tb_divisor;
    logic tb_out_ready;
    logic tb_in_ready;
    logic tb_out_valid;
    logic [WIDTH-1:0] tb_quotient;
    logic [WIDTH-1:0] tb_remainder;
    logic tb_div_by_zero;

    longint unsigned rng_state;
    int unsigned random_count;
    run_mode_t mode_sel;
    string mode_str;

    srt_div #(
        .WIDTH(WIDTH),
        .SUPPORT_SIGNED(TEST_SIGNED),
        .BITS_PER_CYCLE(2)
    ) DUT (
        .CLK(tb_CLK),
        .nRST(tb_nRST),
        .in_valid(tb_in_valid),
        .dividend(tb_dividend),
        .divisor(tb_divisor),
        .out_ready(tb_out_ready),
        .in_ready(tb_in_ready),
        .out_valid(tb_out_valid),
        .quotient(tb_quotient),
        .remainder(tb_remainder),
        .div_by_zero(tb_div_by_zero)
    );

    always begin
        tb_CLK = 1'b0;
        #(CLOCK_PERIOD/2.0);
        tb_CLK = 1'b1;
        #(CLOCK_PERIOD/2.0);
    end

    function automatic longint unsigned width_mask();
        if (WIDTH >= 64) begin
            return 64'hffff_ffff_ffff_ffff;
        end
        return (64'd1 << WIDTH) - 1;
    endfunction

    function automatic longint signed sign_extend(input longint unsigned v);
        longint unsigned sign;
        begin
            if (WIDTH >= 64) begin
                return longint'(v);
            end
            sign = 64'd1 << (WIDTH - 1);
            return longint'((v ^ sign) - sign);
        end
    endfunction

    task automatic next_rand64(inout longint unsigned state, output longint unsigned value);
        begin
            // xorshift64* style update gives deterministic pseudo-random vectors.
            state = state ^ (state << 13);
            state = state ^ (state >> 7);
            state = state ^ (state << 17);
            value = state;
        end
    endtask

    task automatic apply_reset();
        begin
            tb_nRST = 1'b0;
            tb_in_valid = 1'b0;
            tb_out_ready = 1'b0;
            tb_dividend = '0;
            tb_divisor = '0;
            repeat (4) @(posedge tb_CLK);
            tb_nRST = 1'b1;
            @(posedge tb_CLK);
        end
    endtask

    task automatic wait_in_ready(input int timeout_cycles);
        int i;
        begin
            for (i = 0; i < timeout_cycles; i++) begin
                if (tb_in_ready) begin
                    return;
                end
                @(posedge tb_CLK);
            end
            $error("Timeout waiting for in_ready");
            $stop;
        end
    endtask

    task automatic wait_out_valid(input int timeout_cycles);
        int i;
        begin
            for (i = 0; i < timeout_cycles; i++) begin
                if (tb_out_valid) begin
                    return;
                end
                @(posedge tb_CLK);
            end
            $error("Timeout waiting for out_valid");
            $stop;
        end
    endtask

    task automatic run_case(
        input longint unsigned a,
        input longint unsigned b,
        input longint unsigned idx
    );
        longint unsigned mask;
        longint unsigned a_m;
        longint unsigned b_m;
        longint unsigned exp_q;
        longint unsigned exp_r;
        bit exp_dbz;
        longint unsigned got_q;
        longint unsigned got_r;
        longint signed a_s;
        longint signed b_s;
        longint signed q_s;
        longint signed r_s;
        begin
            mask = width_mask();
            a_m = a & mask;
            b_m = b & mask;

            wait_in_ready(128);
            tb_dividend = a_m[WIDTH-1:0];
            tb_divisor = b_m[WIDTH-1:0];
            tb_in_valid = 1'b1;
            @(posedge tb_CLK);
            tb_in_valid = 1'b0;

            wait_out_valid(256);

            exp_dbz = (b_m == 0);
            if (exp_dbz) begin
                exp_q = mask;
                exp_r = a_m;
            end else if (TEST_SIGNED) begin
                a_s = sign_extend(a_m);
                b_s = sign_extend(b_m);
                if ((WIDTH >= 64) && (a_s == 64'sh8000_0000_0000_0000) && (b_s == -64'sd1)) begin
                    q_s = 64'sh8000_0000_0000_0000;
                    r_s = 64'sd0;
                end else begin
                    q_s = a_s / b_s;
                    r_s = a_s % b_s;
                end
                exp_q = $unsigned(q_s) & mask;
                exp_r = $unsigned(r_s) & mask;
            end else begin
                exp_q = a_m / b_m;
                exp_r = a_m % b_m;
            end

            got_q = $unsigned(tb_quotient) & mask;
            got_r = $unsigned(tb_remainder) & mask;

            if ((got_q != exp_q) || (got_r != exp_r) || (tb_div_by_zero != exp_dbz)) begin
                $error("Mismatch idx=%0d a=%0d b=%0d got(q,r,dbz)=(%0d,%0d,%0d) exp=(%0d,%0d,%0d)",
                       idx, a_m, b_m, got_q, got_r, tb_div_by_zero, exp_q, exp_r, exp_dbz);
                $stop;
            end

            tb_out_ready = 1'b1;
            @(posedge tb_CLK);
            tb_out_ready = 1'b0;
        end
    endtask

    initial begin
        longint unsigned i;
        longint unsigned limit;
        longint unsigned a;
        longint unsigned b;
        longint unsigned rnd;

        if ((WIDTH <= 0) || (WIDTH > 64)) begin
            $error("tb_srt_divider supports TEST_WIDTH in [1, 64], got %0d", WIDTH);
            $finish;
        end

        mode_sel = MODE_AUTO;
        random_count = 10000;
        rng_state = 64'h0000_0000_5EED_C0DE;

        if ($value$plusargs("mode=%s", mode_str)) begin
            if (mode_str == "auto") begin
                mode_sel = MODE_AUTO;
            end else if (mode_str == "exhaustive") begin
                mode_sel = MODE_EXHAUSTIVE;
            end else if (mode_str == "random") begin
                mode_sel = MODE_RANDOM;
            end else begin
                $error("Invalid mode '%s'. Use mode=auto|exhaustive|random", mode_str);
                $finish;
            end
        end

        void'($value$plusargs("count=%d", random_count));
        void'($value$plusargs("seed=%h", rng_state));

        apply_reset();

        if (mode_sel == MODE_AUTO) begin
            mode_sel = (WIDTH <= 16) ? MODE_EXHAUSTIVE : MODE_RANDOM;
        end

        if (mode_sel == MODE_EXHAUSTIVE) begin
            if (WIDTH >= 64) begin
                $error("Exhaustive mode is not supported for WIDTH=%0d", WIDTH);
                $finish;
            end

            limit = 64'd1 << WIDTH;
            for (i = 0; i < limit; i++) begin
                a = i;
                b = (i * 64'h0000_0000_9E37_79B1);
                run_case(a, b, i);
            end

            $display("tb_srt_divider.sv: PASS (%0d cases - exhaustive, signed=%0d)", limit, TEST_SIGNED);
        end else begin
            for (i = 0; i < random_count; i++) begin
                next_rand64(rng_state, rnd);
                a = rnd;
                next_rand64(rng_state, rnd);
                b = rnd;
                if ((i % 29) == 0) begin
                    b = 0;
                end
                run_case(a, b, i);
            end

            $display("tb_srt_divider.sv: PASS (%0d cases - random, signed=%0d)", random_count, TEST_SIGNED);
        end

        $finish;
    end

endmodule
