`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_counter64bit ();

    localparam CLK_PERIOD = 10ns;
    localparam NUM_TEST_CASES = 18;

    logic clk, n_rst; // CLK / RESET SIGNALS

    logic enable;                // DUT INPUT SIGNALS
    logic [31:0] overwrite_val;  
    logic [1:0] csr_active_sel;  
    logic clear;               

    logic [63:0] count_out;      // DUT OUTPUT SIGNALS
    logic rollover_flag;

    // CLOCK GENERATION
    always begin
        clk = 0;
        #(CLK_PERIOD / 2.0);
        clk = 1;
        #(CLK_PERIOD / 2.0);
    end

    counter64bit DUT(.*);   //DUT INSTANTIATION

    typedef struct{
        logic tv_n_rst;
        logic tv_enable;
        logic [1:0] tv_csr_active_sel;
        logic [31:0] tv_overwrite_val;
        logic tv_clear;
    }testVector_t;         //COUNTER TEST VECTOR

    testVector_t counter_tv[NUM_TEST_CASES];

    task fill_tv;
    input logic n_rst;
    input logic enable;
    input logic [1:0] csr_active_sel;
    input logic [31:0] overwrite_val;
    input logic clear;
    input integer ind;
    begin
        counter_tv[ind].tv_n_rst = n_rst;
        counter_tv[ind].tv_enable = enable;
        counter_tv[ind].tv_csr_active_sel = csr_active_sel;
        counter_tv[ind].tv_overwrite_val = overwrite_val;
        counter_tv[ind].tv_clear = clear;
    end
    endtask

    task init_dut;
    begin
        n_rst = 1;
        enable = 0;
        csr_active_sel = 0;
        overwrite_val = 0;
        clear = 0;
        
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
        $dumpvars(0, tb_counter64bit);

        reset_dut();
        init_dut();

        //n_rst, enable, sel, val, clear, ind

        fill_tv(1, 1, 0, 32'hDEADBEEF, 0, 0); //COUNT UP TO 3
        fill_tv(1, 1, 0, 32'hDEADFFFF, 0, 1);
        fill_tv(1, 1, 0, 32'hDEADDEAD, 0, 2);

        fill_tv(1, 1, 1, 32'hDEADBEEF, 0, 3); //OVERWRITE LOWER 32 BITS TO "DEADBEEF"
	    fill_tv(1, 0, 1, 32'hFFFFFFFF, 0, 4); //OVERWRITE LOWER 32 TO "FFFFFFFF"

	    fill_tv(1, 1, 0, 32'hDEADDEAD, 0, 5); //INCREMENT 5 TIMES
        fill_tv(1, 1, 0, 32'hDEADDEAD, 0, 6); 
        fill_tv(1, 1, 0, 32'hDEADDEAD, 0, 7);
        fill_tv(1, 1, 0, 32'hDEADDEAD, 0, 8);
        fill_tv(1, 1, 0, 32'hDEADDEAD, 0, 9); 


        fill_tv(1, 1, 0, 32'hDEADDEAD, 1, 10); //CLEAR


        fill_tv(1, 0, 2, 32'hDEADBEEF, 0, 11); //OVERWRITE UPPER 32 BITS TO "DEADBEEF"
        fill_tv(1, 0, 1, 32'hAFAFAFAF, 0, 12); //OVERWRITE LOWER 32 TO "AFAFAFAF"

        fill_tv(1, 0, 2, 32'hFFFFFFFF, 0, 13); //WRITE TO UPPER
        fill_tv(1, 0, 1, 32'hFFFFFFFE, 0, 14); //WRITE TO LOWER
        fill_tv(1, 1, 0, 32'hDEADDEAD, 0, 15); //INCREMENT 3 TIMES TO SEE IF ROLLOVER
        fill_tv(1, 1, 0, 32'hDEADDEAD, 0, 16); 
        fill_tv(1, 1, 0, 32'hDEADDEAD, 0, 17);

        for(i = 0; i < NUM_TEST_CASES; i++) begin
            n_rst = counter_tv[i].tv_n_rst;
            enable = counter_tv[i].tv_enable;
            csr_active_sel = counter_tv[i].tv_csr_active_sel;
            overwrite_val = counter_tv[i].tv_overwrite_val;
            clear = counter_tv[i].tv_clear;

            @(negedge clk);
        end

        @(negedge clk);

        $display("Tests completed");
        $finish;
    end
endmodule
