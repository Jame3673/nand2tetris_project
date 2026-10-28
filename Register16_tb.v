`include "Register16.v"

module Register16_tb ();
    reg clk;
    reg load;
    reg [15:0] d;
    wire [15:0] q;
    wire [15:0] notq;
    
    initial begin
        clk = 0;
        forever begin
            #2.5 clk = ~clk;
        end
    end

    Register16 dut(.clk(clk), .load(load), .d(d), .q(q), .notq(notq));

    initial begin
        $monitor("Time %t |load=%b| d=%b q=%b notq=%b", $time, load, d, q, notq);
        load=1'd1; d=16'd0; #5;
        load=1'd1; d=16'd10; #5;
        load=1'd0; d=16'd22; #5;
        $finish;
    end
endmodule