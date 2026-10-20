`include "Mux.v"

module Mux16 (
    input wire [15:0] a,
    input wire [15:0] b,
    input wire sel,
    output wire [15:0] out
);
    

    genvar i;
    generate
        for (i = 0; i<16; i = i + 1 ) begin : gen_mux
            Mux Mux0(.a(a[i]), .b(b[i]), .out(out[i]), .sel(sel));
        end
    endgenerate


endmodule