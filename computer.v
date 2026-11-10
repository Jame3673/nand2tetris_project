`timescale 1ns / 1ps
`include "CPU.v"
`include "Memory.v"
`include "Rom16k.v"

module computer(
    input wire clk,
    input wire reset
);



wire [15:0] instruction;
wire [15:0] out_mem;
wire writeM;
wire [15:0] outM;
wire [14:0] addressM;
wire [14:0] pc;

Rom16k irom(
    .address(pc), 
    .out(instruction));

CPU icpu(
    .clk(clk), 
    .instruction(instruction),
    .inM(out_mem),
    .reset(reset),
    .outM(outM),
    .writeM(writeM),
    .addressM(addressM),
    .pc(pc)
    );

Memory imem(
    .clk(clk), 
    .in(outM), 
    .load(writeM), 
    .address(addressM), 
    .out(out_mem)
    );

endmodule