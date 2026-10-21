module DMux2x4 (
    input wire sel0,
    input wire sel1,
    output wire out0,
    output wire out1,
    output wire out2,
    output wire out3
);
    assign out0 = ~sel0 & ~sel1;
    assign out1 = sel0 & ~sel1;
    assign out2 = ~sel0 & sel1;
    assign out3 = sel0 & sel1;
endmodule