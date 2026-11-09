`timescale 1ns / 1ps

module Memory(
    input wire clk,
    input wire [15:0] in,
    input wire load,
    input wire [14:0] address,
    output wire [15:0] out
);

reg [15:0] ram [0:16383];
reg [15:0] display [0:8191];


always @(posedge clk) begin
    if (load) begin
        if (address[14] == 1'b0) begin
            ram[address[13:0]] <= in;
        end else begin
            if (address[13] == 1'b0) begin
                display[address[12:0]] <= in;
            end
        end
    end
end

assign out = (address[14] == 1'b0) ? ram[address[13:0]] : display[address[12:0]];

endmodule