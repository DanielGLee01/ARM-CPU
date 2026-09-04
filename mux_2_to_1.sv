parameter WIDTH = 1;

module mux_2_to_1 import CPU_parameters::*; (a, b, s, y);
	input logic [WIDTH-1:0] a, b;
	input logic s;
	output logic [WIDTH-1:0] y;
	
	assign y = s ? b : a;
	
endmodule

module mux_2_to_1_testbench();
	import CPU_parameters::*;
	
	logic [WIDTH-1:0] a, b; 
	logic s; 
	logic [WIDTH-1:0] y;
	
	mux_2_to_1 dut (.a, .b, .s, .y);
	
	initial begin
		s = 0; a = 0; b = 0; #100;
		s = 0; a = 0; b = 1; #100;
		s = 0; a = 1; b = 0; #100;
		s = 0; a = 1; b = 1; #100;
		s = 1; a = 0; b = 0; #100;
		s = 1; a = 0; b = 1; #100;
		s = 1; a = 1; b = 0; #100;
		s = 1; a = 1; b = 1; #100;
	end
endmodule
	