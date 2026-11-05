`timescale 1 ns / 1ps
`include "CPU.v"

module CPU_tb();
    reg clk;
    reg [15:0] inM;
    reg [15:0] instruction;
    reg reset;
    wire [15:0] outM;
    wire writeM;
    wire [14:0] addressM;
    wire [14:0] pc;

    initial begin
      clk = 0;
      forever #2.5 clk = ~clk;
    end

    CPU dut(
        .clk(clk), 
        .instruction(instruction),
        .inM(inM),
        .reset(reset),
        .outM(outM),
        .writeM(writeM),
        .addressM(addressM),
        .pc(pc)
    );

    initial begin
      $monitor("Time %t | clk=%b | instr=%b inM=%b rs=%b | outM=%b addrM=%b writeM=%b pc=%b", 
        $time, clk, instruction, inM, reset, outM, addressM, writeM, pc);
        instruction=16'd0; inM=16'd0; reset=0; #5;

        $finish;
    end

endmodule