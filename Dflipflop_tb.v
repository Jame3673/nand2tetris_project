`timescale 1ps/1ps
`include "Dflipflop.v"

module Dflipflop_tb ();
    reg d;
    reg en;
    wire q;
    wire notq;

    Dflipflop dut(.d(d), .en(en), .q(q), .notq(notq));
    initial begin
        $dumpfile("wave/Dflipflop_wave.vcd");
        $dumpvars(0, Dflipflop_tb);

        $monitor("Time %t |en=%b| d=%b q=%b notq=%b", $time, en, d, q, notq);
        en=1; d=1; #5;
        en=1; d=0; #5;
        en=0; d=1; #5;
        en=0; d=0; #5; 
    end

endmodule