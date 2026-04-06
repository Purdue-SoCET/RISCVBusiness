`timescale 1ns/10ps

module tb_srt_divider;
    localparam int WIDTH = 32;
    localparam time CLOCK_PERIOD = 10ns;

    logic tb_CLK;
    logic tb_nRST;

    logic tb_in_valid_s;
    logic [WIDTH-1:0] tb_dividend_s;
    logic [WIDTH-1:0] tb_divisor_s;
    logic tb_out_ready_s;
    logic tb_in_ready_s;
    logic tb_out_valid_s;
    logic [WIDTH-1:0] tb_quotient_s;
    logic [WIDTH-1:0] tb_remainder_s;
    logic tb_div_by_zero_s;

    logic tb_in_valid_u;
    logic [WIDTH-1:0] tb_dividend_u;
    logic [WIDTH-1:0] tb_divisor_u;
    logic tb_out_ready_u;
    logic tb_in_ready_u;
    logic tb_out_valid_u;
    logic [WIDTH-1:0] tb_quotient_u;
    logic [WIDTH-1:0] tb_remainder_u;
    logic tb_div_by_zero_u;

    typedef struct {
        string name;
        logic use_signed;
        logic [WIDTH-1:0] a;
        logic [WIDTH-1:0] b;
    } testvector_t;

    testvector_t testcases[];

    srt_div #(
        .WIDTH(WIDTH),
        .SUPPORT_SIGNED(1'b1),
        .BITS_PER_CYCLE(2)
    ) DUT_SIGNED (
        .CLK(tb_CLK),
        .nRST(tb_nRST),
        .in_valid(tb_in_valid_s),
        .dividend(tb_dividend_s),
        .divisor(tb_divisor_s),
        .out_ready(tb_out_ready_s),
        .in_ready(tb_in_ready_s),
        .out_valid(tb_out_valid_s),
        .quotient(tb_quotient_s),
        .remainder(tb_remainder_s),
        .div_by_zero(tb_div_by_zero_s)
    );

    srt_div #(
        .WIDTH(WIDTH),
        .SUPPORT_SIGNED(1'b0),
        .BITS_PER_CYCLE(2)
    ) DUT_UNSIGNED (
        .CLK(tb_CLK),
        .nRST(tb_nRST),
        .in_valid(tb_in_valid_u),
        .dividend(tb_dividend_u),
        .divisor(tb_divisor_u),
        .out_ready(tb_out_ready_u),
        .in_ready(tb_in_ready_u),
        .out_valid(tb_out_valid_u),
        .quotient(tb_quotient_u),
        .remainder(tb_remainder_u),
        .div_by_zero(tb_div_by_zero_u)
    );

    always begin
        tb_CLK = 1'b0;
        #(CLOCK_PERIOD/2.0);
        tb_CLK = 1'b1;
        #(CLOCK_PERIOD/2.0);
    end

    task automatic reset_dut;
        begin
            tb_nRST = 1'b0;
            tb_in_valid_s = 1'b0;
            tb_dividend_s = '0;
            tb_divisor_s = '0;
            tb_out_ready_s = 1'b0;
            tb_in_valid_u = 1'b0;
            tb_dividend_u = '0;
            tb_divisor_u = '0;
            tb_out_ready_u = 1'b0;

            @(posedge tb_CLK);
            @(posedge tb_CLK);
            tb_nRST = 1'b1;
            @(posedge tb_CLK);
        end
    endtask

    task automatic run_case(
        input testvector_t tc,
        input int idx
    );
        logic [WIDTH-1:0] exp_q;
        logic [WIDTH-1:0] exp_r;
        logic exp_dbz;
        logic [WIDTH-1:0] got_q;
        logic [WIDTH-1:0] got_r;
        logic got_dbz;
        int timeout;

        begin
            $display("CASE %0d: %s", idx, tc.name);

            if (tc.use_signed) begin
                timeout = 0;
                while (!tb_in_ready_s) begin
                    @(posedge tb_CLK);
                    timeout++;
                    if (timeout > 256) begin
                        $error("Timeout waiting for signed in_ready");
                        $stop;
                    end
                end

                tb_dividend_s = tc.a;
                tb_divisor_s = tc.b;
                tb_in_valid_s = 1'b1;
                @(posedge tb_CLK);
                tb_in_valid_s = 1'b0;

                timeout = 0;
                while (!tb_out_valid_s) begin
                    @(posedge tb_CLK);
                    timeout++;
                    if (timeout > 512) begin
                        $error("Timeout waiting for signed out_valid");
                        $stop;
                    end
                end

                got_q = tb_quotient_s;
                got_r = tb_remainder_s;
                got_dbz = tb_div_by_zero_s;
            end else begin
                timeout = 0;
                while (!tb_in_ready_u) begin
                    @(posedge tb_CLK);
                    timeout++;
                    if (timeout > 256) begin
                        $error("Timeout waiting for unsigned in_ready");
                        $stop;
                    end
                end

                tb_dividend_u = tc.a;
                tb_divisor_u = tc.b;
                tb_in_valid_u = 1'b1;
                @(posedge tb_CLK);
                tb_in_valid_u = 1'b0;

                timeout = 0;
                while (!tb_out_valid_u) begin
                    @(posedge tb_CLK);
                    timeout++;
                    if (timeout > 512) begin
                        $error("Timeout waiting for unsigned out_valid");
                        $stop;
                    end
                end

                got_q = tb_quotient_u;
                got_r = tb_remainder_u;
                got_dbz = tb_div_by_zero_u;
            end

            exp_dbz = (tc.b == '0);
            if (exp_dbz) begin
                exp_q = '1;
                exp_r = tc.a;
            end else if (tc.use_signed && tc.a == 32'h8000_0000 && tc.b == 32'hffff_ffff) begin
                exp_q = 32'h8000_0000;
                exp_r = '0;
            end else if (tc.use_signed) begin
                logic signed [WIDTH-1:0] a_s;
                logic signed [WIDTH-1:0] b_s;
                logic signed [WIDTH-1:0] q_s;
                logic signed [WIDTH-1:0] r_s;
                a_s = signed'(tc.a);
                b_s = signed'(tc.b);
                q_s = a_s / b_s;
                r_s = a_s % b_s;
                exp_q = q_s;
                exp_r = r_s;
            end else begin
                exp_q = tc.a / tc.b;
                exp_r = tc.a % tc.b;
            end

            if ((got_q !== exp_q) || (got_r !== exp_r) || (got_dbz !== exp_dbz)) begin
                $error("Mismatch on case %0d (%s): got q=%h r=%h dbz=%0d, exp q=%h r=%h dbz=%0d",
                       idx, tc.name, got_q, got_r, got_dbz, exp_q, exp_r, exp_dbz);
                $stop;
            end

            if (tc.use_signed) begin
                tb_out_ready_s = 1'b1;
                @(posedge tb_CLK);
                tb_out_ready_s = 1'b0;
            end else begin
                tb_out_ready_u = 1'b1;
                @(posedge tb_CLK);
                tb_out_ready_u = 1'b0;
            end
        end
    endtask

    initial begin
        testcases = new[14];

        testcases[0]  = '{"signed pp",           1'b1, 32'h0000_0080, 32'h0000_0002};
        testcases[1]  = '{"signed pn",           1'b1, 32'h0000_0080, 32'hffff_fffe};
        testcases[2]  = '{"signed nn",           1'b1, 32'hffff_ffb0, 32'hffff_fffe};
        testcases[3]  = '{"signed np",           1'b1, 32'hffff_ffb0, 32'h0000_0002};
        testcases[4]  = '{"signed div by zero",  1'b1, 32'h1234_abcd, 32'h0000_0000};
        testcases[5]  = '{"signed overflow",     1'b1, 32'h8000_0000, 32'hffff_ffff};
        testcases[6]  = '{"signed rem check",    1'b1, 32'hffff_fffd, 32'h0000_0002};

        testcases[7]  = '{"unsigned pp",         1'b0, 32'h0000_0080, 32'h0000_0002};
        testcases[8]  = '{"unsigned hi-bit",     1'b0, 32'hffff_ffb0, 32'h0000_0002};
        testcases[9]  = '{"unsigned div by zero",1'b0, 32'h1234_abcd, 32'h0000_0000};
        testcases[10] = '{"unsigned rem check",  1'b0, 32'hffff_fff1, 32'h0000_000f};
        testcases[11] = '{"unsigned random 1",   1'b0, 32'h5a5a_1234, 32'h0000_0041};
        testcases[12] = '{"signed random 1",     1'b1, 32'h8abc_def0, 32'hffff_ff9d};
        testcases[13] = '{"signed random 2",     1'b1, 32'h7fff_ff10, 32'h0000_0101};

        reset_dut();

        for (int i = 0; i < testcases.size(); i++) begin
            run_case(testcases[i], i);
        end

        $display("tb_srt_divider: PASS (%0d cases)", testcases.size());
        $finish;
    end

endmodule
