`ifndef FETCH_BUFFER_IF_VH 
`define FETCH_BUFFER_IF_VH

interface fetch_buffer_if();
  import rv32i_types_pkg::word_t;

  word_t inst, reset_pc, nextpc, countread, result;
  logic reset_en, inst_arrived, pc_update, done;
  
  modport fb (
    input inst, reset_en, reset_pc, inst_arrived, pc_update,
    output done, nextpc, countread, result
  );

endinterface

`endif //FETCH_BUFFER_IF_VH
