`timescale 1ps/1ps
`include "HalfAdder.v"

module HalfAdder_tb ();
    reg a;
    reg b;
    wire out;
    wire cout;

    HalfAdder dut(.a(a), .b(b), .out(out), .cout(cout));
    initial begin
        $dumpfile("HalfAdder_wave.vcd");
        $dumpvars(0, HalfAdder_tb);

        $monitor("time=%0dt | a=%b, b=%b | cout=%b, out=%b", $time, a, b, cout, out);
        a=0; b=0; #1;
        a=0; b=1; #1;
        a=1; b=0; #1;
        a=1; b=1; #1;
        $finish;
    end
endmodule