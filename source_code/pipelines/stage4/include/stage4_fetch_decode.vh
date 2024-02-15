
`ifndef STAGE4_FETCH_DECODE_IF_VH
`define STAGE4_FETCH_DECODE_IF_VH

interface stage4_fetch_decode_if;
  import rv32i_types_pkg::*;
  import stage4_types_pkg::*;
 
  fetch_in_t fetch_in;

  modport fetch(
    output fetch_ex_reg
  );

  modport decode(
    input fetch_ex_reg
  );

endinterface
`endif
