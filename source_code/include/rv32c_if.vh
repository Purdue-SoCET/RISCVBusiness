`ifndef RV32C_IF_VH 
`define RV32C_IF_VH

interface rv32c_if();

  import rv32i_types_pkg::word_t;

  word_t inst, reset_pc, nextpc, countread, result, inst32;
  logic [15:0] inst16;
  logic reset_en, inst_arrived, pc_update, done, c_ena, rv32c_ena, done_earlier, done_earlier_send, halt, dmem_busy;
  
  modport rv32c (
    input inst, reset_en, reset_pc, inst_arrived, pc_update, inst16, halt, dmem_busy,
    output done, nextpc, countread, result, inst32, c_ena, rv32c_ena, done_earlier, done_earlier_send
  );

  modport fetch (
    input done, nextpc, countread, result, rv32c_ena, done_earlier, done_earlier_send,
    output inst, reset_en, reset_pc, inst_arrived, pc_update
  );

  modport execute (
    input inst32, c_ena, done_earlier,
    output inst16, halt, dmem_busy
  );

endinterface

`endif //RV32C_IF_VH
