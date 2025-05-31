
`include "generic_bus_if.vh"

module tb_fetch_buffer();

    typedef struct {
        logic [31:0] data;
        logic compressed;
    } ExpectedValue;

    typedef struct {
        logic [31:0] addr;
        logic inv;
        logic read;
    } InsnVector;

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
        repeat(latency) @(posedge clk);
        #(1);

        //if(icache.addr > memory.size()) $stop("Bad address");
        value = memory[icache.addr >> 2];
        icache.busy = 1'b0;
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
            $display("Bus sim: reset bus signals");
            reset_bus();
            // wait for read
            $display("Bus sim: Await ren signal");
            while(!icache.ren) @(posedge clk); #(1);
            $display("Bus sim: prepare response");
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

    task automatic await_insn(ExpectedValue expected);
        while(!insn_valid) begin
            @(posedge clk);
            #(1);
        end
        if(expected.compressed) begin
            assert(insn_compressed == 1'b1)
            else $display("Expected compressed instruction");

            assert(insn_out[15:0] == expected.data[15:0]);
            else $display("Incorrect value observed");
        end else begin
            assert(insn_compressed == 1'b0)
            else $display("Expected full-size instruction");

            assert(insn_out == expected.data)
            else $display("Incorrect value observed");
        end
    endtask

    task automatic requester();
        for(int i = 0; i < istream.size(); i++) begin
            send_request(istream[i]);
            if(istream[i].read) begin
                await_insn(expected[i]);
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

    initial begin
        $dumpfile("waveform.fst");
        $dumpvars(0, tb_fetch_buffer);
        reset_bus();
        reset_dut();
        $display("Starting...");
        // test 1: just 32b insns
        memory = new[4];
        istream = new[4];
        expected = new[4];

        // TODO: generate istream/expected from 'mem' contents.
        // ...or vice-versa
        // all full-size insns
        memory = '{32'hF, 32'hFF, 32'hFFF, 32'hFFFF};
        istream = '{'{32'h0, 1'b0, 1'b1}, '{32'h4, 1'b0, 1'b1},
                    '{32'h8, 1'b0, 1'b1}, '{32'hC, 1'b0, 1'b1}};
        expected = '{'{32'h000F, 1'b0}, '{32'h00FF, 1'b0},
                     '{32'h0FFF, 1'b0}, '{32'hFFFF, 1'b0}};
        run_trace();

        reset_dut();
        memory = new [2];
        istream = new [4];
        expected = new [4];
        memory = '{{16'h4, 16'h42}, {16'h4001, 16'h8002}};
        istream = '{'{32'h0, 1'b0, 1'b1}, '{32'h2, 1'b0, 1'b1},
                    '{32'h4, 1'b0, 1'b1}, '{32'h6, 1'b0, 1'b1}};
        expected = '{'{32'h42, 1'b1}, '{32'h4, 1'b1},
                     '{32'h8002, 1'b1}, '{32'h4001, 1'b1}};
        run_trace();

        $finish();
    end

endmodule