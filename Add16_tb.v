`timescale 1ps/1ps
`include "Add16.v"

module Add16_tb ();
    reg [15:0]a;
    reg [15:0]b;
    wire [15:0]out;
    wire cout;

    Add16 dut(.a(a), .b(b), .out(out), .cout(cout));

    initial begin
    $dumpfile("wave/Add16_wave.vcd");
    $dumpvars(0, Add16_tb);

    $monitor("TIME %0dt | a=%b , b=%b , out=%b , cout=%b", $time, a, b, out, cout);
    a = 16'b0000111100001111; b = 16'b1111000011110000; #5;
    a = 16'd10;   b = 16'd5;    #5;

    $finish;
    end

endmodule