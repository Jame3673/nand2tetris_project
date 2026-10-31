`timescale 1ns / 1ps
module Dflipflop (
    input wire d,
    input wire en,
    output wire q,
    output wire notq
);
    assign q = notq ~& (en ~& d);
    assign notq = q ~& (en ~& ~d);
endmodule