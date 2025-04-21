/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : DUT Config Params
*/
`ifndef DUT_PARAMETERS_SV
`define DUT_PARAMETERS_SV

package dut_parameters;
    // DUT Params
    parameter HARTS   = 1;
    parameter RST_PC  = 32'h80000000;
    parameter D_WIDTH = 32;
    parameter A_WIDTH = 32;
endpackage

`endif