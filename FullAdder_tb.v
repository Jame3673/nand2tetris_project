`timescale 1ps/1ps
`include "FullAdder.v"

module FullAdder_tb ();
    reg a;
    reg b;
    reg cin;
    wire out;
    wire cout;

    FullAdder dut(.a(a), .b(b), .cin(cin), .out(out), .cout(cout));
    initial begin
        $dumpfile("wave/FullAdder_wave.vcd");
        $dumpvars(0, FullAdder_tb);

        $monitor("time=%0dt | a=%b, b=%b, cin=%b | cout=%b, out=%b", $time, a, b, cin, cout, out);
        a=0; b=0; cin=0; #1;
        a=0; b=1; cin=0; #1;
        a=1; b=0; cin=0; #1;
        a=1; b=1; cin=0; #1;

        a=0; b=0; cin=1; #1;
        a=0; b=1; cin=1; #1;
        a=1; b=0; cin=1; #1;
        a=1; b=1; cin=1; #1;
        $finish;
    end
endmodule