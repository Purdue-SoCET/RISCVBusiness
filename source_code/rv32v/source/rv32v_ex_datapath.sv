import rv32v_types_pkg::*; 
import rv32i_types_pkg::*; 

module rv32v_ex_datapath(
    input logic CLK, nRST, 
    input word_t rdat1, rdat2, imm, 
    input vcontrol_t vctrls, 
    input vwb_t vwb_ctrls, 
    output vexmem_t vmem_in
);

logic[127:0] v0; 
word_t[3:0] bankdat_src1, xbardat_src1;
word_t[3:0] bankdat_src2, xbardat_src2 ;  
word_t[3:0] vopA, vopB; 

// store data  
assign vmem_in.vs2 = xbardat_src1; 

// Banks 
rv32v_vector_bank VBANK0 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vctrls.vs2_sel), 
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[0]), .byte_wen(vwb_ctrls.vbyte_wen[0]), 
    .vdat1(bankdat_src1[0]), .vdat2(bankdat_src2[0]), 
    .v0(v0[31:0])
); 

rv32v_vector_bank VBANK1 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vctrls.vs2_sel), 
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[1]), .byte_wen(vwb_ctrls.vbyte_wen[1]), 
    .vdat1(bankdat_src1[1]), .vdat2(bankdat_src2[1]), 
    .v0(v0[63:32])
);

rv32v_vector_bank VBANK2 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vctrls.vs2_sel), 
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[2]), .byte_wen(vwb_ctrls.vbyte_wen[2]), 
    .vdat1(bankdat_src1[2]), .vdat2(bankdat_src2[2]), 
    .v0(v0[95:64])
);

rv32v_vector_bank VBANK3 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vctrls.vs2_sel), 
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[3]), .byte_wen(vwb_ctrls.vbyte_wen[3]), 
    .vdat1(bankdat_src1[3]), .vdat2(bankdat_src2[3]), 
    .v0(v0[127:96])
);


// read xbars 
rv32v_read_xbar VSRC1_XBAR(
    .bank_dat(bankdat_src1), 
    .veew(vctrls.veew_src1),
    .bank_offset(vctrls.vbank_offset),
    .sign_ext(vctrls.vsignext),
    .out_dat(xbardat_src1)
); 

rv32v_read_xbar VSRC2_XBAR(
    .bank_dat(bankdat_src2), 
    .veew(vctrls.veew_src2),
    .bank_offset(vctrls.vbank_offset), // NOTE: need a diff bankoffset for the two sources 
    .sign_ext(vctrls.vsignext), // NOTE: do we need different ones? 
    .out_dat(xbardat_src2)
); 

// vector functional units 
always_comb begin
    vopA = xbardat_src1; 
    vopB = xbardat_src2; 

    if(vctrls.vxin1_use_imm) begin
        vopA = {4{imm}};
    end
    else if(vctrls.vxin1_use_rs1) begin
        vopA = {4{rdat1}}; 
    end
    
    if(vctrls.vxin2_use_rs2) begin
        vopB = {4{rdat2}}; 
    end
    

    vmem_in.valu_res[0] = vopA[0] + vopB[0]; 
    vmem_in.valu_res[1] = vopA[1] + vopB[1]; 
    vmem_in.valu_res[2] = vopA[2] + vopB[2]; 
    vmem_in.valu_res[3] = vopA[3] + vopB[3]; 
end


// Maskings

// NOTE: need to handle in decode whether masking is enable by looking at bit 25 (1 is no, 0 is yes)
rv32v_mask_unit RVV_MASKS(
    .v0(v0), 
    .mask_enable(1'b0), 
    .uop_num(vctrls.vuop_num), 
    .lane_active(vctrls.vlaneactive),
    .lane_mask(vmem_in.vlane_mask)
);


// connect remaining signals from vctrls to vmem_in 
assign vmem_in.vindexed = vctrls.vindexed;
assign vmem_in.vuop_num = vctrls.vuop_num; 
assign vmem_in.vmemdren = vctrls.vmemdren;
assign vmem_in.vmemdwen = vctrls.vmemdwen;
assign vmem_in.vregwen = vctrls.vregwen; 
assign vmem_in.sregwen = vctrls.sregwen;
assign vmem_in.veew = vctrls.veew_dest; 
assign vmem_in.vd_sel = vctrls.vd_sel; 
assign vmem_in.vbank_offset = vctrls.vbank_offset; 
assign vmem_in.vsetvl = (vctrls.vsetvl_type == NOT_CFG) ? 1'b0 : 1'b1; 
assign vmem_in.vkeepvl = vctrls.vkeepvl;

endmodule 