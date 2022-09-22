
module apb (
    input CLK, nRST,
    apb_if.requester apbif,
    generic_bus_if.generic_bus out_gen_bus_if
);

    typedef enum logic {
        IDLE,
        DATA
    } state_t;

    typedef struct packed {
        logic [31:0] addr;
        logic [31:0] wdata;
        logic wen; // ren unneeded since only used in data phase, !wen -> ren
        logic [3:0] strobe;
    } request_t;

    state_t state, n_state;
    request_t request, request_n;

    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            state <= IDLE;
            request <= '0;
        end else begin
            state <= n_state;
            request <= request_n;
        end
    end

    always_comb begin
        request_n = request;
        if(state == IDLE || (state == DATA && apbif.PREADY)) begin
            request_n.addr = out_gen_bus_if.addr;
            request_n.wdata = out_gen_bus_if.wdata;
            request_n.wen = out_gen_bus_if.wen;
            request_n.strobe = out_gen_bus_if.byte_en;
        end
    end


    // TODO: How does APB work with the memory controller?
    always_comb begin
        if(state == DATA && !apbif.PREADY) begin
            n_state = state;
        end else if(out_gen_bus_if.ren || out_gen_bus_if.wen) begin
            n_state = DATA;
        end else begin
            n_state = IDLE;
        end
    end

    always_comb begin
        if(state == IDLE) begin
            apbif.PADDR = out_gen_bus_if.addr;
            apbif.PSEL = (out_gen_bus_if.ren || out_gen_bus_if.wen);
            apbif.PPROT = '0;
            apbif.PENABLE = 0;
            apbif.PWRITE = out_gen_bus_if.wen;
            apbif.PSTRB = out_gen_bus_if.byte_en;
        end else begin
            apbif.PADDR = request.addr;
            apbif.PSEL = 1'b1;
            apbif.PPROT = '0;
            apbif.PENABLE = 1'b1;
            apbif.PWRITE = request.wen;
            apbif.PSTRB = request.strobe;
        end
    end

    // Response
    assign out_gen_bus_if.rdata = apbif.PRDATA;
    assign out_gen_bus_if.busy = (state == IDLE) || ~apbif.PREADY;
    assign apbif.PWDATA = out_gen_bus_if.wdata;

endmodule
