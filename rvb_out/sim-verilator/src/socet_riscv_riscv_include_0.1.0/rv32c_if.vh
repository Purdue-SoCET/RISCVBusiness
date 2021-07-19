`ifndef RV32C_IF_VH 
`define RV32C_IF_VH

interface rv32c_if();

  import rv32i_types_pkg::word_t;

  word_t inst, reset_pc, nextpc, imem_pc, result, inst32, reset_pc_val;
  logic [15:0] inst16;
  logic reset_en, inst_arrived, pc_update, done, c_ena, rv32c_ena, done_earlier, done_earlier_send, halt, ex_busy;
  

  modport rv32c (
    input inst, reset_en, reset_pc, inst_arrived, pc_update, inst16, halt, ex_busy, reset_pc_val,
    output done, nextpc, imem_pc, result, inst32, c_ena, rv32c_ena, done_earlier, done_earlier_send
  );

  modport fetch (
    input done, nextpc, imem_pc, result, rv32c_ena, done_earlier, done_earlier_send,
    output inst, reset_en, reset_pc, inst_arrived, pc_update, reset_pc_val
  );

  modport execute (
    input inst32, c_ena, done_earlier,
    output inst16, halt, ex_busy
  );

endinterface

`endif //RV32C_IF_VH
