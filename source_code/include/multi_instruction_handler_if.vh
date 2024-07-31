`ifndef MULTI_INSTRUCTION_HANDLER_IF_VH 
`define MULTI_INSTRUCTION_HANDLER_IF_VH

interface multi_instruction_handler_if();
  import rv32i_types_pkg::word_t;
  logic c_push, c_pop, c_popretz, c_popret, c_mvsa01, c_mva01s;
  logic c_jt, c_jalt;
  word_t inst32;
  logic hazard_dis, fetch_dis;
  
  modport mih (
    input c_push, c_pop, c_popretz, c_popret, c_mvsa01, c_mva01s, c_jt, c_jalt, //flags for all multi-instruction instructions
    output inst32, hazard_dis, fetch_dis // 32 bit uncompressed instruction, hazard freeze and fetch freeze flags.
  );

  modport dcpr (
    output c_push, c_pop, c_popretz, c_popret, c_mvsa01, c_mva01s, c_jt, c_jalt //flags for all multi-instruction instructions
  )

endinterface

`endif //MULTI_INSTRUCTION_HANDLER_IF_VH
