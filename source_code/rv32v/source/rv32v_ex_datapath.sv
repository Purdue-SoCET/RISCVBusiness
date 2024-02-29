import rv32v_types_pkg::*; 
import rv32i_types_pkg::*; 

module rv32v_ex_datapath(
    input logic CLK, nRST, 
    input word_t rdat1, rdat2,
    input vcontrol_t vctrls, 
    input vwb_t vwb_ctrls, 
    output vexmem_t vmem_in
);

parameter NUM_LANES = 4; 

logic[127:0] v0; 
word_t[3:0] bankdat_src1, xbardat_src1;
word_t[3:0] bankdat_src2, xbardat_src2 ;  
word_t[3:0] vopA, vopB; 
word_t ext_imm; 
logic[3:0] mask_bits; 

assign ext_imm = {{27{vctrls.vimm[4]}}, vctrls.vimm};

// store data  
assign vmem_in.vs3 = xbardat_src1; 

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
    .bank_offset(vctrls.vuop_num[1:0]),
    .sign_ext(vctrls.vsignext),
    .out_dat(xbardat_src1)
); 

rv32v_read_xbar VSRC2_XBAR(
    .bank_dat(bankdat_src2), 
    .veew(vctrls.veew_src2),
    .bank_offset(vctrls.vuop_num[1:0]),
    .sign_ext(vctrls.vsignext),
    .out_dat(xbardat_src2)
); 

// vector functional units 
always_comb begin
    vopB = xbardat_src1; 
    vopA = xbardat_src2; 

    if(vctrls.vxin1_use_imm) begin
        vopB = {4{ext_imm}};
    end
    else if(vctrls.vxin1_use_rs1) begin
        vopB = {4{rdat1}}; 
    end
    
    if(vctrls.vxin2_use_rs2) begin
        vopA = {4{rdat2}}; 
    end
end

genvar k; 
generate 
    for(k = 0; k < NUM_LANES; k+=1) begin
        rv32v_vfu VFU(
            .vopA(vopA[k]), 
            .vopB(vopB[k]),
            .mask_bits(mask_bits),
            .vop(vctrls.vexec), 
            .vres(vmem_in.valu_res[k])
        );
    end
endgenerate 


// Maskings

// NOTE: need to handle in decode whether masking is enable by looking at bit 25 (1 is no, 0 is yes)
rv32v_mask_unit RVV_MASKS(
    .v0(v0), 
    .mask_enable(vctrls.vmask_en), 
    .uop_num(vctrls.vuop_num), 
    .lane_active(vctrls.vlaneactive),
    .lane_mask(vmem_in.vlane_mask),
    .mask_bits(mask_bits)
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