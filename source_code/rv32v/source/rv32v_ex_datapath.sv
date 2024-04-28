import rv32v_types_pkg::*; 
import rv32i_types_pkg::*; 

module rv32v_ex_datapath(
    input logic CLK, nRST, 
    input word_t rdat1, rdat2,
    input vcontrol_t vctrls, 
    input vwb_t vwb_ctrls,
    input logic[3:0] vmskset_fwd_bits,
    input logic ex_mem_stall, ex_mem_flush, 
    input logic queue_flush, mask_stall, 
    input word_t vl, vlmax,

    output vexmem_t vmem_in,
    output logic vex_stall
);

parameter NUM_LANES = 4; 

logic[127:0] v0;
logic[127:0] vd; // vd selector is the one in execute and not the one writing back in mem
word_t [3:0] vfu_res; 
word_t vred_res;
word_t vres_0;
word_t [3:0] vscratch_write_data;
word_t[3:0] bankdat_src1, xbardat_src1;
word_t[3:0] bankdat_src2, xbardat_src2;
word_t[3:0] bankdat_src3, xbardat_src3;  
word_t[3:0] vopA, vopB, vopC;
word_t ext_imm; 
logic[3:0] mask_bits;
logic[3:0] msku_lane_mask; 
logic[3:0] vfu_stall;
logic[4:0] vs2_sel;
logic[1:0] vs2_bank_offset;
logic output_stall;

// permutation unit related
vperm_input_t vperm_in;
vperm_output_t vperm_out;
logic vrgtr_busy, vrgtr_vs2_read;
vrgather_vs2_t vrgtr_vs2_sel;
logic [1:0] vrgtr_elem_num;

//mask set layer outputs
logic is_vmskset_op; 
logic[7:0] vmskset_res; 
logic[3:0] vmskset_lane_mask;

// scratch reg
word_t[3:0] vscratchdata;

assign output_stall = ex_mem_stall || ex_mem_flush;

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
always_comb begin
    vmem_in.vs1 = xbardat_src1; 

    if(vctrls.vseg_op) begin
        vmem_in.vs1 = {4{xbardat_src1[vctrls.vlaneactive[1:0]]}}; 
    end 
end

// vres muxing when using cross-lane vfu
assign vres_0 = (vctrls.vexec.vfu == VFU_RED) ? vred_res : vfu_res[0];

logic is_mask_calc_instr; 
assign is_mask_calc_instr = (vctrls.vexec.vfu == VFU_MSK) && (
                            vctrls.vexec.vmaskop == VMSK_CNT ||
                            vctrls.vexec.vmaskop == VMSK_FST || 
                            vctrls.vexec.vmaskop == VMSK_SBF || 
                            vctrls.vexec.vmaskop == VMSK_SIF || 
                            vctrls.vexec.vmaskop == VMSK_SOF || 
                            vctrls.vexec.vmaskop == VMSK_ITA || 
                            vctrls.vexec.vmaskop == VMSK_IDX ); 

// vres muxing due to vmskset instructions 
always_comb begin
    vmem_in.vres[0] = vres_0; 
    vmem_in.vres[1] = vfu_res[1]; 
    vmem_in.vres[2] = vfu_res[2]; 
    vmem_in.vres[3] = vfu_res[3];

    if(is_vmskset_op) begin
        vmem_in.vres[0] = {4{vmskset_res}};
        vmem_in.vres[1] = {4{vmskset_res}};
        vmem_in.vres[2] = {4{vmskset_res}};
        vmem_in.vres[3] = {4{vmskset_res}};
    end
    else if(is_mask_calc_instr) begin
        vmem_in.vres[0] = mask_calc_out[31:0]; 
        vmem_in.vres[1] = mask_calc_out[63:32]; 
        vmem_in.vres[2] = mask_calc_out[95:64]; 
        vmem_in.vres[3] = mask_calc_out[127:96]; 
    end
    else if (vctrls.vexec.vfu == VFU_PRM) begin
        vmem_in.vres[0] = vperm_out.velems_out[0]; 
        vmem_in.vres[1] = vperm_out.velems_out[1]; 
        vmem_in.vres[2] = vperm_out.velems_out[2]; 
        vmem_in.vres[3] = vperm_out.velems_out[3];
    end

