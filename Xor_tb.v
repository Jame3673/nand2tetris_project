`timescale 1ns/1ns
`include "Xor.v"

module Xor_tb ();
reg a;
reg b;
wire out;

Xor iXor(.a(a),
    .b(b),
    .out(out)
    );
initial begin
    $dumpfile("Xor_wave.vcd");
    $dumpvars(0, Xor_tb);

    $monitor("TIME=%0dt | a=%b, b=%b, out=%b", $time, a, b, out);
    a=0; b=0; #1;
    a=0; b=1; #1;
    a=1; b=0; #1;
    a=1; b=1; #1;
    $finish;
end
    
endmodule