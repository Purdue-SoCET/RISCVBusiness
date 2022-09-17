
module apb (
    input CLK, nRST,
    apb_if.requestor apbif,
    generic_bus_if.generic_bus out_gen_bus_if
);

    typedef enum logic {
        IDLE,
        DATA
    } state_t;

    state_t state, n_state;

    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            state <= IDLE;
        end else begin
            state <= n_state;
        end
    end


    // TODO: How does APB work with the memory controller?
    always_comb begin
        if(state == DATA && !apbif.PREADY) begin
            n_state = state;
        end else if(out_gen_bus_if.ren || out_gen_bus_if.ren) begin
            n_state = DATA;
        end else begin
            n_state = IDLE;
        end
    end

endmodule
