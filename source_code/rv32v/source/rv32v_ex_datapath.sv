import rv32v_types_pkg::*; 
import rv32i_types_pkg::*; 

module rv32v_ex_datapath(
    input logic CLK, nRST, 
    input word_t rdat1, rdat2,
    input vcontrol_t vctrls, 
    input vwb_t vwb_ctrls,
    input logic[3:0] vmskset_fwd_bits,

    output vexmem_t vmem_in,
    output logic vex_stall
);

parameter NUM_LANES = 4; 

logic[127:0] v0;
logic[127:0] vd; // vd selector is the one in execute and not the one writing back in mem
word_t[3:0] bankdat_src1, xbardat_src1;
word_t[3:0] bankdat_src2, xbardat_src2 ;  
word_t[3:0] vopA, vopB; 
word_t [3:0] vfu_res; 
word_t vred_res;
word_t vres_0;
word_t ext_imm; 
logic[3:0] mask_bits;
logic[3:0] msku_lane_mask; 
logic[3:0] vfu_stall;

//mask set layer outputs
logic is_vmskset_op; 
logic[7:0] vmskset_res; 
logic[3:0] vmskset_lane_mask; 


logic vint_cmp_instr; 

assign vint_cmp_instr = vctrls.vexec.valuop == VALU_SEQ || // MOVE THIS TO DECODE
                        vctrls.vexec.valuop == VALU_SNE || 
                        vctrls.vexec.valuop == VALU_SLT ||
                        vctrls.vexec.valuop == VALU_SLE ||
                        vctrls.vexec.valuop == VALU_SGT; 

assign is_vmskset_op = vctrls.vexec.valuop == VALU_SEQ || // MOVE THIS TO DECODE
                       vctrls.vexec.valuop == VALU_SNE ||
                       vctrls.vexec.valuop == VALU_SLT ||
                       vctrls.vexec.valuop == VALU_SLE ||
                       vctrls.vexec.valuop == VALU_SGT ||
                       vctrls.vexec.valuop == VALU_VMADC_NO_C ||
                       vctrls.vexec.valuop == VALU_VMADC ||
                       vctrls.vexec.valuop == VALU_VMSBC_NO_B ||
                       vctrls.vexec.valuop == VALU_VMSBC;                 
// assign is_vmskset_op = 0;         

assign ext_imm = (vctrls.vsignext || vint_cmp_instr)  ? {{27{vctrls.vimm[4]}}, vctrls.vimm} : {27'b0, vctrls.vimm};

// store data  
assign vmem_in.vs1 = xbardat_src1; 

// vres muxing due to vmskset instructions 
assign vmem_in.vres[0] = is_vmskset_op ? {26'b0, vmskset_res} : vres_0;
assign vmem_in.vres[1] = is_vmskset_op ? {26'b0, vmskset_res} : vfu_res[1];
assign vmem_in.vres[2] = is_vmskset_op ? {26'b0, vmskset_res} : vfu_res[2];
assign vmem_in.vres[3] = is_vmskset_op ? {26'b0, vmskset_res} : vfu_res[3];

// lane_mask muxsing due to vmskset instructions
assign vmem_in.vlane_mask = is_vmskset_op ? vmskset_lane_mask : msku_lane_mask; 



// Banks 
rv32v_vector_bank VBANK0 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vctrls.vs2_sel), 
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[0]), .byte_wen(vwb_ctrls.vbyte_wen[0]), 
    .vdat1(bankdat_src1[0]), .vdat2(bankdat_src2[0]), 
    .v0(v0[31:0]),
    .vdat3(vd[31:0])
); 

rv32v_vector_bank VBANK1 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vctrls.vs2_sel), 
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[1]), .byte_wen(vwb_ctrls.vbyte_wen[1]), 
    .vdat1(bankdat_src1[1]), .vdat2(bankdat_src2[1]), 
    .v0(v0[63:32]),
    .vdat3(vd[63:32])
);

rv32v_vector_bank VBANK2 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vctrls.vs2_sel), 
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[2]), .byte_wen(vwb_ctrls.vbyte_wen[2]), 
    .vdat1(bankdat_src1[2]), .vdat2(bankdat_src2[2]), 
    .v0(v0[95:64]),
    .vdat3(vd[95:64])
);

