`include "PC.v"
`timescale 1 ns / 1 ps

module PC_tb();
    reg [15:0] in;
    reg load;
    reg inc;
    reg reset;
    reg clk;
    wire [15:0] out;

    PC uut (
        .in(in), 
        .load(load), 
        .inc(inc), 
        .reset(reset), 
        .clk(clk), 
        .out(out)
    );

    initial begin
        clk = 0;
        forever #2.5 clk = ~clk;
    end

    initial begin
        $monitor("Time=%t ps clk=%b | reset=%b load=%b inc=%b in=%0d | PC Out (address)=%0d", 
                 $time, clk, reset, load, inc, in, out);

        reset = 1; load = 0; inc = 0; in = 16'd0;
        #5; 

        reset = 0; load = 1; inc = 0; in = 16'd10; 
        #5; 

        load = 0; inc = 1; 
        #5; 

        #5;

        inc = 0;
        #5;

        $finish;
    end
endmodule