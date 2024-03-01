import rv32v_types_pkg::*; 
import rv32i_types_pkg::*; 

module rv32v_vfu(
    input word_t vopA, vopB,
    input logic mask_bit, 
    input vexec_t vop, 
    input vsew_t vsew, 

    output word_t vres
);

logic[32:0] temp_res; 


always_comb begin
    vres = '0; 
    temp_res = '0; 
    if(vop.vfu == VFU_ALU) begin
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
        endcase
    end
end
endmodule 
