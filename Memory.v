`timescale 1ns / 1ps

module Memory(
    input wire clk,
    input wire [15:0] in,
    input wire load,
    input wire [14:0] address,
    output wire [15:0] out,

    output wire addr14
);

assign addr14 = address[14];

reg [15:0] ram [0:16383];
reg [15:0] display [0:8191];
reg [15:0] keyboard;

integer k;
initial begin
    for (k = 0; k < 16384; k = k + 1) ram[k] = 16'b0;
    for (k = 0; k < 8192; k = k + 1) display[k] = 16'b0;
    keyboard = 16'b0;
end

always @(posedge clk) begin
    if (load) begin
        if (address[14] == 1'b0) begin
            ram[address[13:0]] <= in;
        end else if (address[13] == 1'b0) begin
            display[address[12:0]] <= in;
        end
    end
end

assign out = (address[14] == 1'b0) ? ram[address[13:0]] :
             (address[13] == 1'b0) ? display[address[12:0]] :
             (address == 15'd24576) ? keyboard : 16'b0;


endmodule