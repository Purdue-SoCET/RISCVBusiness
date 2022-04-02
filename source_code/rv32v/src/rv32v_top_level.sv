`include "rv32v_reorder_buffer_if.vh"

module rv32v_top_level(  
  input logic CLK, nRST, 
  cache_model_if.memory cif,
  rv32v_hazard_unit_if hu_if,
  prv_pipeline_if prv_if,
  rv32v_top_level_if.rv32v top_if
);

  // Outputs
  logic rd_wen;
  logic [4:0] rd_sel;
  logic [31:0] rd_data;
  logic [31:0] xs1, xs2;
  logic done;
  logic decode_done;
  logic returnex;
  logic scalar_hazard_if_ret;

  //change this to scalar_vector_if
  scalar_vector_decode_if  scalar_vector_if();

  rv32v_decode_execute_if decode_execute_if();
  rv32v_execute_memory_if execute_memory_if();
  rv32v_memory_writeback_if memory_writeback_if();
  rv32v_reg_file_if rfv_if();
  rv32v_reorder_buffer_if rob_if();


  rv32v_decode_stage  decode_stage(.*);
  rv32v_execute_stage execute_stage(.*);
  rv32v_memory_stage mem_stage(.*);
  rv32v_writeback_stage writeback_stage(.*);
  
  rv32v_hazard_unit hazard_unit(.*);
  rv32v_reg_file reg_file(.*);
  rv32v_reorder_buffer rob(.*);
  
  assign top_if.rd_wen = rd_wen;
  assign top_if.rd_sel = rd_sel;
  assign top_if.rd_data = rd_data;
  assign top_if.done = done;

  // Inputs
  assign xs1 = top_if.rs1_data;
  assign xs2 = top_if.rs2_data;
  assign scalar_hazard_if_ret = top_if.scalar_hazard_if_ret;
  assign returnex = top_if.returnex;
  assign rob_if.alloc_ena = top_if.alloc_ena;
  assign scalar_vector_if.instr = top_if.instr;
  assign scalar_vector_if.index = top_if.instr;

endmodule
