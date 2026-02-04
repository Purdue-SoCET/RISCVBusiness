module rv32b_alu(
    input [31:0] a,
    input [31:0] b,
    input rv32b_pkg::rv32b_op_t aluop,
    output logic [31:0] y
);

    import rv32b_pkg::*;
    logic [5:0] acc;

    always_comb begin
        acc = 0;
        casez(aluop)
            SH1ADD: y = (a << 1) + b;
            SH2ADD: y = (a << 2) + b;
            SH3ADD: y = (a << 3) + b;
            ANDN:   y = a & ~b;
            ORN:    y = a | ~b;
            XNOR:   y = ~(a ^ b);
            MAX:    y = ($signed(a) < $signed(b)) ? b : a;
            MAXU:   y = (a < b) ? b : a;
            MIN:    y = ($signed(a) < $signed(b)) ? a : b;
            MINU:   y = (a < b) ? a : b;
            SEXTB:  y = {{24{a[7]}}, a[7:0]};
            SEXTH:  y = {{16{a[15]}}, a[15:0]};
            ZEXTH:  y = {{16{1'b0}}, a[15:0]};
            ROL:    y = (a << b[4:0]) | (a >> ($bits(a) - b[4:0]));
            ROR:    y = (a >> b[4:0]) | (a << ($bits(a) - b[4:0]));
            ORC:    y = {{8{|a[31:24]}}, {8{|a[23:16]}}, {8{|a[15:8]}}, {8{|a[7:0]}}};
            REV8:   y = {a[7:0], a[15:8], a[23:16], a[31:24]};
            BCLR:   y = a & ~(32'b1 << b[4:0]);
            BEXT:   y = {{31{1'b0}}, a[b[4:0]]};
            BINV:   y = a ^ (32'b1 << b[4:0]);
            BSET:   y = a | (32'b1 << b[4:0]);
            CLZ: begin
                acc = 0;
                for(int i = 31; i >= 0; i--) begin
                    if(a[i] == 1) begin
                        break;
                    end else begin
                        acc += 1;
                    end
                end
                y = acc;
            end

            CTZ: begin
                acc = 0;
                for(int i = 0; i < 32; i++) begin
                    if(a[i] == 1) begin
                        break;
                    end else begin
                        acc += 1;
                    end
                end
                y = acc;
            end

            CPOP: begin
                acc = 0;
                for(int i = 0; i < 32; i++) begin
                    if(a[i]) begin
                        acc += 1;
                    end
                end
                y = acc;
            end
            default: y = 0;
        endcase
    end

endmodule
