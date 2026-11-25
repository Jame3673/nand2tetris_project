run : computer_tb.v
	iverilog -Wall -o run/computer.vvp $<
	vvp run/computer.vvp

%.vvp : %_tb.v
	iverilog -Wall -o run/$@ $<