`timescale 1ps/1ps
`include "Not16.v"

module Not16_tb ();
reg [15:0]in;
wire [15:0]out;

Not16 iNot16 (.in(in), .out(out));
initial begin

    $dumpfile("Not16_wave.vcd");
    $dumpvars(0, Not16_tb);

    $monitor("time=%0dt | in=%b | out=%b", $time, in, out);

    in = 16'hFFFF; #5;
    in = 16'd10;   #5;

    $finish;
end

endmodule