`include "Mux8way16.v"

module Mux8way16_tb ();
    reg [15:0] a;
    reg [15:0] b;
    reg [15:0] c;
    reg [15:0] d;
    reg [15:0] e;
    reg [15:0] f;
    reg [15:0] g;
    reg [15:0] h;
    reg [2:0] sel;
    wire [15:0] out;
    integer i;

    Mux8way16 dut(.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h), .sel(sel), .out(out));

    initial begin
        $monitor("Time %0dt | a=%b b=%b c=%b d=%b e=%b f=%b g=%b h=%b | sel=%b | out=%b",
                $time, a, b, c, d, e, f, g, h, sel, out);
        a=16'd0; b=16'd0; c=16'd0; d=16'd0; e=16'd0; f=16'd0; g=16'd0; h=16'd0; sel=3'b000; #5;
        a=16'd0; b=16'd1; c=16'd0; d=16'd0; e=16'd0; f=16'd0; g=16'd0; h=16'd0; sel=3'b001; #5;

        for ( i=0 ; i<16 ; i=i+1 ) begin
            a=$urandom; b=$urandom; c=$urandom; d=$urandom; e=$urandom; f=$urandom; g=$urandom; h=$urandom; sel=$urandom; #5;
        end
        $finish;
    end
endmodule