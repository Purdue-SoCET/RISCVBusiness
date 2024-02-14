
`ifndef STAGE4_FETCH_DECODE_IF_VH
`define STAGE4_FETCH_DECODE_IF_VH

interface stage4_fetch_decode_if;
  import rv32i_types_pkg::*;
  import stage4_types_pkg::*;
 
  fetch_in_t fetch_in;

  uop_t uop;  

  modport fetch(
    output fetch_ex_reg
  );

  modport decode(
    input fetch_ex_reg
    output uop_out
  );

  modport ex(
    input uop_out
  ); 

  // modport execute(
  //   input uop
  //   //input fetch_ex_reg
  // );

  // modport s_decode(
  //   input fetch_ex_reg, 
  //   output s_ctrls, s_num_uops
  // ); 

  // modport queue(
  //   input s_ctrls, s_num_uops, 
  //   output uop
  // ); 

endinterface
`endif
