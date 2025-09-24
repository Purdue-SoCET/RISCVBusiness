`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_hpm ();

    localparam CLK_PERIOD = 10ns;
    localparam NUM_TEST_CASES = 1;

    localparam ADDRLOWERCOUNTER1 = 12'hC00;
    localparam ADDRLOWERCOUNTER2 = 12'hC01;
    localparam ADDRLOWERCOUNTER3 = 12'hC02;
    localparam ADDRLOWERCOUNTER4 = 12'hC03;
    localparam ADDRLOWERCOUNTER5 = 12'hC04;
    localparam ADDRLOWERCOUNTER6 = 12'hC05;
    localparam ADDRLOWERCOUNTER7 = 12'hC06;
    localparam ADDRLOWERCOUNTER8 = 12'hC07;
    localparam ADDRLOWERCOUNTER9 = 12'hC08;
    localparam ADDRLOWERCOUNTER10 = 12'hC09;
    localparam ADDRLOWERCOUNTER11 = 12'hC0A;
    localparam ADDRLOWERCOUNTER12 = 12'hC0B;
    localparam ADDRLOWERCOUNTER13 = 12'hC0C;
    localparam ADDRLOWERCOUNTER14 = 12'hC0D;
    localparam ADDRLOWERCOUNTER15 = 12'hC0E;
    localparam ADDRLOWERCOUNTER16 = 12'hC0F;
    localparam ADDRLOWERCOUNTER17 = 12'hC10;
    localparam ADDRLOWERCOUNTER18 = 12'hC11;
    localparam ADDRLOWERCOUNTER19 = 12'hC12;
    localparam ADDRLOWERCOUNTER20 = 12'hC13;
    localparam ADDRLOWERCOUNTER21 = 12'hC14;
    localparam ADDRLOWERCOUNTER22 = 12'hC15;
    localparam ADDRLOWERCOUNTER23 = 12'hC16;
    localparam ADDRLOWERCOUNTER24 = 12'hC17;
    localparam ADDRLOWERCOUNTER25 = 12'hC18;
    localparam ADDRLOWERCOUNTER26 = 12'hC19;
    localparam ADDRLOWERCOUNTER27 = 12'hC1A;
    localparam ADDRLOWERCOUNTER28 = 12'hC1B;
    localparam ADDRLOWERCOUNTER29 = 12'hC1C;
    localparam ADDRLOWERCOUNTER30 = 12'hC1D;
    localparam ADDRLOWERCOUNTER31 = 12'hC1E;
    localparam ADDRLOWERCOUNTER32 = 12'hC1F;

    logic clk, n_rst;
    
    // DUT Inputs
    logic [31:0] enable_array;
    logic [11:0] priv_csr_addr;
    logic [31:0] priv_value_in;
    logic        priv_csr_active;

    // DUT Outputs
    logic        priv_invalid_csr;
    logic        priv_ack;
    logic [31:0] priv_value_out;

    // CLOCK GENERATION
    always begin
        clk = 0;
        #(CLK_PERIOD / 2.0);
        clk = 1;
        #(CLK_PERIOD / 2.0);
    end

    hpm_wrapper DUT(.*);   //DUT INSTANTIATION

    typedef struct{
        logic        tv_n_rst;
        logic [31:0] tv_enable_array;
        logic [11:0] tv_priv_csr_addr;
        logic [31:0] tv_priv_value_in;
        logic        tv_priv_csr_active;
    }testVector_t;         //HPM TEST VECTOR

    testVector_t hpm_tv[NUM_TEST_CASES];

    task fill_tv;
        input logic        n_rst;
        input logic [31:0] enable_array;
        input logic [11:0] priv_csr_addr;
        input logic [31:0] priv_value_in;
        input logic        priv_csr_active;
        input integer ind;
    begin
        hpm_tv[ind].tv_n_rst = n_rst;
        hpm_tv[ind].tv_enable_array = enable_array;
        hpm_tv[ind].tv_priv_csr_addr = priv_csr_addr;
        hpm_tv[ind].tv_priv_value_in = priv_value_in;
        hpm_tv[ind].tv_priv_csr_active = priv_csr_active;
    end
    endtask

    task init_dut;
    begin
        n_rst = 1;
        enable_array = 32'd0;
        priv_csr_addr = 12'd0;
        priv_value_in = 32'd0;
        priv_csr_active = 1'd0;
        
        @(negedge clk);
        @(negedge clk);
    end
    endtask

    task reset_dut;
    begin
        n_rst = 0;
        @(posedge clk);
        @(posedge clk);
        @(negedge clk);
        n_rst = 1;
        @(negedge clk);
        @(negedge clk);
    end
    endtask

    integer i;

    initial begin
        $dumpfile("waveform.fst");
        $dumpvars(0, tb_hpm);

        reset_dut();
        init_dut();

        //n_rst, [31:0]enable_array, [11:0]priv_csr_addr, [31:0]priv_value_in, priv_csr_active, ind

        fill_tv(1, 32'h0000FFFF, ADDRLOWERCOUNTER1, 32'hCAFEBABE, 1, 0);

        for(i = 0; i < NUM_TEST_CASES; i++) begin
            n_rst = hpm_tv[i].tv_n_rst;
            enable_array = hpm_tv[i].tv_enable_array;
            priv_csr_addr = hpm_tv[i].tv_priv_csr_addr;
            priv_value_in = hpm_tv[i].tv_priv_value_in;
            priv_csr_active = hpm_tv[i].tv_priv_csr_active;

            @(negedge clk);
        end

        @(negedge clk);

        $display("Tests completed");
        $finish;
    end
endmodule