`include "Register.v"

module Register16 (
    input wire clk,
    input wire load,
    input wire [15:0] d,
    output wire [15:0] q,
    output wire [15:0] notq
);

    genvar i;
    generate 
        for (i = 0; i<16 ; i = i+1 ) begin : gen_reg
            Register Reg(.clk(clk), .load(load), .d(d[i]), .q(q[i]), .notq(notq[i]));        
        end
    endgenerate

    
endmodule