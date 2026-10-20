`timescale 1ps/1ps
`include "ALU.v"

module ALU_tb ();
    reg [15:0] x;
    reg [15:0] y;
    reg zx;
    reg zy;
    reg nx;
    reg ny;
    reg f;
    reg no;
    wire [15:0] out;
    wire zr;
    wire ng;

    

    integer i;

    ALU dut(.x(x), .y(y), .zx(zx), .zy(zy), .nx(nx), .ny(ny), .f(f), .no(no), .out(out), .zr(zr), .ng(ng));
    initial begin
        $dumpfile("ALU_wave.vcd");
        $dumpvars(0, ALU_tb);
        
        $monitor("time %0dt | x=%b y=%b zx=%b nx=%b zy=%b ny=%b f=%b no=%b out=%b zr=%b ng=%b",
                $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);
        x=16'hffff; y=16'h0000; zx=1'b0; nx=1'b0; zy=1'b0; ny=1'b0; f=1'b1; no=1'b0; #5;

        for ( i=0; i<11 ; i=i+1 ) begin
            x=$urandom; y=$urandom; zx=$urandom; nx=$urandom; zy=$urandom; ny=$urandom; f=$urandom; no=$urandom; #5;
        end
        $finish;        
    end
    
endmodule