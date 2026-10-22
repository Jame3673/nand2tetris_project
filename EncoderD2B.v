module EncoderD2B (
    input wire in0,
    input wire in1,
    input wire in2,
    input wire in3,
    input wire in4,
    input wire in5,
    input wire in6,
    input wire in7,
    input wire in8,
    input wire in9,
    output wire a,
    output wire b,
    output wire c,
    output wire d
    );
    assign a = in8 | in9;
    assign b = in4 | in5 | in6 | in7 ;
    assign c = in2 | in3 | in6 | in7 ;
    assign d = in1 | in3 | in5 | in7 | in9 ;
endmodule