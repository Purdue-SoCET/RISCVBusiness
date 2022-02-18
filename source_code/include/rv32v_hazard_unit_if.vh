`ifndef RV32V_HAZARD_UNIT_IF_VH
`define RV32V_HAZARD_UNIT_IF_VH

interface rv32v_hazard_unit_if;

  logic stall_f1, flush_f1, stall_f2, flush_f2, stall_dec, flush_dec, stall_ex, flush_ex, stall_mem, flush_mem, csr_update, busy_dec, busy_ex, busy_mem, busy_f1, busy_f2;
  logic exception_mem;
  logic next_busy_ex;
  modport hazard_unit (
    input csr_update, busy_dec, busy_ex, busy_mem,
    output stall_dec, flush_dec, stall_ex, flush_ex, stall_mem, flush_mem,
    flush_f1, stall_f1, flush_f2, stall_f2
  );

  modport fetch1 (
    input stall_f1, flush_f1,
    output busy_f1
  );

  modport fetch2 (
    input stall_f2, flush_f2,
    output busy_f2
  );

  modport decode (
    input stall_dec, flush_dec, busy_ex, busy_mem, next_busy_ex, csr_update,
    output busy_dec
  );

  modport execute (
    input stall_ex, flush_ex, 
    output busy_ex, next_busy_ex
  );

  modport memory (
    input stall_mem, flush_mem, 
    output csr_update, busy_mem, exception_mem
  );

endinterface

`endif // RV32V_HAZARD_UNIT_IF_VH