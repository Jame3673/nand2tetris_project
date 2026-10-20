`include "Or.v"

module Or16way (
    input wire [15:0] a,
    output wire out
);

wire [16:0] t;
assign t[0] = 1'b0;

genvar i;
generate
    for ( i=0 ; i<16 ; i=i+1 ) begin : scan_bits
        Or iOr(.a(a[i]), .b(t[i]), .out(t[i+1]));
    end
endgenerate

assign out = t[16];

endmodule