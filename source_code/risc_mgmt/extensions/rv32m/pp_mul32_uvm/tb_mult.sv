`include "pp_mul32.sv"
`include "mult_if.svh"
`include "test.svh"

`timescale 1ps/1ps
import uvm_pkg::*;

module tb_mult();
    logic clk;

    initial begin
        clk  = 0;
        forever #10 clk = !clk;
    end

    mult_if pp_mult32_if(clk);
    pp_mult32 MULT(pp_mult32_if);

    initial
    begin
        uvm_config_db#(virtual mult_if)::set( null, "", "vif", fc_if);
        run_test("test");
    end

endmodule: tb_mult;