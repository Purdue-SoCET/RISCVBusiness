`include "predictor_pipeline_if.vh"

`timescale 1ns/100ps
module tb_pht();
    parameter period = 10;
    logic CLK = 0, nRST;
    
    //test signals
    int tb_test_num;
    string tb_test_case;

    //clock generator
    always #(PERIOD / 2) CLK ++;

    //interface
    predictor_pipeline_if ppif();

    pht DUT(CLK, nRST, ppif.predictor, ppif.pht_prediction);

    task reset_dut;
        begin
            nRST = 1'b0;

            @(posedge CLK);
            @(posedge CLK);
            
            @(negedge CLK);
            nRST = 1'b1;

            @(posedge CLK);
            @(posedge CLK);
        end
    endtask

    initial begin: TEST_PROC
        tb_test_num = -1;
        tb_test_case = "TB_INIT";
        nRST = 1'b1;


        //test0, reset dut
        @(posedge CLK)
        tb_test_num += 1;
        tb_test_case = "power-on reset"
        reset_dut();
        $finish;
    end
endmodule


