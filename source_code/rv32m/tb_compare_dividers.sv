`timescale 1ns/10ps

module tb_compare_dividers;
    parameter time CLOCK_PERIOD = 10ns;

    logic tb_CLK;
    logic tb_nRST;

    logic tb_start;
    logic tb_finished;
    logic [31:0] tb_operand_a;
    logic [31:0] tb_operand_b;
    logic [31:0] tb_radix4_quotient;
    logic [31:0] tb_radix4_remainder;
    logic [1:0] tb_is_signed;

    logic tb_srt_in_valid;
    logic tb_srt_in_ready;
    logic tb_srt_out_valid;
    logic tb_srt_out_ready;
    logic [31:0] tb_srt_dividend;
    logic [31:0] tb_srt_divisor;
    logic [31:0] tb_srt_quotient;
    logic [31:0] tb_srt_remainder;
    logic tb_srt_dbz;

    logic tb_srt_in_valid_u;
    logic tb_srt_in_ready_u;
    logic tb_srt_out_valid_u;
    logic tb_srt_out_ready_u;
    logic [31:0] tb_srt_dividend_u;
    logic [31:0] tb_srt_divisor_u;
    logic [31:0] tb_srt_quotient_u;
    logic [31:0] tb_srt_remainder_u;
    logic tb_srt_dbz_u;

    typedef struct {
        string test_name;
        logic [31:0] test_operand_a;
        logic [31:0] test_operand_b;
        logic [1:0] test_is_signed;
    } testvector_t;

    testvector_t tb_test_case[];

    radix4_divider #(.NUM_BITS(32)) RADIX4_DUT (
        .CLK(tb_CLK),
        .nRST(tb_nRST),
        .start(tb_start),
        .is_signed(tb_is_signed[0]),
        .dividend(tb_operand_a),
        .divisor(tb_operand_b),
        .quotient(tb_radix4_quotient),
        .remainder(tb_radix4_remainder),
        .finished(tb_finished)
    );

    srt_div #(
        .WIDTH(64),
        .SUPPORT_SIGNED(1'b1),
        .BITS_PER_CYCLE(4)
    ) SRT_SIGNED_DUT (
        .CLK(tb_CLK),
        .nRST(tb_nRST),
        .in_valid(tb_srt_in_valid),
        .dividend(tb_srt_dividend),
        .divisor(tb_srt_divisor),
        .out_ready(tb_srt_out_ready),
        .in_ready(tb_srt_in_ready),
        .out_valid(tb_srt_out_valid),
        .quotient(tb_srt_quotient),
        .remainder(tb_srt_remainder),
        .div_by_zero(tb_srt_dbz)
    );

    srt_div #(
        .WIDTH(32),
        .SUPPORT_SIGNED(1'b0),
        .BITS_PER_CYCLE(2)
    ) SRT_UNSIGNED_DUT (
        .CLK(tb_CLK),
        .nRST(tb_nRST),
        .in_valid(tb_srt_in_valid_u),
        .dividend(tb_srt_dividend_u),
        .divisor(tb_srt_divisor_u),
        .out_ready(tb_srt_out_ready_u),
        .in_ready(tb_srt_in_ready_u),
        .out_valid(tb_srt_out_valid_u),
        .quotient(tb_srt_quotient_u),
        .remainder(tb_srt_remainder_u),
        .div_by_zero(tb_srt_dbz_u)
    );

    always begin
        tb_CLK = 1'b0;
        #(CLOCK_PERIOD/2.0);
        tb_CLK = 1'b1;
        #(CLOCK_PERIOD/2.0);
    end

    task automatic reset_dut();
        begin
            tb_nRST = 1'b0;
            tb_start = 1'b0;
            tb_operand_a = '0;
            tb_operand_b = '0;
            tb_is_signed = '0;

            tb_srt_in_valid = 1'b0;
            tb_srt_out_ready = 1'b0;
            tb_srt_dividend = '0;
            tb_srt_divisor = '0;

            tb_srt_in_valid_u = 1'b0;
            tb_srt_out_ready_u = 1'b0;
            tb_srt_dividend_u = '0;
            tb_srt_divisor_u = '0;

            repeat (3) @(posedge tb_CLK);
            tb_nRST = 1'b1;
            @(posedge tb_CLK);
        end
    endtask

    task automatic run_case(
        input testvector_t tc,
        input int idx
    );
        logic [31:0] exp_q;
        logic [31:0] exp_r;
        logic exp_dbz;
        logic [31:0] got_q_radix4;
        logic [31:0] got_r_radix4;
        logic [31:0] got_q_srt;
        logic [31:0] got_r_srt;
        logic skip_radix4_compare;
        logic radix4_done_seen;
        logic srt_done_seen;
        int radix4_cycles;
        int srt_cycles;
        int global_cycles;
        logic signed [31:0] signed_a;
        logic signed [31:0] signed_b;
        logic [31:0] unsigned_q;
        logic [31:0] unsigned_r;

        begin
            $display("CASE %0d: %s", idx, tc.test_name);

            reset_dut();

            tb_operand_a = tc.test_operand_a;
            tb_operand_b = tc.test_operand_b;
            tb_is_signed = tc.test_is_signed;
            skip_radix4_compare = (tc.test_operand_b == '0);

            if (tc.test_is_signed) begin
                tb_srt_dividend = tc.test_operand_a;
                tb_srt_divisor = tc.test_operand_b;
                tb_srt_in_valid = 1'b1;
                tb_srt_out_ready = 1'b0;

                tb_srt_in_valid_u = 1'b0;
                tb_srt_out_ready_u = 1'b0;
            end else begin
                tb_srt_dividend_u = tc.test_operand_a;
                tb_srt_divisor_u = tc.test_operand_b;
                tb_srt_in_valid_u = 1'b1;
                tb_srt_out_ready_u = 1'b0;

                tb_srt_in_valid = 1'b0;
                tb_srt_out_ready = 1'b0;
            end

            @(negedge tb_CLK);
            tb_start = 1'b1;
            tb_srt_in_valid = 1'b0;
            tb_srt_in_valid_u = 1'b0;

            radix4_cycles = 0;
            srt_cycles = 0;
            radix4_done_seen = 1'b0;
            srt_done_seen = 1'b0;
            global_cycles = 0;

            while (!(radix4_done_seen && srt_done_seen)) begin
                @(posedge tb_CLK);
                global_cycles++;

                if (!radix4_done_seen) begin
                    radix4_cycles++;
                    if (tb_finished) begin
                        radix4_done_seen = 1'b1;
                        got_q_radix4 = tb_radix4_quotient;
                        got_r_radix4 = tb_radix4_remainder;
                    end
                end

                if (!srt_done_seen) begin
                    srt_cycles++;
                    if (tc.test_is_signed) begin
                        if (tb_srt_out_valid) begin
                            srt_done_seen = 1'b1;
                            got_q_srt = tb_srt_quotient;
                            got_r_srt = tb_srt_remainder;
                        end
                    end else begin
                        if (tb_srt_out_valid_u) begin
                            srt_done_seen = 1'b1;
                            got_q_srt = tb_srt_quotient_u;
                            got_r_srt = tb_srt_remainder_u;
                        end
                    end
                end

                if (global_cycles > 256) begin
                    if (!radix4_done_seen) begin
                        $error("Timeout waiting for radix4 divider to finish");
                    end else begin
                        $error("Timeout waiting for SRT divider to finish");
                    end
                    $stop;
                end
            end

            tb_start = 1'b0;
            if (tc.test_is_signed) begin
                tb_srt_out_ready = 1'b1;
                @(posedge tb_CLK);
                tb_srt_out_ready = 1'b0;
            end else begin
                tb_srt_out_ready_u = 1'b1;
                @(posedge tb_CLK);
                tb_srt_out_ready_u = 1'b0;
            end

            exp_dbz = (tc.test_operand_b == '0);
            if (exp_dbz) begin
                exp_q = 32'hFFFF_FFFF;
                exp_r = tc.test_operand_a;
            end else if (tc.test_is_signed && tc.test_operand_a == 32'h8000_0000 && tc.test_operand_b == 32'hFFFF_FFFF) begin
                exp_q = 32'h8000_0000;
                exp_r = '0;
            end else if (tc.test_is_signed) begin
                signed_a = $signed(tc.test_operand_a);
                signed_b = $signed(tc.test_operand_b);
                exp_q = signed_a / signed_b;
                exp_r = signed_a % signed_b;
            end else begin
                unsigned_q = tc.test_operand_a / tc.test_operand_b;
                unsigned_r = tc.test_operand_a % tc.test_operand_b;
                exp_q = unsigned_q;
                exp_r = unsigned_r;
            end

            if (!skip_radix4_compare && ((got_q_radix4 !== exp_q) || (got_r_radix4 !== exp_r))) begin
                $error("Radix4 mismatch case %0d (%s): got q=%h r=%h exp q=%h r=%h",
                       idx, tc.test_name, got_q_radix4, got_r_radix4, exp_q, exp_r);
                $stop;
            end

            if (skip_radix4_compare) begin
                $display("  radix4 skipped for dbz vector");
            end else begin
                $display("  radix4 q=%h r=%h", got_q_radix4, got_r_radix4);
            end

            if ((got_q_srt !== exp_q) || (got_r_srt !== exp_r)) begin
                $error("SRT mismatch case %0d (%s): got q=%h r=%h exp q=%h r=%h",
                       idx, tc.test_name, got_q_srt, got_r_srt, exp_q, exp_r);
                $stop;
            end

            if (tc.test_is_signed) begin
                if (tb_srt_dbz !== exp_dbz) begin
                    $error("SRT dbz mismatch case %0d (%s): got dbz=%0d exp dbz=%0d",
                           idx, tc.test_name, tb_srt_dbz, exp_dbz);
                    $stop;
                end
            end else begin
                if (tb_srt_dbz_u !== exp_dbz) begin
                    $error("SRT dbz mismatch case %0d (%s): got dbz=%0d exp dbz=%0d",
                           idx, tc.test_name, tb_srt_dbz_u, exp_dbz);
                    $stop;
                end
            end

            $display("  radix4 cycles = %0d%s", radix4_cycles, skip_radix4_compare ? " (dbz, not compared)" : "");
            $display("  srt    cycles = %0d", srt_cycles);
            $display("  q/r/dbz match = PASS");
        end
    endtask

    initial begin
        tb_test_case = new[10];

        tb_test_case[0].test_name = "Basic signed division. Positive & Positive.";
        tb_test_case[0].test_operand_a = 32'h0000_0080;
        tb_test_case[0].test_operand_b = 32'h0000_0002;
        tb_test_case[0].test_is_signed = '1;

        tb_test_case[1].test_name = "Basic signed division. Positive & Negative.";
        tb_test_case[1].test_operand_a = 32'h0000_0080;
        tb_test_case[1].test_operand_b = 32'hFFFF_FFFE;
        tb_test_case[1].test_is_signed = '1;

        tb_test_case[2].test_name = "Basic signed division. Negative & Negative.";
        tb_test_case[2].test_operand_a = 32'hFFFF_FFB0;
        tb_test_case[2].test_operand_b = 32'hFFFF_FFFE;
        tb_test_case[2].test_is_signed = '1;

        tb_test_case[3].test_name = "Basic signed division. Negative & Positive.";
        tb_test_case[3].test_operand_a = 32'hFFFF_FFB0;
        tb_test_case[3].test_operand_b = 32'h0000_0002;
        tb_test_case[3].test_is_signed = '1;

        tb_test_case[4].test_name = "Signed divide by 0.";
        tb_test_case[4].test_operand_a = 32'hFFFF_FFB0;
        tb_test_case[4].test_operand_b = 32'h0000_0000;
        tb_test_case[4].test_is_signed = '1;

        tb_test_case[5].test_name = "Basic unsigned division. Positive & Positive.";
        tb_test_case[5].test_operand_a = 32'h0000_0080;
        tb_test_case[5].test_operand_b = 32'h0000_0002;
        tb_test_case[5].test_is_signed = '0;

        tb_test_case[6].test_name = "Basic unsigned division. Positive & (signed) Negative.";
        tb_test_case[6].test_operand_a = 32'h0000_0080;
        tb_test_case[6].test_operand_b = 32'hFFFF_FFFE;
        tb_test_case[6].test_is_signed = '0;

        tb_test_case[7].test_name = "Basic unsigned division. (signed) Negative & (signed) Negative.";
        tb_test_case[7].test_operand_a = 32'hFFFF_FFB0;
        tb_test_case[7].test_operand_b = 32'hFFFF_FFFE;
        tb_test_case[7].test_is_signed = '0;

        tb_test_case[8].test_name = "Basic unsigned division. (signed) Negative & Positive.";
        tb_test_case[8].test_operand_a = 32'hFFFF_FFB0;
        tb_test_case[8].test_operand_b = 32'h0000_0002;
        tb_test_case[8].test_is_signed = '0;

        tb_test_case[9].test_name = "Unsigned divide by 0.";
        tb_test_case[9].test_operand_a = 32'hFFFF_FFB0;
        tb_test_case[9].test_operand_b = 32'h0000_0000;
        tb_test_case[9].test_is_signed = '0;

        for (int i = 0; i < tb_test_case.size(); i++) begin
            run_case(tb_test_case[i], i);
        end

        $display("tb_compare_dividers: PASS (%0d cases)", tb_test_case.size());
        $finish;
    end

endmodule
