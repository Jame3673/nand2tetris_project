`timescale 1ps/1ps
`include "DMux2x4.v"

module DMux2x4_tb ();
    reg sel0;
    reg sel1;
    wire out0;
    wire out1;
    wire out2;
    wire out3;
    integer i;

    DMux2x4 dut(.sel0(sel0), .sel1(sel1), .out0(out0), .out1(out1), .out2(out2), .out3(out3));
    initial begin
        $monitor("Time %0dt | sel0=%b sel1=%b | out3=%b out2=%b out1=%b out0=%b", $time, sel0, sel1, out3, out2, out1, out0);
        sel0=1'b0; sel1=1'b0; #5;
        sel0=1'b1; sel1=1'b0; #5;
        sel0=1'b0; sel1=1'b1; #5;
        sel0=1'b1; sel1=1'b1; #5;
        
        $finish;
    end
endmodule