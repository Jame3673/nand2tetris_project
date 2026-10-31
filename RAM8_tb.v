`timescale 1ns / 1ps
`include "RAM8.v"

module RAM8_tb ();
    reg clk;    
    reg [15:0] in;
    reg load;
    reg [2:0] addr;
    wire [15:0] out;
    //wire [15:0] nout;



    // clock pulse
    initial begin
        clk = 0;
        forever begin
            #2.5 clk = ~clk;
        end
    end

    RAM8 dui(.in(in), .load(load), .addr(addr), .clk(clk), .out(out));
    initial begin
        $monitor("Time %t clk=%b| in=%b load=%b addr=%b | out=%b",
        $time, clk, in, load, addr, out);

        in=16'd0; load=1; addr=3'd2; #5;
        in=16'd10; load=1; addr=3'd2; #5;
        in=16'd1; load=1; addr=3'd2; #5;
        $finish;
    end
endmodule