rv32v_vector_bank VBANK3 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vctrls.vs2_sel), 
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[3]), .byte_wen(vwb_ctrls.vbyte_wen[3]), 
    .vdat1(bankdat_src1[3]), .vdat2(bankdat_src2[3]), 
    .v0(v0[127:96]),
    .vdat3(vd[127:96])
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

// scratch reg
word_t[3:0] vscratchdata;

rv32v_scratch_reg VSCRATCH (
    .CLK(CLK), .nRST(nRST), 
    .wen((vctrls.vd_sel.regclass == RC_SCRATCH) && vctrls.vregwen),
    .vwdata({vfu_res[3], vfu_res[2], vfu_res[1], vfu_res[0]}),
    .vrdata({vscratchdata})
);

// vector functional units 
word_t temp_res; 
always_comb begin
    vopB = xbardat_src1; 
    vopA = xbardat_src2; 
    temp_res = '0; 

    // Override with scratch register if required
    if(vctrls.vs1_sel.regclass == RC_SCRATCH) begin
        vopB = vscratchdata;
    end
    if(vctrls.vs2_sel.regclass == RC_SCRATCH) begin
        vopB = vscratchdata;
    end

    if(vctrls.vxin1_use_imm) begin
        vopB = {4{ext_imm}};
    end
    else if(vctrls.vxin1_use_rs1) begin
        if(vctrls.veew_src1 < SEW32 && ~(vctrls.vmemdren || vctrls.vmemdwen)) begin
            case(vctrls.veew_src1)
                SEW8: begin
                    temp_res = vctrls.vsignext ? {{24{rdat1[7]}}, rdat1[7:0]} : {24'b0, rdat1[7:0]}; 
                    vopB = {4{temp_res}}; 
                end
                SEW16: begin
                    temp_res = vctrls.vsignext ? {{16{rdat1[15]}}, rdat1[15:0]} : {16'b0, rdat1[15:0]}; 
                    vopB = {4{temp_res}}; 
                end 
                default: begin
                    vopB = {4{rdat1}}; 
                end
            endcase  
        end 
        else begin
            vopB = {4{rdat1}}; 
        end
        
    end
    
    if(vctrls.vxin2_use_rs2) begin
        vopA = {4{rdat2}}; 
    end
end

genvar k; 
generate 
    for(k = 0; k < NUM_LANES; k+=1) begin
        rv32v_vfu VFU(
            .CLK,
            .nRST,
            .vopA(vopA[k]), 
            .vopB(vopB[k]),
            .mask_bit(mask_bits[k]),
            .vsew(vctrls.veew_src2),
            .vop(vctrls.vexec), 
            .vres(vfu_res[k]),
            .vfu_stall(vfu_stall[k])
        );
    end
endgenerate

assign vex_stall = |vfu_stall;

// reduction unit
rv32v_reduction_unit VREDUNIT (
    .valuop(vctrls.vexec.valuop),
    .vopunsigned(vctrls.vexec.vopunsigned),
    .vdat_in(vopB),
    .vdat_out(vred_res)
);

assign vres_0 = (vctrls.vexec.vfu == VFU_RED) ? vred_res : vfu_res[0];

// Maskings

// NOTE: need to handle in decode whether masking is enable by looking at bit 25 (1 is no, 0 is yes)
rv32v_mask_unit RVV_MASKS(
    .v0(v0), 
    .mask_enable(vctrls.vmask_en), 
    .uop_num(vctrls.vuop_num), 
    .lane_active(vctrls.vlaneactive),
    .lane_mask(msku_lane_mask),
    .mask_bits(mask_bits)
);


//mask set layer for instructions that set mask bits 
rv32v_mask_set_layer VMSKSET_LAYER(
    .vfu_results({vfu_res[3][0], vfu_res[2][0], vfu_res[1][0], vfu_res[0][0]}), 
    .vd(vd),
    .vd_fwd_bits(vmskset_fwd_bits), 
    .msku_lane_masks(msku_lane_masks), 
    .vuopnum(vctrls.vuop_num), 

    .vmskset_res(vmskset_res),
    .vmskset_lane_mask(vmskset_lane_mask)
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