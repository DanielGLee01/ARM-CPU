module De0_SoC (CLOCK_50, KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
	input logic CLOCK_50;
	input logic [3:0]  KEY;
	input logic [9:0]  SW;
	
	output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]  LEDR;
endmodule