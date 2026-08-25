// 1 bit full adder
module add1(a, b, cin, sum, cout);
	input logic a, b, cin;
	output logic sum, cout;
	
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (cin & (a ^ b));

endmodule

module add1_testbench();
	logic a, b, cin, sum, cout;
	
	add1 dut (.a, .b, .cin, .sum, .cout);
	
	initial begin
		a = 0; b = 0; cin = 0; #10;
		a = 0; b = 0; cin = 1; #10;
		a = 0; b = 1; cin = 0; #10;
		a = 0; b = 1; cin = 1; #10;
		a = 1; b = 0; cin = 0; #10;
		a = 1; b = 0; cin = 1; #10;
		a = 1; b = 1; cin = 0; #10;
		a = 1; b = 1; cin = 1; #10;
	end
endmodule