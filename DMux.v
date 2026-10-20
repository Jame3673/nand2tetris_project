module DMux (
    input wire in,
    input wire sel,
    output reg a,
    output reg b
);
reg notSel;

always @(*) begin
        notSel = ~sel;
        a = in & notSel;
        b = in & sel;
    end
endmodule