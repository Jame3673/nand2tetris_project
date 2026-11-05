`timescale 1ns / 1ps

module Register16 (
    input wire clk,
    input wire load,
    input wire [15:0] d,
    output reg [15:0] q,
    output reg [15:0] notq
);

    always @(posedge clk) begin
        if (load) begin
            q <= d;
            notq <= ~d;
        end
    end

    
endmodule