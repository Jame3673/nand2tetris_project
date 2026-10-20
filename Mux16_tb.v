`timescale 1ps/1ps
`include "Mux16.v"

module Mux16_tb ();
    reg [15:0] a;
    reg [15:0] b;
    wire [15:0] out;
    reg sel ;

    integer i;

    Mux16 dut (.a(a), .b(b), .out(out), .sel(sel));
    initial begin
        $monitor("time %0dt | a=%b b=%b sel=%b out=%b", $time, a, b, sel, out);
        a=16'h0000; b=16'h0000; sel=1'b0; #1; 
        a=16'hffff; b=16'hffff; sel=1'b0; #1;

        for (i = 0; i<21 ; i = i + 1 ) begin
            a=$urandom; b=$urandom; sel=$urandom; #1;
        end
        $finish;
    end
endmodule