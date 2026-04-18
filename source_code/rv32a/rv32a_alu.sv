
module rv32a_alu(
    input logic [31:0] portA, portB,
    input logic [3:0] alu_op, //need to change to type
    output logic [31:0] output_port
); 

always_comb begin

    casez(alu_op)
       
        ALU_ADD: output_port = portA + portB; //ADD    rd, rs1, rs2      R[rd] <= R[rs1] + R[rs2]
        
        ALU_SWAP: output_port = portB;

        ALU_AND: output_port = portA & portB; //AND    rd, rs1, rs2      R[rd] <= R[rs1] AND R[rs2]

        ALU_OR: output_port = portA | portB; //OR     rd, rs1, rs2      R[rd] <= R[rs1] OR R[rs2]

        ALU_XOR: output_port = portA ^ portB; //XOR    rd, rs1, rs2      R[rd] <= R[rs1] XOR R[rs2]

        ALU_MAX:    output_port = ($signed(portA) > $signed(portB)) ? portA : portB;
        ALU_MAXU:   output_port = (portA > portB) ? portA : portB;
        ALU_MIN:    output_port = ($signed(portA) < $signed(portB)) ? portA : portB;
        ALU_MINU:   output_port = (portA < portB) ? portA : portB;

        default: output_port = '0;

    endcase

end

endmodule


