`timescale 1ps/1ps
`include "DMux.v"

module DMux_tb ();
reg in;
reg sel;
wire a;
wire b;

DMux iDMux(.in(in), .sel(sel), .a(a), .b(b));
initial begin
    $dumpfile("wave/DMux_wave.vcd");
    $dumpvars(0, DMux_tb);

    $monitor("time %0dt | in=%b, sel=%b, a=%b, b=%b", $time, in, sel, a, b);
    in=0; sel=0; #1;
    in=1; sel=0; #1;
    in=0; sel=1; #1;
    in=1; sel=1; #1;
    $finish;
end
    
endmodule