end

// lane_mask muxing due to vmskset instructions
always_comb begin
    vmem_in.vlane_mask = msku_lane_mask; 
    if(is_vmskset_op)
        vmem_in.vlane_mask = vmskset_lane_mask; 
    else if(is_mask_calc_instr) begin
        case(vctrls.vexec.vmaskop)
            VMSK_SBF, VMSK_SIF, VMSK_SOF: vmem_in.vlane_mask = '1; 
        endcase
    end else if (vctrls.vexec.vfu == VFU_PRM) begin
        vmem_in.vlane_mask = vperm_out.vperm_mask;
    end


end 
// assign vmem_in.vlane_mask = is_vmskset_op ?  : msku_lane_mask; 
// mux data to write to scratch register
assign vscratch_write_data = ((vctrls.vexec.vfu == VFU_PRM) & vperm_out.vs2_to_scratch) ? xbardat_src2 : vmem_in.vres;

assign vd = {bankdat_src3[3], bankdat_src3[2], bankdat_src3[1], bankdat_src3[0]};

assign vrgtr_vs2_sel = vrgather_vs2_t'(vscratchdata[vrgtr_elem_num][9:0]);
assign vs2_sel = (vrgtr_vs2_read) ? vrgtr_vs2_sel.vs2_sel : vctrls.vs2_sel;
assign vs2_bank_offset = (vrgtr_vs2_read) ? vrgtr_vs2_sel.vbank_offset : vctrls.vbank_offset;

// Banks 
rv32v_vector_bank VBANK0 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vs2_sel), .vs3(vctrls.vd_sel),
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[0]), .byte_wen(vwb_ctrls.vbyte_wen[0]), 
    .vdat1(bankdat_src1[0]), .vdat2(bankdat_src2[0]), .vdat3(bankdat_src3[0]),
    .v0(v0[31:0])
); 

rv32v_vector_bank VBANK1 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vs2_sel), .vs3(vctrls.vd_sel),
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[1]), .byte_wen(vwb_ctrls.vbyte_wen[1]), 
    .vdat1(bankdat_src1[1]), .vdat2(bankdat_src2[1]), .vdat3(bankdat_src3[1]),
    .v0(v0[63:32])
);

rv32v_vector_bank VBANK2 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vs2_sel), .vs3(vctrls.vd_sel),
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[2]), .byte_wen(vwb_ctrls.vbyte_wen[2]), 
    .vdat1(bankdat_src1[2]), .vdat2(bankdat_src2[2]), .vdat3(bankdat_src3[2]),
    .v0(v0[95:64])
);

rv32v_vector_bank VBANK3 (
    .CLK(CLK), .nRST(nRST), 
    .vs1(vctrls.vs1_sel), .vs2(vs2_sel), .vs3(vctrls.vd_sel),
    .vw(vwb_ctrls.vd), .vwdata(vwb_ctrls.vwdata[3]), .byte_wen(vwb_ctrls.vbyte_wen[3]), 
    .vdat1(bankdat_src1[3]), .vdat2(bankdat_src2[3]), .vdat3(bankdat_src3[3]),
    .v0(v0[127:96])
);


// read xbars 
rv32v_read_xbar VSRC1_XBAR(
    .bank_dat(bankdat_src1), 
    .veew(vctrls.veew_src1),
    .bank_offset(vctrls.vbank_offset),
    .sign_ext(vctrls.vsignext),
    .out_dat({xbardat_src1[3], xbardat_src1[2], xbardat_src1[1], xbardat_src1[0]})
); 

rv32v_read_xbar VSRC2_XBAR(
    .bank_dat(bankdat_src2), 
    .veew(vctrls.veew_src2),
    .bank_offset(vs2_bank_offset),
    .sign_ext(vctrls.vsignext),
    .out_dat(xbardat_src2)
);

rv32v_read_xbar VSRC3_XBAR(
    .bank_dat(bankdat_src3),
    .veew(vctrls.veew_src2),
    .bank_offset(vctrls.vbank_offset),
    .sign_ext(vctrls.vsignext),
    .out_dat(xbardat_src3)
);

