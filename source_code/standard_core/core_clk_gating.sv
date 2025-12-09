module core_clk_gating #(
)(
  input  logic clk,
  input  logic rst_n,

  input  logic wfi_in,
  input  logic irq_soft,

  output logic core_clk_en
);

  typedef enum logic [1:0] {RUN, REQ_SLEEP, SLEEP} state_t;
  state_t state, next_state;

  // State register
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      state <= RUN;
    else
      state <= next_state;
  end

  // Next-state + output logic
  always_comb begin
    next_state  = state;
    core_clk_en = 1'b1;

    unique case (state)
      RUN: begin
        if (wfi_in && !irq_soft) begin
          next_state = REQ_SLEEP;
        end
      end

      REQ_SLEEP: begin
        core_clk_en = 1'b0;
        next_state  = SLEEP;
      end

      SLEEP: begin
        core_clk_en = 1'b0;
        if (irq_soft || !rst_n) begin
          core_clk_en = 1'b1;
          next_state  = RUN;
        end
      end
    endcase
  end

endmodule
