`ifndef STAGE3_UOP_IF_VH
`define STAGE3_UOP_IF_VH

interface uop_if;
  import rv32i_types_pkg::*;
  import stage3_types_pkg::*;
 
  fetch_ex_t fetch_ex_reg;
  word_t brj_addr;

  modport ctrls_in(
    output fetch_ex_reg
  );

  modport ctrls_out(
    output fetch_ex_reg
  ); 

  modport rf_out(
    output fetch_ex_reg
  );

  modport fetch_in(

  );

  modport fetch_out(

  ); 


  modport execute(
    input fetch_ex_reg
  );

endinterface

`endif