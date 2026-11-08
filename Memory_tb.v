`include "Memory.v"
`timescale 1ns / 1ps

module Memory_tb();
    reg clk;
    reg [15:0] outM;
    reg writeM;
    reg [14:0] addressM; 
    wire [15:0] out;

    initial begin
      clk = 0;
      forever begin
        #2.5 clk = ~clk;
      end
    end

    Memory dui(.clk(clk), .in(outM), .load(writeM), .address(addressM), .out(out));

    initial begin
        $monitor ("time %t, %b| outM=%b addressM=%b | writeM=%b | out=%b",
        $time, clk, outM, addressM, writeM, out);

        // RAM space for display 16001 -> 24000


        outM=16'd1; addressM=15'd16001; writeM=1; #5;
        outM=16'd3; addressM=15'd16001; writeM=1; #5;

         

        $finish;
    end


endmodule