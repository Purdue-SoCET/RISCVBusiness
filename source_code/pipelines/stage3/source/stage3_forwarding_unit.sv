
module stage3_forwarding_unit(
    stage3_forwarding_unit_if.fw_unit fw_if
);

    logic rs1_match, rs2_match;

    assign rs1_match = (fw_if.rd_m.regidx != 0) && (fw_if.rs1_e.regidx == fw_if.rd_m.regidx);
    assign rs2_match = (fw_if.rd_m.regidx != 0) && (fw_if.rs2_e.regidx == fw_if.rd_m.regidx);

    assign fw_if.fwd_rs1 = rs1_match && fw_if.reg_write && !fw_if.load;
    assign fw_if.fwd_rs2 = rs2_match && fw_if.reg_write && !fw_if.load;

endmodule
