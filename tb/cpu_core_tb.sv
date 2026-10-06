`default_nettype none

module cpu_core_tb();
	import CPU_parameters::*;
	
	logic clk, reset, step_en;
	logic [3:0] fpga_display_addr_in;
	logic [DATA_WIDTH-1:0] fpga_display_data;
	
	cpu_core dut (.clk, .reset, .step_en, .fpga_display_addr_in, .fpga_display_data);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		reset <= 0; step_en <= 0; 																	  @(posedge clk);
																										     @(posedge clk);
		reset <= 1; 																				     @(posedge clk);
																										     @(posedge clk);
		reset <= 0; 																				     @(posedge clk);
																										     @(posedge clk);
		step_en <= 1;																					  @(posedge clk);
		step_en <= 0;																					  @(posedge clk);
																										     @(posedge clk);
																										     @(posedge clk);
																										     @(posedge clk);
																										     @(posedge clk);
																										     @(posedge clk);
																										     @(posedge clk);
		step_en <= 1;																					  @(posedge clk);
		step_en <= 0;																					  @(posedge clk);
   $stop;
	end
endmodule
