
`include "generic_bus_if.vh"

module tb_fetch_buffer();

    localparam FETCH_BUFFER_TESTS = 4; // increment when adding a new test

    typedef struct {
        logic [31:0] data;
        logic compressed;
    } ExpectedValue;

    typedef struct {
        logic [31:0] addr;
        logic inv;
        logic read;
    } InsnVector;

    typedef struct {
        logic [31:0] memory [];
        InsnVector istream [];
        ExpectedValue expected[];
    } TestVector;

    function automatic string format_expected(ExpectedValue e);
        return $sformatf("Expected (%s) %x", e.compressed ? "C" : "F", e.data);
    endfunction

    function automatic string format_insn(InsnVector iv);
        return $sformatf("%s @ %x", iv.read ? "Read" : (iv.inv ? "Inv" : "Stall"), iv.addr);
    endfunction

    function automatic string format_failure(InsnVector iv, ExpectedValue ev, logic [31:0] actual);
        string istring = format_insn(iv);
        string estring = format_expected(ev);

        return $sformatf("%t %s %s Got %x", $time, istring, estring, actual);
    endfunction

    generic_bus_if icache();
    logic clk;
    logic rst_n;
    logic [31:0] pc;
    logic ren, invalidate;
    logic insn_valid, insn_compressed;
    logic [31:0] insn_out;

    logic [31:0] memory [];
    InsnVector istream [];
    ExpectedValue expected[];
    TestVector tv [];

    fetch_buffer DUT(
        .CLK(clk),
        .nRST(rst_n),
        .*
    );

    // clock gen
    always #(10) clk++;

    task automatic do_response(int latency);
        logic [31:0] value;
        icache.busy = 1'b1;
        repeat(latency) begin
            // read abort case
            if(!icache.ren) begin
                break;
            end
            @(posedge clk);
        end
        #(1);

        //if(icache.addr > memory.size()) $stop("Bad address");
        value = memory[icache.addr >> 2];
        icache.busy = !icache.ren; // read abort
        icache.rdata = value;
        icache.error = 1'b0;
        @(posedge clk); #(1);
    endtask

    task automatic reset_bus();
        icache.busy = 1'b1;
        icache.rdata = 32'hBAD1BAD1;
        icache.error = 1'b0;
    endtask

    task automatic bus_sim(int latency);
        // just do this forever, count on
        // 'join_any' to cut us off when no longer
        // needed
        while(1) begin
            //$display("Bus sim: reset bus signals");
            reset_bus();
            // wait for read
            //$display("Bus sim: Await ren signal");
            while(!icache.ren) @(posedge clk); #(1);
            //$display("Bus sim: prepare response");
            do_response(latency);
        end
    endtask

    task automatic send_request(InsnVector vec);
        pc = vec.addr;
        ren = vec.read;
        invalidate = vec.inv;
        @(posedge clk);
        #(1);
    endtask

    task automatic reset_inputs();
        pc = 0;
        ren = 1'b0;
        invalidate = 1'b0;
    endtask

    task automatic await_insn(InsnVector insn, ExpectedValue expected);
        while(!insn_valid) begin
            #(1);
        end
        #(1);
        // HACK: Need insn_valid stable. TB is low-quality.
        while(!insn_valid) begin
            #(1);
        end
        if(expected.compressed) begin
            assert(insn_compressed == 1'b1)
            else $display("Expected compressed instruction");

            assert(insn_out[15:0] == expected.data[15:0]);
            else $display(format_failure(insn, expected, {16'b0, insn_out[15:0]}));
        end else begin
            assert(insn_compressed == 1'b0)
            else $display("Expected uncompressed instruction");

            assert(insn_out == expected.data)
            else $display(format_failure(insn, expected, insn_out));
        end
        @(posedge clk);
        #(1);
    endtask

    task automatic requester();
        for(int i = 0; i < istream.size(); i++) begin
            send_request(istream[i]);
            if(istream[i].read) begin
                await_insn(istream[i], expected[i]);
            end
        end
    endtask

    task automatic run_trace();
        fork
            requester();
            bus_sim(1);
            timeout();
        join_any
        disable fork;
    endtask

    task automatic reset_dut();
        rst_n = 1'b0;
        repeat(2) @(posedge clk);
        rst_n = 1'b1;
    endtask

    task automatic timeout();
        repeat(1000) @(posedge clk);
    endtask

    task automatic setup_tv();
        integer test_num = 0;
        // define tv
        tv = new[FETCH_BUFFER_TESTS];

        //--------------------------------
        // Test 1: All 32b insns
        //--------------------------------
        test_num = 0;
        tv[test_num].memory = new[4];
        tv[test_num].memory = '{
            32'h000F,
            32'h00FF,
            32'h0FFF,
            32'hFFFF
        };

        tv[test_num].istream = new[4];
        tv[test_num].istream = '{
            '{32'h0, 1'b0, 1'b1},
            '{32'h4, 1'b0, 1'b1},
            '{32'h8, 1'b0, 1'b1},
            '{32'hC, 1'b0, 1'b1}
        };

        tv[test_num].expected = new[4];
        tv[test_num].expected = '{
            '{32'h000F, 1'b0},
            '{32'h00FF, 1'b0},
            '{32'h0FFF, 1'b0},
            '{32'hFFFF, 1'b0}
        };

        //--------------------------------
        // Test 2: All 16b insns
        //--------------------------------
        test_num++;
        tv[test_num].memory = new[2];
        tv[test_num].memory = '{
            {16'h0004, 16'h0042},
            {16'h4001, 16'h8002}
        };

        tv[test_num].istream = new[4];
        tv[test_num].istream = '{
            '{32'h0, 1'b0, 1'b1},
            '{32'h2, 1'b0, 1'b1},
            '{32'h4, 1'b0, 1'b1},
            '{32'h6, 1'b0, 1'b1}
        };

        tv[test_num].expected = new[4];
        tv[test_num].expected = '{
            '{32'h0042, 1'b1},
            '{32'h0004, 1'b1},
            '{32'h8002, 1'b1},
            '{32'h4001, 1'b1}
        };

        //--------------------------------
        // Test 3: mixed 16 and 32b
        // | 16:32l | 32h:16 |
        //--------------------------------
        test_num++;
        tv[test_num].memory = new[2];
        tv[test_num].memory = '{
            {16'h0003, 16'h0002}, // lower of 32b, 16b
            {16'h2221, 16'h3333}  // second 16b, upper of 32b
        };

        tv[test_num].istream = new[3];
        tv[test_num].istream = '{
            '{32'h0, 1'b0, 1'b1}, // 16b @ 0x0
            '{32'h2, 1'b0, 1'b1}, // 32b @ 0x2-0x4
            '{32'h6, 1'b0, 1'b1}  // 16b @ 0x6
        };

        tv[test_num].expected = new[3];
        tv[test_num].expected = '{
            '{32'h00000002, 1'b1},
            '{32'h33330003, 1'b0},
            '{32'h00002221, 1'b1}
        };

        //--------------------------------
        // Test 4: Invalidation trace
        // Simulate branch to misaligned addr w/32b value.
        // Start at PC 0, invalidate, goto PC 6.
        // FB will store upper 16, but should invalidate immediately.
        // | 16 : 16 | 16 : 32l | 32h : ... |
        //--------------------------------
        test_num++;
        tv[test_num].memory = new[3];
        tv[test_num].memory = '{
            {16'h0004, 16'h0002}, 
            {16'h0003, 16'h2221},
            {16'hABCD, 16'h3330}
        };

        tv[test_num].istream = new[3];
        tv[test_num].istream = '{
            '{32'h0, 1'b0, 1'b1}, // 16b @ 0x0
            '{32'h2, 1'b1, 1'b0}, // INV branch to 0x6
            '{32'h6, 1'b0, 1'b1}  // 32b @ 0x6
        };

        tv[test_num].expected = new[3];
        tv[test_num].expected = '{
            '{32'h00000002, 1'b1},
            '{32'h00000000, 1'b0}, // placeholder for inv. step
            '{32'h33300003, 1'b0}
        };

        // Add more tests here...
    endtask

    initial begin
        $dumpfile("waveform.fst");
        $dumpvars(0, tb_fetch_buffer);
        reset_bus();
        reset_dut();
        setup_tv();

        $display("Starting...");
        for (integer test_num = 0; test_num < FETCH_BUFFER_TESTS; test_num++) begin
            $display("---- Starting Test %0d ----", test_num + 1);
            reset_dut();
            memory   = tv[test_num].memory;
            istream  = tv[test_num].istream;
            expected = tv[test_num].expected;
            run_trace();
            $display("---- Finished Test %0d ----\n", test_num + 1);
        end

        $finish();
    end

endmodule
