`ifndef DECOMPRESSOR_IF_VH 
`define DECOMPRESSOR_IF_VH

interface decompressor_if();
  import rv32i_types_pkg::word_t;
  word_t  inst32;
  logic [15:0] inst16;
  logic edit_rs1, edit_rs2, edit_rd, c_ena;
  
  modport dcpr (
    input inst16,
    output inst32, c_ena, edit_rs1, edit_rs2, edit_rd
  );

  modport cu (
    input edit_rs1, edit_rs2, edit_rd, c_ena
  );

endinterface

`endif //DECOMPRESSOR_IF_VH
