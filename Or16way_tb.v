`timescale 1ps/1ps
`include "Or16way.v"

module Or16way_tb ();
    reg [15:0] a;
    wire out;

    Or16way dut(.a(a), .out(out));

    integer i;

    initial begin
        $dumpfile("Or16way_wave.vcd");
        $dumpvars(0, Or16way_tb);
        $monitor("Time %0dt | a=%b out=%b", $time, a, out);
        a=16'b0000000000000000; #5;

        for (i = 0; i < 20 ; i=i+1 ) begin
            a=$urandom; #5;
        end
        $finish;
    end
endmodule