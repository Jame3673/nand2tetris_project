module DMux8way (
    input wire in,
    input wire [2:0] sel,
    output reg a, b, c, d, e, f, g, h
    
);
    always @(*) begin

    a = 0; b = 0; c = 0; d = 0;
    e = 0; f = 0; g = 0; h = 0;

    case (sel)
        3'b000: a = in;
        3'b001: b = in;
        3'b010: c = in;
        3'b011: d = in;
        3'b100: e = in;
        3'b101: f = in;
        3'b110: g = in;
        3'b111: h = in;
    endcase
end
endmodule