`ifndef FETCH_BUFFER_IF_VH 
`define FETCH_BUFFER_IF_VH

interface fetch_buffer_if();
  import rv32i_types_pkg::word_t;


  word_t inst, reset_pc, nextpc, imem_pc, result, reset_pc_val;
  logic reset_en, inst_arrived, pc_update, done, done_earlier, done_earlier_send, ex_busy;
  
  modport fb (
    input inst, reset_en, reset_pc, inst_arrived, pc_update, ex_busy, reset_pc_val,
    output done, nextpc, imem_pc, result, done_earlier, done_earlier_send
  );

endinterface

`endif //FETCH_BUFFER_IF_VH
