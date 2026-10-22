module DecoderB2D (
    output wire in0,
    output wire in1,
    output wire in2,
    output wire in3,
    output wire in4,
    output wire in5,
    output wire in6,
    output wire in7,
    output wire in8,
    output wire in9,
    input wire a,
    input wire b,
    input wire c,
    input wire d
);
    assign in0 = ~a & ~b & ~c & ~ d;
    assign in1 = ~a & ~b & ~c &  d;
    assign in2 = ~a & ~b & c & ~ d;
    assign in3 = ~a & ~b & c &  d;
    assign in4 = ~a & b & ~c & ~ d;
    assign in5 = ~a & b & ~c &  d;
    assign in6 = ~a & b & c & ~ d;
    assign in7 = ~a & b & c &  d;
    assign in8 = a & ~b & ~c & ~ d;
    assign in9 = a & ~b & ~c &  d; 
endmodule