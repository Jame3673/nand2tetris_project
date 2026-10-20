`timescale 1ps/1ps
`include "Inc16.v"

module Inc16_tb ();
    reg [15:0]a;
    wire cout;
    wire [15:0]out;


    Inc16 dut(.a(a), .cout(cout), .out(out));

    initial begin
    $dumpfile("Inc16_wave.vcd");
    $dumpvars(0, Inc16_tb);

    $monitor("TIME %0dt | a=%b, cout=%b, out=%b ", $time, a, cout, out);
    a = 16'h0000; #5;                     // 0 + 1 = 1

    a = 16'b0000111100001111; #5;         // 16'h0F0F + 1 = 16'h0F10

    a = 16'd10; #5;                // 10 + 1 = 11

    a = 16'hFFFF; #5;
    $finish;
    end

endmodule