
module rv32a_alu(
    input logic [31:0] portA, portB,
    input logic [4:0] alu_op, //need to change to type
    output logic [31:0] output_port
); 

typedef enum logic [4:0] {
    AMO_ADD  = 5'b00000,
    AMO_SWAP = 5'b00001,
    AMO_LR   = 5'b00010,
    AMO_SC   = 5'b00011,
    AMO_XOR  = 5'b00100,
    AMO_OR   = 5'b01000,
    AMO_AND  = 5'b01100,
    AMO_MIN  = 5'b10000,
    AMO_MAX  = 5'b10100,
    AMO_MINU = 5'b11000,
    AMO_MAXU = 5'b11100
} rv32a_op_e;

rv32a_op_e op;
assign op = rv32a_op_e'(alu_op);

always_comb begin

    casez(op)
       
        AMO_ADD: output_port = portA + portB; //ADD    rd, rs1, rs2      R[rd] <= R[rs1] + R[rs2]
        
        AMO_SWAP: output_port = portB;

        AMO_AND: output_port = portA & portB; //AND    rd, rs1, rs2      R[rd] <= R[rs1] AND R[rs2]

        AMO_OR: output_port = portA | portB; //OR     rd, rs1, rs2      R[rd] <= R[rs1] OR R[rs2]

        AMO_XOR: output_port = portA ^ portB; //XOR    rd, rs1, rs2      R[rd] <= R[rs1] XOR R[rs2]

        AMO_MAX:    output_port = ($signed(portA) > $signed(portB)) ? portA : portB;
        AMO_MAXU:   output_port = (portA > portB) ? portA : portB;
        AMO_MIN:    output_port = ($signed(portA) < $signed(portB)) ? portA : portB;
        AMO_MINU:   output_port = (portA < portB) ? portA : portB;

        default: output_port = '0;

    endcase

end

endmodule


