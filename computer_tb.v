`timescale 1ns / 1ps
`include "computer.v"

module computer_tb();
    reg clk;
    reg reset;

    initial begin
      clk = 0;
      forever begin
        #2.5 clk = ~clk;
      end
    end

    computer dui(.clk(clk), .reset(reset));

    initial begin
      $monitor("Time=%0t | rst=%b | PC=%0d | memOut=%b", 
      $time, reset, dui.icpu.pc, dui.imem.out);

      reset = 1'b1; #10;
      reset = 1'b0; #100;
      $finish;
    end

endmodule