// mask padding generator
word_t vpad_word;

always_comb begin
    vpad_word = '0;

    case (vctrls.vexec.valuop)
        VALU_ADD: begin
            vpad_word = '0;
        end

        VALU_MAX: begin
            // Masked off lanes use minimum possible value
            if (vctrls.vexec.vopunsigned) begin
                vpad_word = '0;
            end else begin
                vpad_word = '1;
            end
        end

        VALU_MIN: begin
            // Masked off lanes use maximum possible value
            if (vctrls.vexec.vopunsigned) begin
                vpad_word = '1;
            end else begin
                vpad_word = '0;
            end
        end

        VALU_AND: begin
            vpad_word = '1;
        end

        VALU_OR: begin
            vpad_word = '0;
        end

        VALU_XOR: begin
            vpad_word = '0;
        end
    endcase
end

rv32v_scratch_reg VSCRATCH (
    .CLK(CLK), .nRST(nRST), 
    .vpad_inactive(vctrls.vpadscratch), .vpad_word(vpad_word),
    .vbyte_wen({4{!(output_stall & ~vrgtr_busy) && (vctrls.vd_sel.regclass == RC_SCRATCH)}} & msku_lane_mask & vperm_out.nkeep_scratch),
    .vwdata({vscratch_write_data[3], vscratch_write_data[2], vscratch_write_data[1], vscratch_write_data[0]}),
    .vrdata({vscratchdata[3], vscratchdata[2], vscratchdata[1], vscratchdata[0]})
);

// vector functional units 
word_t temp_res; 
logic[4:0] vseg_idx_offset; 
always_comb begin
    vopB = xbardat_src1; 
    vopA = xbardat_src2; 
    vopC = xbardat_src3;
    temp_res = '0; 

    // Override with scratch register if required
    if(vctrls.vs1_sel.regclass == RC_SCRATCH) begin
        vopB = vscratchdata;
    end
    if(vctrls.vs2_sel.regclass == RC_SCRATCH) begin
        vopA = vscratchdata;
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


    // override in case of segment load/store instructions indexed instructions. 
    vseg_idx_offset = vctrls.nf_counter; 
    vseg_idx_offset = vseg_idx_offset << vctrls.veew_dest; 
    if(vctrls.vseg_op) begin
        vopA = {4{xbardat_src2[vctrls.vlaneactive[1:0]]}}; 
        vopA[0] = vopA[0] + vseg_idx_offset; 
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
            .vopC(vopC[k]),
            .mask_bit(mask_bits[k]),
            .vsew(vctrls.veew_src2),
            .vop(vctrls.vexec), 
            .vres(vfu_res[k]),
            .vfu_stall(vfu_stall[k])
        );
    end
endgenerate

assign vex_stall = (|vfu_stall) | mask_calc_busy | vrgtr_busy;

// reduction unit
rv32v_reduction_unit VREDUNIT (
    .valuop(vctrls.vexec.valuop),
    .vopunsigned(vctrls.vexec.vopunsigned),
    .vdat_in(vopA),
    .vmask_in(msku_lane_mask),
    .vdat_out(vred_res)
);

// Permutation unit
rv32v_permutation_unit RV32V_PERM (
    .CLK,
    .nRST,
    .vperm_in,
    .stall(ex_mem_stall),  // Optimization: only stall on load-use (current load could be independent)
    .flush(queue_flush),
    .vperm_out,
    .vrgtr_elem_num,
    .vrgtr_vs2_read,
    .vrgtr_busy
);

assign vperm_in = '{
    vpermop: vctrls.vexec.vpermop,
    offset: (vctrls.vxin1_use_imm) ? ext_imm : rdat1,
    vs1_data: xbardat_src1,
    vs2_data: xbardat_src2,
    vscratchdata: vscratchdata,
    rs1_data: rdat1,
    vsew: vctrls.veew_dest,
    vl: vl,
    vlmax: vlmax,
    vuop_num: vctrls.vuop_num,
    vuop_last: vctrls.vuop_last,
    vlaneactive: vctrls.vlaneactive,
    vd_sel: vctrls.vd_sel.regidx,
    vs2_sel: vctrls.vs2_sel,
    use_rs1_data: (vctrls.vxin1_use_imm | vctrls.vxin1_use_rs1),
    v0_mask: mask_bits
};

