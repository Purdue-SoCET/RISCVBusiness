module rv32a_enabled(
    input CLK,
    input nRST,
    input logic amo_en, mem_ready,
    input logic [3:0] alu_op, //need to change to type
    input logic [31:0] mem_output, rs2_data,
    output logic stall_amo_en, read_mem_en, write_mem_en,
    output logic [31:0] mem_input, writeback_data
);

    // State enumeration
    typedef enum logic [1:0] {
        AMO_FSM_IDLE = 2'b00,
        AMO_FSM_READ = 2'b01,
        AMO_FSM_MODIFY = 2'b10,
        AMO_FSM_WRITE = 2'b11
    } amo_fsm_state_t;

    amo_fsm_state_t current_state, next_state;

    // Sequential logic for state register
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n)
            current_state <= AMO_FSM_READ;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state and outputs
    always_comb begin
        next_state = current_state;
        stall_amo_en = 1'b0; // Default to no stall
        read_mem_en = 1'b0;
        write_mem_en = 1'b0;
        // output port signal will need to be routed to caches and dealt with, look below for that

        casez (current_state)
            IDLE: begin
                //control unit signal rolled over through to mem stage rv32a_amo
                next_state = (amo_en) ? AMO_FSM_READ : IDLE;

                stall_amo_en = amo_en;
            end

            AMO_FSM_READ: begin
                //wait for memory response
                next_state = (mem_ready) ? AMO_FSM_MODIFY : AMO_FSM_READ;

                stall_amo_en = 1'b1; //start the ALU and stall pipeline

                // read from cache here
                amoif.read_mem_en = 1'b1;
            end

            AMO_FSM_MODIFY: begin
                //ALU only needs one cycle to compute
                next_state = AMO_FSM_WRITE;

                stall_amo_en = 1'b1; // keep pipeline stalled
            end

            AMO_FSM_WRITE: begin
                //wait for memory response
                next_state = (mem_ready) ? AMO_FSM_MODIFY : AMO_FSM_READ;

                // keep pipeline stalled
                stall_amo_en = !mem_ready;

                // write back to cache here
                write_mem_en = 1'b1;
            end
        endcase
    end

    amo_alu AMO_ALU (
        .portA(mem_output), 
        .portB(rs2_data),
        .alu_op(alu_op), //need to change to type
        //.negative, 
        //.zero, 
        //.overflow,
        .output_port(mem_input)
    );

    logic [31:0] amo_reg;

    assign writeback_data = amo_reg;

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            amo_reg <= '0;
        end
        else if (amo_en & mem_ready) begin
            amo_reg <= mem_output;
        end
        else begin
            amo_reg <= amo_reg;
        end
    end

endmodule
