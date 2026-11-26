`timescale 1ns / 1ps

module Rom16k(
    input wire [14:0] address,
    output wire [15:0] out
);

    reg [15:0] rom [0:32767];

    initial begin
        $readmemb("./data/sub.dat", rom);
    end

    assign out = rom[address];

    // testbench
    // integer i;
    // always @(*) begin
    //     for (i=0; i<10; i = i + 1) begin
    //               $display("rom [%0d] = %b", i, rom[i]);
    //     end
    // end

endmodule