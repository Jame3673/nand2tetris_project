`timescale 1ps/1ps
`include "DecoderB2D.v"

module DecoderB2D_tb ();
    wire in0;
    wire in1;
    wire in2;
    wire in3;
    wire in4;
    wire in5;
    wire in6;
    wire in7;
    wire in8;
    wire in9;
    reg a;
    reg b;
    reg c;
    reg d;

    DecoderB2D dut(
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .in5(in5),
        .in6(in6),
        .in7(in7),
        .in8(in8),
        .in9(in9)
        );
    initial begin
        $dumpfile("wave/DecoderB2D_wave.vcd");
        $dumpvars(0, DecoderB2D_tb);
        $monitor("time %0dt | %b%b%b%b | in0=%b in1=%b in2=%b in3=%b in4=%b in5=%b in6=%b in7=%b in8=%b in9=%b",
            $time, a, b, c, d, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9);

        a=1'b0; b=1'b0; c=1'b0; d=1'b0; #5;
        a=1'b0; b=1'b0; c=1'b0; d=1'b1; #5;
        a=1'b0; b=1'b0; c=1'b1; d=1'b0; #5;
        a=1'b0; b=1'b0; c=1'b1; d=1'b1; #5;
        a=1'b0; b=1'b1; c=1'b0; d=1'b0; #5;
        a=1'b0; b=1'b1; c=1'b0; d=1'b1; #5;
        a=1'b0; b=1'b1; c=1'b1; d=1'b0; #5;
        a=1'b0; b=1'b1; c=1'b1; d=1'b1; #5;
        a=1'b1; b=1'b0; c=1'b0; d=1'b0; #5;
        a=1'b1; b=1'b0; c=1'b0; d=1'b1; #5;
        $finish;
    end
endmodule