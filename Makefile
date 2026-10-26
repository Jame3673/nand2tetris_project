%.vvp : %_tb.v
	iverilog -o run/$@ -Wall $<




