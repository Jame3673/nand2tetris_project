`timescale 1ps/1ps
`include "EncoderD2B.v"

module EncoderD2B_tb ();
    reg in0;
    reg in1;
    reg in2;
    reg in3;
    reg in4;
    reg in5;
    reg in6;
    reg in7;
    reg in8;
    reg in9;
    wire a;
    wire b;
    wire c;
    wire d;

    EncoderD2B dut(
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .in5(in5),
        .in6(in6),
        .in7(in7),
        .in8(in8),
        .in9(in9),
        .a(a),
        .b(b),
        .c(c),
        .d(d)
    );
    initial begin
        $dumpfile("wave/EncoderD2B_wave.vcd");
        $dumpvars(0, EncoderD2B_tb);
        $monitor("time %0dt | in0=%b in1=%b in2=%b in3=%b in4=%b in5=%b in6=%b in7=%b in8=%b in9=%b | %b%b%b%b",
            $time, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, a, b, c, d);

        in0=1; in1=0; in2=0; in3=0; in4=0; in5=0; in6=0; in7=0; in8=0; in9=0; #5;
        in0=0; in1=1; in2=0; in3=0; in4=0; in5=0; in6=0; in7=0; in8=0; in9=0; #5;
        in0=0; in1=0; in2=1; in3=0; in4=0; in5=0; in6=0; in7=0; in8=0; in9=0; #5;
        in0=0; in1=0; in2=0; in3=1; in4=0; in5=0; in6=0; in7=0; in8=0; in9=0; #5;
        in0=0; in1=0; in2=0; in3=0; in4=1; in5=0; in6=0; in7=0; in8=0; in9=0; #5;
        in0=0; in1=0; in2=0; in3=0; in4=0; in5=1; in6=0; in7=0; in8=0; in9=0; #5;
        in0=0; in1=0; in2=0; in3=0; in4=0; in5=0; in6=1; in7=0; in8=0; in9=0; #5;
        in0=0; in1=0; in2=0; in3=0; in4=0; in5=0; in6=0; in7=1; in8=0; in9=0; #5;
        in0=0; in1=0; in2=0; in3=0; in4=0; in5=0; in6=0; in7=0; in8=1; in9=0; #5;
        in0=0; in1=0; in2=0; in3=0; in4=0; in5=0; in6=0; in7=0; in8=0; in9=1; #5;
        $finish;
    end
endmodule