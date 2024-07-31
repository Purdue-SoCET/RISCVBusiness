`ifndef DECOMPRESSOR_IF_VH 
`define DECOMPRESSOR_IF_VH

interface decompressor_if();
  import rv32i_types_pkg::word_t;
  word_t  inst32;
  logic [15:0] inst16;
  logic c_ena;
  
  modport dcpr (
    input inst16, //16 bit instruction
    output inst32, c_ena // 32 bit uncompressed instruction, c extension enabled
  );

  modport cu (
    input c_ena
  );

  modport mih (
    input inst32, inst16
  )

endinterface

`endif //DECOMPRESSOR_IF_VH
