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

    wire [15:0] Aregout;
    wire [15:0] Dregout;

    initial begin
      clk = 0;
      forever begin
        #2.5 clk = ~clk;
      end
    end

    CPU dut(
        .clk(clk), 
        .instruction(instruction),
        .inM(inM),
        .reset(reset),
        .outM(outM),
        .writeM(writeM),
        .addressM(addressM),
        .pc(pc),

        .Aregout(Aregout),
        .Dregout(Dregout)
    );

    initial begin
      $monitor("Time %t | clk=%b | instr=%b inM=%b rs=%b | Areg=%b Dreg=%b outM=%d addrM=%d writeM=%b pc=%d", 
        $time, clk, instruction, inM, reset, Aregout, Dregout, outM, addressM, writeM, pc);
        instruction=16'd0; inM=16'd0; reset=1; #5;

        reset=0; #5;

        instruction=16'b0000000000000001; #5; // @1
        instruction=16'b1110110000010000; #5; // D = A
        //instruction=16'b0000000000000010; #5; // @2
        instruction=16'b1110000010010000; #5; // D = D + A


        $finish;
    end

endmodule