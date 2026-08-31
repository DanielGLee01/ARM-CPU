module program_counter import CPU_parameters::*; (clk, reset, PC_value);
	input logic clk, reset;
	output logic [PC_WIDTH-1:0] PC_value;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			PC_value <= 0;
		end
		else begin
			PC_value <= PC_value + 4;
		end
	end
endmodule

module program_counter_testbench();
	import CPU_parameters::*;
	
	logic clk, reset;
	logic [PC_WIDTH-1:0] PC_value;
	
	program_counter dut (.clk, .reset, .PC_value);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		reset <= 0; 																				     @(posedge clk);
																											  @(posedge clk);
		reset <= 1; 																				     @(posedge clk);
																										     @(posedge clk);
		reset <= 0; 																				     @(posedge clk);
																										     @(posedge clk);
		reset <= 1; 																				     @(posedge clk);
																										     @(posedge clk);
		reset <= 0; 																				     @(posedge clk); // PC counter will keep incrementing by 4 unless reset
																										     @(posedge clk);
	end
endmodule