`timescale 1ns / 1ps

module Memory(
    input wire clk,
    input wire [15:0] in,
    input wire load,
    input wire [14:0] address,
    output wire [15:0] out
);

reg [15:0] ram [0:24000];

always @(posedge clk) begin
    if (load) begin
        ram[address] <= in ;
    end
end

assign out = ram[address];

endmodule