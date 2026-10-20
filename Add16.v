`include "FullAdder.v"

module Add16 (
    input wire [15:0]a,
    input wire [15:0]b,
    output wire [15:0]out,
    output wire cout
);

wire [14:0] c_inter;



genvar i;
generate
    FullAdder add0 ( .a(a[0]), .b(b[0]), .cin(1'b0), .out(out[0]), .cout(c_inter[0]) );

    for (i = 1; i < 15 ; i = i + 1 ) begin : gen_adders
        FullAdder add_mid(.a(a[i]), .b(b[i]), .cin(c_inter[i-1]), .out(out[i]), .cout(c_inter[i]));
    end

    FullAdder add15 ( .a(a[15]), .b(b[15]), .cin(c_inter[14]), .out(out[15]), .cout(cout) );
endgenerate

   
endmodule