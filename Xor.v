module Xor (
    input wire a,
    input wire b,
    output reg out
);

reg not_a;
reg not_b;
reg aAndnotb;
reg notaAndb;

always @(*) begin
    not_a = ~a;
    not_b = ~b;
    aAndnotb = a & not_b;
    notaAndb = not_a & b;
    out = aAndnotb | notaAndb;
end
    
endmodule