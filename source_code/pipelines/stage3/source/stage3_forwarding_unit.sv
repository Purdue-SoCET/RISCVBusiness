
module stage3_forwarding_unit(
    stage3_forwarding_unit_if.fw_unit fw_if
);

    logic rs1_match, rs2_match;

    assign rs1_match = (fw_if.rd_m != 0) && (fw_if.rs1_e == fw_if.rd_m);
    assign rs2_match = (fw_if.rd_m != 0) && (fw_if.rs2_e == fw_if.rd_m);

    assign fw_if.fwd_rs1 = rs1_match && fw_if.reg_write && !fw_if.load;
    assign fw_if.fwd_rs2 = rs2_match && fw_if.reg_write && !fw_if.load;

endmodule
