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
    
    wire i0, i1, i2, i3, i4, i5, i6, i7;

    wire [15:0] o0, o1, o2, o3, o4, o5, o6, o7;

    wire [15:0] no0, no1, no2, no3, no4, no5, no6, no7;

        DMux8way dmux(.in(load), .sel(addr), .a(i0), .b(i1), .c(i2), .d(i3), .e(i4), .f(i5), .g(i6), .h(i7));
        Register16 r0(.clk(clk), .load(i0), .d(in), .q(o0), .notq(no0));
        Register16 r1(.clk(clk), .load(i1), .d(in), .q(o1), .notq(no1));
        Register16 r2(.clk(clk), .load(i2), .d(in), .q(o2), .notq(no2));
        Register16 r3(.clk(clk), .load(i3), .d(in), .q(o3), .notq(no3));
        Register16 r4(.clk(clk), .load(i4), .d(in), .q(o4), .notq(no4));
        Register16 r5(.clk(clk), .load(i5), .d(in), .q(o5), .notq(no5));
        Register16 r6(.clk(clk), .load(i6), .d(in), .q(o6), .notq(no6));
        Register16 r7(.clk(clk), .load(i7), .d(in), .q(o7), .notq(no7));
        Mux8way16 mux(.a(o0), .b(o1), .c(o2), .d(o3), .e(o4), .f(o5), .g(o6), .h(o7), .sel(addr), .out(out));
    


endmodule