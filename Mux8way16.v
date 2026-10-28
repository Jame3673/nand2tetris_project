module Mux8way16 (
    input wire [15:0] a,
    input wire [15:0] b,
    input wire [15:0] c,
    input wire [15:0] d,
    input wire [15:0] e,
    input wire [15:0] f,
    input wire [15:0] g,
    input wire [15:0] h,
    input wire [2:0] sel,
    output reg [15:0] out
);
    reg [15:0] o0;
    reg [15:0] o1;
    reg [15:0] o2;
    reg [15:0] o3;
    reg [15:0] o4;
    reg [15:0] o5;

always @(*) begin
    case (sel)
        3'b000: out = a;
        3'b001: out = b;
        3'b010: out = c;
        3'b011: out = d;
        3'b100: out = e;
        3'b101: out = f;
        3'b110: out = g;
        3'b111: out = h;
        default: out = 16'b0;
    endcase
end
    
endmodule