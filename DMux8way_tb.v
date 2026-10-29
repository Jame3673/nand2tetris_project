`include "DMux8way.v"

module DMux8way_tb ();
    reg in;
    reg [2:0] sel;
    wire a;
    wire b;
    wire c;
    wire d;
    wire e;
    wire f;
    wire g;
    wire h;

    DMux8way dut(.in(in), .sel(sel), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h));

    initial begin
        $monitor("time %t | in=%b sel=%b %b%b%b%b%b%b%b%b", $time, in, sel, a, b, c, d, e, f, g, h);
        in=0; sel=3'b000; #5;
        in=1; sel=3'b000; #5;
        in=1; sel=3'b001; #5;
        in=1; sel=3'b010; #5;
        in=1; sel=3'b011; #5;
        in=1; sel=3'b100; #5;
        in=1; sel=3'b101; #5;
        in=1; sel=3'b110; #5;
        in=1; sel=3'b111; #5;
        $finish;
    end
endmodule