// Maskings

// NOTE: need to handle in decode whether masking is enable by looking at bit 25 (1 is no, 0 is yes)
rv32v_mask_unit RVV_MASKS(
    .v0(v0), 
    .mask_enable(vctrls.vmask_en), 
    .uop_num(vctrls.vuop_num), 
    .lane_active(vctrls.vlaneactive),
    .lane_mask(msku_lane_mask),
    .mask_bits(mask_bits), 
    .is_seg_op(vctrls.vseg_op)
);


//mask set layer for instructions that set mask bits 
logic[1:0] vmskset_bank_off; 
rv32v_mask_set_layer VMSKSET_LAYER(
    .vfu_results({vfu_res[3][0], vfu_res[2][0], vfu_res[1][0], vfu_res[0][0]}), 
    .vd(vd),
    .vd_fwd_bits(vmskset_fwd_bits), 
    .msku_lane_mask(msku_lane_mask), 
    .vuopnum(vctrls.vuop_num), 

    .vmskset_res(vmskset_res),
    .vmskset_lane_mask(vmskset_lane_mask), 
    .bank_offset(vmskset_bank_offset)
); 


logic[127:0] vmask_calc_mask_src; 
logic[127:0] vmask_calc_mask_dest; 
assign vmask_calc_mask_src = {bankdat_src2[3], bankdat_src2[2], bankdat_src2[1], bankdat_src2[0]};
assign vmask_calc_mask_dest = {bankdat_src3[3], bankdat_src3[2], bankdat_src3[1], bankdat_src3[0]}; 

logic mask_calc_busy; 
logic[127:0] mask_calc_out; 
rv32v_mask_calc VMSK_CALC_UNIT(
    .CLK(CLK), .nRST(nRST), 
    .mask_src(vmask_calc_mask_src), .mask_dest(vmask_calc_mask_dest), .v0_mask(v0), 
    .vl(vl), .flush(queue_flush), .stall(mask_stall), .mask_en(vctrls.vmask_en), .final_instr(vctrls.vuop_last), 
    .vexec(vctrls.vexec), .uop_num(vctrls.vuop_num), 

    .busy(mask_calc_busy), .mask_calc_out(mask_calc_out) 
); 


// connect remaining signals from vctrls to vmem_in
assign vmem_in.vvalid = vctrls.vvalid;
assign vmem_in.vuop_last = vctrls.vuop_last;
assign vmem_in.vindexed = vctrls.vindexed;
assign vmem_in.vuop_num = vctrls.vuop_num; 
assign vmem_in.vmemdren = vctrls.vmemdren;
assign vmem_in.vmemdwen = vctrls.vmemdwen;
assign vmem_in.vregwen = vctrls.vregwen; 
assign vmem_in.sregwen = vctrls.sregwen;
assign vmem_in.veew = vctrls.veew_dest;
assign vmem_in.vmv_s_x = vctrls.vmv_s_x;
// Permutation instructions write to scratch register in EX & back to vector RF in MEM/WB
assign vmem_in.vd_sel = (vctrls.vexec.vfu == VFU_PRM) ? '{regclass: RC_VECTOR, regidx: vctrls.vd_sel.regidx} : vctrls.vd_sel;
//assign vmem_in.vbank_offset = vctrls.vbank_offset; 
assign vmem_in.vbank_offset = is_vmskset_op ? vmskset_bank_offset :
                              (vctrls.vexec.vfu == VFU_PRM) ? vperm_out.vbank_offset : vctrls.vbank_offset;
assign vmem_in.vsetvl = (vctrls.vsetvl_type == NOT_CFG) ? 1'b0 : 1'b1;
assign vmem_in.vkeepvl = vctrls.vkeepvl;
assign vmem_in.keep_vstart = vctrls.keep_vstart;

// seg signals 
assign vmem_in.vstrided = vctrls.vstrided; 
assign vmem_in.vunitstride = vctrls.vunitstride; 
assign vmem_in.vseg_op = vctrls.vseg_op; 
assign vmem_in.vnew_seg = vctrls.vnew_seg; 

endmodule 