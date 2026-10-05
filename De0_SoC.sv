module De0_SoC (CLOCK_50, KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
	input logic CLOCK_50;
	input logic [3:0]  KEY;
	input logic [9:0]  SW;
	
	output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]  LEDR;
	
	// Turn off HEX displays and LEDS
	// assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	assign LEDR = 10'b0000000000;
	
	// testing 7 seg decoder on FPGA
	seg7_decoder seg7_start (.four_bit_num(SW[3:0]), .segment_display(HEX0));
endmodule