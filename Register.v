`timescale 1ns / 1ps
`include"Dflipflop.v"
`include "Mux.v"

module Register (
    input wire clk,
    input wire load,
    input wire d,
    output wire q,
    output wire notq
);
    wire D;
    Mux imux(.a(q), .b(d), .sel(load), .out(D));
    Dflipflop iDflipflop(.d(D), .en(clk), .q(q), .notq(notq));
endmodule