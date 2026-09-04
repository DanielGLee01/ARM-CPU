module persistent_flags(clk, reset, c_flag_in, z_flag_in, n_flag_in, v_flag_in, wr_en, c_flag_out, z_flag_out, n_flag_out, v_flag_out);
	input logic clk, reset;
	input logic c_flag_in, z_flag_in, n_flag_in, v_flag_in;
	input logic wr_en; // S Bit
	
	output logic c_flag_out, z_flag_out, n_flag_out, v_flag_out;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			c_flag_out <= 0;
			z_flag_out <= 0;
			n_flag_out <= 0;
			v_flag_out <= 0;
		end else if (wr_en) begin
			c_flag_out <= c_flag_in;
			z_flag_out <= z_flag_in;
			n_flag_out <= n_flag_in;
			v_flag_out <= v_flag_in;
		end
	end
endmodule

module persistent_flags_testbench();
	logic clk, reset;
	logic c_flag_in, z_flag_in, n_flag_in, v_flag_in; 
	logic wr_en;
	
	logic c_flag_out, z_flag_out, n_flag_out, v_flag_out;
	
	persistent_flags dut (.clk, .reset, .c_flag_in, .z_flag_in, .n_flag_in, .v_flag_in, .wr_en, .c_flag_out, .z_flag_out, .n_flag_out, .v_flag_out);
	
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
	end
endmodule