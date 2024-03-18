import rv32v_types_pkg::*; 
import rv32i_types_pkg::*; 

module rv32v_vfu(
    input logic CLK,
    input logic nRST,
    input word_t vopA, vopB,
    input logic mask_bit, 
    input vexec_t vop, 
    input vsew_t vsew, 

    output word_t vres,
    output logic vfu_stall
);

logic[32:0] temp_res;
vmul_input_t vmul_in;
vmul_output_t vmul_out;
vdiv_input_t vdiv_in;
vdiv_output_t vdiv_out;

rv32v_multiplier RV32V_MULT (
    .CLK,
    .nRST,
    .vmul_in,
    .vmul_out
);

rv32v_divider RV32V_DIV (
    .CLK,
    .nRST,
    .vdiv_in,
    .vdiv_out
);

// RV32V multiplier signals
assign vmul_in = '{
    vmul_en: (vop.vfu == VFU_MUL) & ~mask_bit,
    vs1_data: vopA,
    vs2_data: vopB,
    vd_data: '0, // TODO
    vsew: vsew,
    vmulop: vop.vmulop,
    sign: vop.vsigntype,
    vmul_widen: 0, // TODO
    vmul_ret_high: 0, // TODO
    stall: 0,  // TODO
    flush: 0 // TODO
};

// RV32V divider signals
assign vdiv_in = '{
    vdiv_en: (vop.vfu == VFU_DIV) & ~mask_bit,
    vs1_data: vopA,
    vs2_data: vopB,
    vsew: vsew,
    vdivremainder: 0, // TODO
    vopunsigned: vop.vopunsigned,
    stall: 0,  // TODO
    flush: 0 // TODO
};

assign vfu_stall = ((vop.vfu == VFU_MUL) & vmul_out.vmul_busy) | ((vop.vfu == VFU_DIV) & vdiv_out.vdiv_busy);

always_comb begin
    vres = '0; 
    temp_res = '0; 
    casez (vop.vfu)
        VFU_PASS_VS1: vres = vopA;
        VFU_PASS_VS2: vres = vopB;
        VFU_ALU:
            case(vop.valuop)
                VALU_ADD: vres = vopA + vopB; 
                VALU_SUB: vres = $signed(vopA) - $signed(vopB);
                VALU_RSB: vres = $signed(vopB) - $signed(vopA);
                VALU_EXT: vres = vopA; // assume vopA is vs2
                VALU_ADC: vres = vopA + vopB + mask_bit;
                VALU_SBC : vres = vopA - vopB - {31'b0, mask_bit}; 
                VALU_VMADC_NO_C: begin
                    temp_res = {1'b0, vopA}  + {1'b0, vopB};
                    vres = {31'b0, temp_res[32]}; // carry bit in temp_res[32]
                end
                VALU_VMADC: begin
                    temp_res = {1'b0, vopA}  + {1'b0, vopB} + {32'b0, mask_bit};
                    vres = {31'b0, temp_res[32]}; // carry bit in temp_res[32]
                end 
                VALU_VMSBC_NO_B: begin
                    temp_res = $signed({vopA[31], vopA}) - $signed({vopB[31], vopB});
                    vres = {31'b0, temp_res[32]}; // borrow bit in temp_res[32]
                end
                VALU_VMSBC: begin
                    temp_res = $signed({vopA[31], vopA}) - $signed({vopB[31], vopB}) - $signed({32'b0, mask_bit});
                    vres = {31'b0, temp_res[32]}; // borrow bit in temp_res[32]
                end
                VALU_AND: vres = vopA & vopB; 
                VALU_OR: vres = vopA | vopB; 
                VALU_XOR: vres = vopA ^ vopB; 
                VALU_SRL: begin
                    // we store in temp_res, the shift amount 
                    case(vsew)
                        SEW8:temp_res = vopB[2:0];
                        SEW16: temp_res = vopB[3:0]; 
                        SEW32: temp_res = vopB[4:0];
                        default: temp_res = '0; 
                    endcase 
                    vres = vopA >> temp_res; 
                end 
                VALU_SRA: begin
                    case(vsew)
                        SEW8:temp_res = vopB[2:0];
                        SEW16: temp_res = vopB[3:0]; 
                        SEW32: temp_res = vopB[4:0];
                        default: temp_res = '0; 
                    endcase 
                    vres = vopA >>> temp_res; 
                end 
                VALU_SLL: begin
                    case(vsew)
                        SEW8:temp_res = vopB[2:0];
                        SEW16: temp_res = vopB[3:0]; 
                        SEW32: temp_res = vopB[4:0];
                        default: temp_res = '0; 
                    endcase 
                    vres = vopA << temp_res; 
                end 
                VALU_SEQ: vres = (vopA == vopB) ? 32'b1 : 32'b0; 
                VALU_SNE: vres = (vopA == vopB) ? 32'b0 : 32'b1; 
                VALU_SLT: begin
                    if(vop.vopunsigned)
                        vres = (vopA < vopB) ? 32'b1 : 32'b0; 
                    else 
                        vres = ($signed(vopA) <= $signed(vopB)) ? 32'b1 : 32'b0; 
                end
                VALU_SLE: begin
                    if(vop.vopunsigned)
                        vres = (vopA < vopB) ? 32'b1 : 32'b0; 
                    else 
                        vres = ($signed(vopA) <= $signed(vopB)) ? 32'b1 : 32'b0; 
                end
                VALU_SGT: begin
                    if(vop.vopunsigned)
                        vres = (vopA < vopB) ? 32'b1 : 32'b0; 
                    else 
                        vres = ($signed(vopA) < $signed(vopB)) ? 32'b1 : 32'b0; 
                end
                VALU_MIN: begin
                    if(vop.vopunsigned)
                        vres = (vopA < vopB) ? vopA : vopB; 
                    else 
                        vres = ($signed(vopA) < $signed(vopB)) ? vopA : vopB; 
                end 
                VALU_MAX: begin
                    if(vop.vopunsigned)
                        vres = (vopA > vopB) ? vopA : vopB; 
                    else 
                        vres = ($signed(vopA) > $signed(vopB)) ? vopA : vopB; 
                end 
                VALU_MERGE: vres = mask_bit ? vopB : vopA; 
                VALU_INT_MOVE: vres = vopB; 


            endcase
        VFU_MUL:
            vres = vmul_out.vd_res;
        VFU_DIV:
            vres = vdiv_out.vd_res;
        VFU_PRM: begin
            case(vop.vpermop)
                VPRM_SMV: vres = vopA; 
            endcase
        end 
    endcase
end
endmodule 
