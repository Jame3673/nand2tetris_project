`include "HalfAdder.v"

module Inc16 (
    input wire [15:0] a,
    output wire cout,
    output wire [15:0] out
);
wire [14:0] c_inter;



genvar i;
generate
    HalfAdder add0 (.a(a[0]), .b(1'b1), .out(out[0]), .cout(c_inter[0]));

    for (i = 1; i < 15 ; i = i + 1 ) begin : gen_adders
        HalfAdder add_mid(.a(a[i]), .b(c_inter[i-1]), .out(out[i]), .cout(c_inter[i]));
    end

    HalfAdder add15 (.a(a[15]), .b(c_inter[14]), .out(out[15]), .cout(cout));
endgenerate
endmodule