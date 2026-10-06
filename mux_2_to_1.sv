`default_nettype none

module mux_2_to_1 #(parameter WIDTH = 32) (a, b, s, y);
	input logic [WIDTH-1:0] a, b;
	input logic s;
	output logic [WIDTH-1:0] y;
	
	assign y = s ? a : b;
	
endmodule
