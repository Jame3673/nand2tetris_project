`timescale 1ns / 1ps
`include "DMux8way.v"
`include "Mux8way16.v"
`include "Register16.v"


module RAM8 (
    input wire [15:0] in, 
    input wire load, 
    input wire [2:0] addr, 
    input wire clk,
    output wire [15:0] out
    //output wire [15:0] nout
);
    
    wire [7:0] load_reg;

    wire [15:0] q_reg [7:0];

    wire [15:0] notq_reg [7:0];

        DMux8way dmux(.in(load), .sel(addr), .a(load_reg[0]), .b(load_reg[1]), .c(load_reg[2]), .d(load_reg[3]), .e(load_reg[4]), .f(load_reg[5]), .g(load_reg[6]), .h(load_reg[7]));
        
        genvar i;
        generate
            for (i=0; i<8; i=i+1) begin : gen_reg
              Register16 r0(.clk(clk), .load(load_reg[i]), .d(in), .q(q_reg[i]), .notq(notq_reg[i]));
            end
        endgenerate
        
        
        Mux8way16 mux(.a(q_reg[0]), .b(q_reg[1]), .c(q_reg[2]), .d(q_reg[3]), .e(q_reg[4]), .f(q_reg[5]), .g(q_reg[6]), .h(q_reg[7]), .sel(addr), .out(out));
    


endmodule