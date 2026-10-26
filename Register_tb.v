//`timescale 1ps/1ps
`include "Register.v"

module Register_tb ();
    reg clk;
    reg load;
    reg d;
    wire q;
    wire notq;
    
    // clock pulse
    initial begin
        clk = 0;
        forever begin
            #2.5 clk = ~clk;
        end
    end
    Register dut(.clk(clk), .load(load), .d(d), .q(q), .notq(notq));

    initial begin
        force dut.iDflipflop.q = 1'b0;
        #1;
        release dut.iDflipflop.q;
    end

    initial begin
        $dumpfile("wave/Register_wave.vcd");
        $dumpvars(0, Register_tb);

        $monitor("Time %t |load=%b| d=%b q=%b notq=%b", $time, load, d, q, notq);
        load=0; d=0; #5;
        load=0; d=1; #5;
        load=1; d=0; #5;
        load=1; d=1; #5;
        $finish;
    end

    
endmodule