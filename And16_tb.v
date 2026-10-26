`timescale 1ps/1ps
`include "And16.v"

module And16_tb ();
reg [15:0]a;
reg [15:0]b;
wire [15:0]out;

And16 iAnd16 (.a(a), .b(b), .out(out));
initial begin

    $dumpfile("wave/And16_wave.vcd");
    $dumpvars(0, And16_tb);

    $monitor("time=%0dt | a=%h, b=%h | out=%h", $time, a, b, out);

    a = 16'hFFFF; b = 16'h00FF; #5;
    a = 16'd10;   b = 16'd5;    #5;

    $finish;
end

endmodule