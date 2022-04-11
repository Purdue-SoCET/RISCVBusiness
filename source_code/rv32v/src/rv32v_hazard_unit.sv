`include "rv32v_hazard_unit_if.vh"

module rv32v_hazard_unit (
  rv32v_hazard_unit_if.hazard_unit hu_if
);
  //import rv32i_types_pkg::*;

  // TODO: Add exception signal to flush

  // fetch1 stage
  assign hu_if.flush_f1 = hu_if.csr_update; // TODO: Edit this when integration
  assign hu_if.stall_f1 = hu_if.busy_mem | hu_if.busy_ex | hu_if.busy_dec; // TODO: Edit this when integration

  // fetch2 stage
  assign hu_if.flush_f2 = hu_if.csr_update; // TODO: Edit this when integration
  assign hu_if.stall_f2 = hu_if.busy_mem | hu_if.busy_ex | hu_if.busy_dec; // TODO: Edit this when integration

  // decode stage
  assign hu_if.flush_dec = hu_if.csr_update;
  assign hu_if.stall_dec = hu_if.busy_mem | hu_if.busy_ex; // double check

  // execute stage
  assign hu_if.flush_ex = hu_if.v_done;
  // assign hu_if.stall_ex = hu_if.busy_mem | hu_if.busy_ex;
  assign hu_if.stall_ex = hu_if.busy_mem;

  // memory stage
  assign hu_if.flush_mem = hu_if.v_done;
  assign hu_if.stall_mem = hu_if.busy_mem;

endmodule
