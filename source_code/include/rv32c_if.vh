`ifndef RV32C_IF_VH 
`define RV32C_IF_VH

interface rv32c_if();

  import rv32i_types_pkg::word_t;

  word_t inst, reset_pc, nextpc, countread, result, inst32;
  logic [15:0] inst16;
  logic reset_en, inst_arrived, pc_update, done, c_ena, rv32c_ena;
  
  modport rv32c (
    input inst, reset_en, reset_pc, inst_arrived, pc_update, inst16,
    output done, nextpc, countread, result, inst32, c_ena, rv32c_ena
  );

  modport fetch (
    input done, nextpc, countread, result, rv32c_ena,
    output inst, reset_en, reset_pc, inst_arrived, pc_update
  );

  modport execute (
    input inst32, c_ena,
    output inst16,
  );

endinterface

`endif //RV32C_IF_VH
