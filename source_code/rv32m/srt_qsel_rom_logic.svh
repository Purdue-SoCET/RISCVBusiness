// preferred qsel implementation
function automatic logic signed [QDIG_W-1:0] srt_qsel_lookup(
    input logic [QSEL_ADDR_W-1:0] addr
);
    int idx;

    for (idx = 0; idx < SRT_MAX_DIGIT; idx++) begin
        if (addr[QSEL_ADDR_W-1-idx]) begin
            return (SRT_MAX_DIGIT - idx);
        end
    end

    if (addr[SRT_MAX_DIGIT-1]) begin
        return '0;
    end

    for (idx = 1; idx < SRT_MAX_DIGIT; idx++) begin
        if (addr[SRT_MAX_DIGIT-1-idx]) begin
            return -idx;
        end
    end

    return -SRT_MAX_DIGIT;
endfunction
