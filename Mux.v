`timescale 1ns / 1ps
module Mux (
    input wire a,
    input wire b,
    input wire sel,
    output wire out
);


assign out = ~sel & a | sel & b;

endmodule