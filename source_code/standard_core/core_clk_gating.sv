`include "control_unit_if.vh"
`include "core_interrupt_if.vh"

module core_clk_gating #(
  parameter int HART_ID = 0
)(
  input  logic                 clk,
  input  logic                 rst_n,

  control_unit_if.core         cuif,    //wfi
  core_interrupt_if.core       irqif,   //interrupt

  output logic                 core_clk_en
);

  typedef enum logic [1:0] {RUN, REQ_SLEEP, SLEEP} state_t;
  state_t state, next_state;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      state <= RUN;
    else
      state <= next_state;
  end

  always_comb begin
    next_state  = state;
    core_clk_en = 1'b1;

    unique case (state)
      RUN: begin
        if (cuif.wfi && !(irqif.soft_int[HART_ID])) begin
          next_state = REQ_SLEEP;
        end
      end

      REQ_SLEEP: begin
        core_clk_en = 1'b0;
        next_state  = SLEEP;
      end

      SLEEP: begin
        core_clk_en = 1'b0;

        if ((irqif.soft_int[HART_ID]) || !rst_n) begin
          core_clk_en = 1'b1;
          next_state  = RUN;
        end
      end
    endcase
  end

endmodule
