// 1 bit full subtractor. This module will not be used in the final design and is simply here for practice
module sub1(a, b, bin, diff, bout);
	input logic a, b, bin;
	output logic diff, bout;
	
	assign diff = a ^ b ^ bin;
	assign bout = (b | bin) & (~a | b) & (~a | bin);

endmodule

module sub1_testbench();
	logic a, b, bin, diff, bout;
	
	sub1 dut (.a, .b, .bin, .diff, .bout);
	
	initial begin
		a = 0; b = 0; bin = 0; #10;
		a = 0; b = 0; bin = 1; #10;
		a = 0; b = 1; bin = 0; #10;
		a = 0; b = 1; bin = 1; #10;
		a = 1; b = 0; bin = 0; #10;
		a = 1; b = 0; bin = 1; #10;
		a = 1; b = 1; bin = 0; #10;
		a = 1; b = 1; bin = 1; #10;
	end
endmodule