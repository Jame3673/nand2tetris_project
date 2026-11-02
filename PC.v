`timescale 1 ns / 1 ps

module PC(
    input wire [15:0] in,
    input wire reset,
    input wire load,
    input wire inc,
    input wire clk,
    output reg [15:0] out
);
    always @(posedge clk) begin
        if (reset)
            out <= 16'b0;
        else if (load)
            out <= in;
        else if (inc)
            out <= out + 16'b1;
        else
            out <= out;
    end
endmodule