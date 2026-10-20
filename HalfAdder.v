module HalfAdder (
    input wire a,
    input wire b,
    output wire out,
    output wire cout
);
    assign out = a ^ b;
    assign cout = a & b;

endmodule