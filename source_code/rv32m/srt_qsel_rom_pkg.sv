package srt_qsel_rom_pkg;
    function automatic int signed srt_qsel_lookup(
        input logic [31:0] addr,
        input int unsigned max_digit
    );
        int width;
        int idx;

        width = 2 * max_digit;

        for (idx = 0; idx < max_digit; idx++) begin
            if (addr[width - 1 - idx]) begin
                return max_digit - idx;
            end
        end

        if (addr[max_digit - 1]) begin
            return 0;
        end

        for (idx = 1; idx < max_digit; idx++) begin
            if (addr[max_digit - 1 - idx]) begin
                return -idx;
            end
        end

        return -max_digit;
    endfunction
endpackage