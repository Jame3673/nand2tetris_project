`timescale 1ps/1ps
`include "Or16.v"

module Or16_tb ();
    reg [15:0]a;
    reg [15:0]b;
    wire [15:0]out;

    Or16 iOr16(.a(a), .b(b), .out(out));
    initial begin
        $dumpfile("Or16_wave.vcd");
        $dumpvars(0, Or16_tb);

        $monitor("TIME %0dt | a=%b, b=%b, out=%b", $time, a, b, out);

        a=16'h00ff; b=16'hff00; #2;
        a=16'b0101010101010101; b=16'b1010101010101010; #2;
        $finish;
    end

endmodule