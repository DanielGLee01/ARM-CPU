module program_counter import CPU_Parameters::*; (clk, reset, PC_value);
	input logic clk, reset;
	output logic [PC_WIDTH-1:0] PC_value;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			PC_value <= 0;
		end
		else begin
			PC_value <= PC_Value + 4;
		end
	end
endmodule

module program_counter_testbench();
	import CPU_parameters::*;
	
	logic clk, reset;
	logic [PC_WIDTH-1:0] PC_value;
	
	program_counter dut (.clk, .reset, .PC_value);
	
	
endmodule