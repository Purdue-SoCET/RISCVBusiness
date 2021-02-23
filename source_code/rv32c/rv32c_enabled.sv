`include "rv32c_if.vh"
`include "fetch_buffer_if.vh"
`include "decompressor_if.vh"

module rv32c_enabled
(
  input logic clk, nrst,
  rv32c_if.rv32c rv32cif 
 );
  parameter RESET_PC = 32'h80000000;
  // Fetch Buffer
  fetch_buffer_if fb_if();
  fetch_buffer #(RESET_PC) BUFFER
  (
    .clk(clk),
    .n_rst(nrst),
    .fb_if(fb_if)
  );
  assign fb_if.inst = rv32cif.inst;
  assign fb_if.reset_en = rv32cif.reset_en;
  assign fb_if.reset_pc = rv32cif.reset_pc;
  assign fb_if.inst_arrived = rv32cif.inst_arrived;
  assign fb_if.pc_update = rv32cif.pc_update;
  assign rv32cif.done = fb_if.done;
  assign rv32cif.nextpc = fb_if.nextpc;
  assign rv32cif.countread = fb_if.countread;
  assign rv32cif.result = fb_if.result;

  // Decompressor
  decompressor_if dcpr_if();
  decompressor DECOMPRESSOR (dcpr_if);
  assign dcpr_if.inst16 = rv32cif.inst16;
  assign rv32cif.inst32 = dcpr_if.inst32;
  assign rv32cif.c_ena = dcpr_if.c_ena;

  assign rv32cif.rv32c_ena = 1;

endmodule
