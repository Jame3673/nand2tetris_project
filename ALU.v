//`include "Mux16.v"
`include "Add16.v"
`include "Or16way.v"

module ALU (
    input wire zx, 
    input wire nx, 
    input wire zy, 
    input wire ny, 
    input wire f, 
    input wire no,
    input wire [15:0] x,
    input wire [15:0] y,
    output wire [15:0] out,
    output wire zr,
    output wire ng
);

wire [15:0] end_zx;
wire [15:0] end_zy;
wire [15:0] end_nx;
wire [15:0] end_ny;
wire [15:0] xPlusy;
wire [15:0] end_f;
wire has_one;

// X
Mux16 Mux16_zx(.a(x), .b(16'b0), .out(end_zx), .sel(zx));
Mux16 Mux16_nx(.a(end_zx), .b(~end_zx), .out(end_nx), .sel(nx));

// Y
Mux16 Mux16_zy(.a(y), .b(16'b0), .out(end_zy), .sel(zy));
Mux16 Mux16_ny(.a(end_zy), .b(~end_zy), .out(end_ny), .sel(ny));

// x + y
Add16 Add(.a(end_nx), .b(end_ny), .out(xPlusy), .cout());

// f
Mux16 Mux16_f(.a(end_nx & end_ny), .b(xPlusy), .out(end_f), .sel(f));

// no -> out
Mux16 Mux16_no (.a(end_f), .b(~end_f), .sel(no), .out(out));

// zr
Or16way into1(.a(out), .out(has_one));
assign zr = ~has_one;

// ng
assign ng = out[15];
endmodule