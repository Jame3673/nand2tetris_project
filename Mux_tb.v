`timescale 1ps/1ps
`include "Mux.v"

module Mux_tb ();
reg a;
reg b;
reg sel;
wire out;


Mux iMux(.a(a), .b(b), .sel(sel), .out(out));
initial begin
    $dumpfile("Mux_wave.vcd");
    $dumpvars(0, Mux_tb);

    $display("| a | b | sel | out | TIME |");
    $monitor("| %b | %b |  %b  | %b | %0dt |", a, b, sel, out, $time);
    a=0; b=0; sel=0; #1;
    a=0; b=1; sel=0; #1;
    a=1; b=0; sel=0; #1;
    a=1; b=1; sel=0; #1;

    a=0; b=0; sel=1; #1;
    a=0; b=1; sel=1; #1;
    a=1; b=0; sel=1; #1;
    a=1; b=1; sel=1; #1;
    $finish;
end    

endmodule