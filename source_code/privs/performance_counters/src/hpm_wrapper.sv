`timescale 1ns / 10ps
`include "priv_ext_if.vh"

/*
modport ext (
    output invalid_csr, ack, value_out,
    input csr_addr, value_in, csr_active
);
*/

module hpm_wrapper(
    input logic         clk,
    input logic         n_rst,
    input logic  [31:0] enable_array,
    
    input logic  [11:0] priv_csr_addr,
    input logic  [31:0] priv_value_in,
    input logic         priv_csr_active,

    output logic        priv_invalid_csr,
    output logic        priv_ack,
    output logic [31:0] priv_value_out
);
    // Instantiate interface
    priv_ext_if priv_if();

    // Inputs
    assign priv_if.csr_addr = priv_csr_addr;
    assign priv_if.value_in = priv_value_in;
    assign priv_if.csr_active = priv_csr_active;

    // Outputs
    assign priv_invalid_csr = priv_if.invalid_csr;
    assign priv_ack = priv_if.ack;
    assign priv_value_out = priv_if.value_out;

    // Instantiate original HPM
    hpm u_hpm(
        .clk(clk),
        .n_rst(n_rst),
        .enable_array(enable_array),
        .priv(priv_if)
    );
endmodule