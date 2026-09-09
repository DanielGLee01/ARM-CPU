module alu import CPU_parameters::*; (a, b, operation, result, carry_flag, zero_flag, negative_flag, overflow_flag);
	input logic [DATA_WIDTH-1:0] a, b;
	input logic [3:0] operation;
	output logic [DATA_WIDTH-1:0] result;
	output logic carry_flag, zero_flag, negative_flag, overflow_flag;
	
	logic cin, cout;
	logic [DATA_WIDTH-1:0] b_xored, arithmetic_result;
	logic add_or_sub_sig;
	
	always_comb begin
		result = 0;
		carry_flag = 0;
		overflow_flag = 0;
		cin = 0;
		add_or_sub_sig = 0;
		
		case(operation)
			4'b0000: begin //addition operation
				cin = 0;
				add_or_sub_sig = 0;
				result = arithmetic_result;
				carry_flag = cout;
				overflow_flag = (a[31] & b[31] & ~arithmetic_result[31]) || (~a[31] & ~b[31] & arithmetic_result[31]);
			end
			4'b0001: begin // subtraction operation
				cin = 1;
				add_or_sub_sig = 1;
				result = arithmetic_result;
				carry_flag = cout;
				overflow_flag = (a[31] & ~b[31] & ~arithmetic_result[31]) || (~a[31] & b[31] & arithmetic_result[31]);
			end
			4'b0010: begin // bitwise AND
				result = a & b;
			end
			4'b0011: begin // bitwise OR
				result = a | b;
			end
			4'b0100: begin // bitwise XOR
				result = a ^ b;
			end
			4'b0101: begin // reserved
				
			end
			4'b0110: begin // reserved
				
			end
			4'b0111: begin // reserved
			
			end
		endcase
	end
	
	assign b_xored = b ^ {32{add_or_sub_sig}};
	
	add32 add_or_subtract (.a, .b(b_xored), .cin, .sum(arithmetic_result), .cout);
	
	assign zero_flag = (result == 0);
	assign negative_flag = result[31];
endmodule

module alu_testbench();
	import CPU_parameters::*;
	
	logic [DATA_WIDTH-1:0] a, b;
	logic [3:0] operation;
	logic [DATA_WIDTH-1:0] result;
	logic carry_flag, zero_flag, negative_flag, overflow_flag;
	
	alu dut (.a, .b, .operation, .result, .carry_flag, .zero_flag, .negative_flag, .overflow_flag);
	
	initial begin
		a = 32'hFFFFFFFF; b = 32'h00000001; operation = 4'b0000; #100; // expected result - 33'h100000000, carry_flag = 1
		a = 32'hFFFFFFFF; b = 32'h00000001; operation = 4'b0001; #100; // expected result - 33'hFFFFFFFE
		a = 32'hAAAAAAAA; b = 32'h55555555; operation = 4'b0000; #100; // expected result - 33'hFFFFFFFF
		a = 32'hAAAAAAAA; b = 32'h55555555; operation = 4'b0001; #100; // expected result - 32'h55555555
		a = 32'hBBBBBBBB; b = 32'h55555555; operation = 4'b0001; #100; // expected result - 32'h66666666
		a = 32'h00000000; b = 32'h00000000; operation = 4'b0000; #100; // expected result - 32'h00000000
		a = 32'h00000000; b = 32'h00000000; operation = 4'b0001; #100; // expected result - 32'h00000000
		a = 32'h55555555; b = 32'hAAAAAAAA; operation = 4'b0001; #100; 
		a = 32'hAAAAAAAA; b = 32'h55555555; operation = 4'b0010; #100; // expected result = 32'h00000000
		a = 32'hAAAAAAAA; b = 32'h55555555; operation = 4'b0011; #100; // expected result - 32'hFFFFFFFF
		a = 32'hAAAAAAAA; b = 32'hAAAAAAAA; operation = 4'b0100; #100; // expected result - 32'h00000000
	end
endmodule