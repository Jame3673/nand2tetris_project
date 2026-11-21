`timescale 1ns / 1ps
`include "computer.v"

module computer_tb();
    reg clk;
    reg reset;
    integer log_fd;

    initial begin
      clk = 0;
      forever begin
        #2.5 clk = ~clk;
      end
    end

    computer dui(.clk(clk), .reset(reset));

    initial begin
      // Mở file text để ghi ("w" = ghi đè mới mỗi lần chạy)
      log_fd = $fopen("./data/sim_log.txt", "w");
      if (log_fd == 0) begin
        $display("Khong mo duoc file log!");
        $finish;
      end

      // Vừa in ra terminal (nếu cần), vừa ghi vào file text
      $fmonitor(log_fd, "Time=%0t | rst=%b | pc=%0d | writeM=%b | addrM=%0d | outM=%b",
                $time, reset, dui.icpu.pc, dui.icpu.writeM, dui.icpu.addressM, dui.icpu.outM);

      reset = 1'b1; #10;
      reset = 1'b0; #300000;

      $fclose(log_fd);
      $finish;
    end

endmodule