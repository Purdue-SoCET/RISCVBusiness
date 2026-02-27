`include "amo_fsm_if.vh"
import cpu_types_pkg::*;

module amo_fsm (
    amo_fsm_if.if amoif
);

    // State enumeration
    typedef enum logic [1:0] {
        AMO_FSM_READ   = 2'b00,
        AMO_FSM_MODIFY = 2'b01,
        AMO_FSM_WRITE   = 2'b10
    } amo_fsm_state;

    state_t current_state, next_state;

    // Sequential logic for state register
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= AMO_FSM_READ;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state and outputs
    always_comb begin
        next_state = current_state;
        amoif.stall_amo_en = 1'b0; // Default to no stall
        amoif.amo_alu_op = 5'b0; // just pass through the funct5 on this
        amoif.port_a = 32'b0; // Default values for operands
        amoif.port_b = 32'b0;
        amoif.read_mem_en = 1'b0;
        amoif.write_mem_en = 1'b0;
        amoif.regfile_wb = 32'b0;
        amoif.write_regfile_en = 1'b0;
        amoif.dest_reg = 5'b0; // Default destination register
        amoif.mem_address = 32'b0;
        amoif.mem_data = 32'b0;
        // output port signal will need to be routed to caches and dealt with, look below for that

        casez (current_state)
            AMO_FSM_READ: begin
                if(amoif.amo_en) begin //control unit signal rolled over through to mem stage rv32a_amo 
                    //start the ALU and stall pipeline
                    amoif.stall_amo_en = 1'b1;
                    //make memory request here
                    amoif.read_mem_en = 1'b1;
                    amoif.mem_address = amoif.rs1_data; 
                    //wait for memory response
                    if (amoif.mem_ready) begin 
                        next_state = AMO_FSM_MODIFY;
                    end
                end
            end

            AMO_FSM_MODIFY: begin
                // keep pipeline stalled
                amoif.stall_amo_en = 1'b1;
                //pass to operands to alu here 
                amoif.amo_alu_op = amoif.instr[31:27]; //bits from the instruction that show which amo op it is
                amoif.port_a = amoif.mem_output; //connect this signal to cache output
                amoif.port_b = amoif.rs2_data;
                //ALU only needs one cycle to compute
                next_state = AMO_FSM_WRITE;
            end

            AMO_FSM_WRITE: begin
                // keep pipeline stalled
                amoif.stall_amo_en = 1'b1;
                //keep alu inputs steady 
                amoif.amo_alu_op = amoif.instr[31:27];
                amoif.port_a = amoif.mem_output; //cache output
                amoif.port_b = amoif.rs2;
                // write back to register file here
                amoif.regfile_wb = amoif.port_a;
                amoif.write_regfile_en = 1'b1;
                amoif.dest_reg = amoif.instr[11:7]; //bits from the instruction that show which register to write back to
                // write back to cache here
                amoif.write_mem_en = 1'b1;
                amoif.mem_address = amoif.rs1_data;
                amoif.mem_data = amoif.output_port; //output from the ALU after modification
                end
        endcase
    end

endmodule
