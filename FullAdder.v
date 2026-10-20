module FullAdder (
    input wire a,
    input wire b,
    input wire cin,
    output wire out,
    output wire cout
);
    assign out = (a ^ b) ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule