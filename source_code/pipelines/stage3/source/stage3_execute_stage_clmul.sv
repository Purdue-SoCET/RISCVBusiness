logic rv32clmul_done;
word_t rv32clmul_out;

rv32clmul_wrapper RV32CLMUL_FU (
    .CLK(CLK),
    .nRST(nRST),
    .rv32clmul_start(cu_if.rv32clmul_control.select && !hazard_if.mem_use_stall),
    .operation(cu_if.rv32clmul_control.op),
    .rv32clmul_a(rs1_post_fwd),
    .rv32clmul_b(rs2_post_fwd),
    .rv32clmul_done(rv32clmul_done),
    .rv32clmul_out(rv32clmul_out)
);

always_comb begin
    if(cu_if.rv32m_control.select) begin
        ex_out = rv32m_out;
    end else if(cu_if.rv32b_control.select) begin
        ex_out = rv32b_out;
    end else if(cu_if.rv32clmul_control.select) begin
        ex_out = rv32clmul_out;
    end else begin
        ex_out = alu_if.port_out;
    end
end

assign hazard_if.ex_busy = (!rv32m_done && cu_if.rv32m_control.select)
                        || (!rv32clmul_done && cu_if.rv32clmul_control.select);


