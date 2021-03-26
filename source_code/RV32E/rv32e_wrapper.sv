`include "component_selection_defines.vh"
`include "rv32i_reg_file_if.vh"
module rv32e_wrapper (
    input logic CLK, nRST, 
    rv32i_reg_file_if rf_if
);
    generate
        case (BASE_ISA)
            "RV32I": rv32i_reg_file rf (.CLK(CLK), .nRST(nRST), .rf_if(rf_if));
            "RV32E": rv32e_reg_file rf (.CLK(CLK), .nRST(nRST), .rf_if(rf_if));
            default: rv32i_reg_file rf (.CLK(CLK), .nRST(nRST), .rf_if(rf_if));
        endcase
    endgenerate
endmodule