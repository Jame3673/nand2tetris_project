`timescale 1 ns / 1 ps
`include "Register16.v"
`include "Mux16.v"
`include "ALU.v"
`include "PC.v"

module CPU(
    input wire clk,
    input wire [15:0] inM,
    input wire [15:0] instruction,
    input wire reset,

    output wire [15:0] Aregout,
    output wire [15:0] Dregout,

    output wire [15:0] outM,
    output wire writeM,
    output wire [14:0] addressM,
    output wire [14:0] pc
);
    // 15 14 13 12 11 10 9  8  7  6  5  4  3  2  1  0  | index
    // 0  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  | a-instruction
    // 1  1  1  a  c1 c2 c3 c4 c5 c6 d1 d2 d3 j1 j2 j3 | c-instruction
    wire [15:0] ALUoutput;
    assign outM = ALUoutput;

    wire Type;
    assign Type = instruction[15];

    wire [15:0] Mux0out, Mux1out, y, x;
    wire a_command;
    assign a_command = instruction[12];
    assign y = Mux1out;
    assign addressM = Aregout [14:0];

    assign x = Dregout;

    wire zx, nx, zy, ny, f, no; // ALU input 
    wire zr, ng;                // ALU output
    assign zx = instruction[11];
    assign nx = instruction[10];
    assign zy = instruction[9];
    assign ny = instruction[8];
    assign f = instruction[7];
    assign no = instruction[6];

    // A-register16
    Mux16 m0(.a(ALUoutput), .b(instruction), .sel(~Type), .out(Mux0out));
    Register16 AReg(.clk(clk), .load(~Type | instruction[5]), .d(Mux0out), .q(Aregout));
    Mux16 m1(.a(Aregout), .b(inM), .sel(a_command), .out(Mux1out));

    // D-register16
    Register16 DReg(.clk(clk), .load(instruction[15] & instruction[4]), .d(ALUoutput), .q(Dregout));

    // debug A load, D load, Mux0, Areg
    // always @(posedge clk) begin
    //     $display("Time=%0t | A_load=%b | D_load=%b | Mux0out=%h | Areg=%0d", 
    //              $time, (~Type | instruction[5]), (instruction[15] & instruction[4]), Mux0out, Aregout);
    // end

    // ALU
    ALU alu(.x(x), .y(y), .zx(zx), .zy(zy), .nx(nx), .ny(ny), .f(f), .no(no), .out(ALUoutput), .zr(zr), .ng(ng));

    // Comparator
    wire gtz;
    assign gtz = ~zr & ~ng;

    // Jumping to other memory address
    wire [2:0] jump; 
    assign jump = instruction [2:0];

    wire jump_result;
    assign jump_result = (jump[2] & ng) | (jump[1] & zr) | (jump[0] & gtz);

    // PC
    

    wire load;
    wire inc;
    wire [15:0] pc_full;
    assign load = jump_result & Type;
    assign inc = ~load;

    PC pro_cou(.in(Aregout), .load(load), .inc(inc), .reset(reset), .clk(clk), .out(pc_full));
    assign pc = pc_full [14:0];

    // allow write into memory
    assign writeM = instruction[3] & instruction[15]; 
endmodule