module edge_detector (clk, in, out);
	input logic clk, in;
	output logic out;
	
	logic stored_input;
	
	always_ff @(posedge clk) begin
		stored_input <= in;
	end
	
	assign out = in & ~stored_input;
endmodule

module edge_detector_testbench();
	logic clk, in, out;
	
	edge_detector dut (.clk, .in, .out);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		in <= 0;																							  @(posedge clk); // input is 0, stored is 0, so out is 0
																											  @(posedge clk);
		assert (out === 0) else $error("edge detector not working correctly, output is %b", out);
		in <= 1;																							  @(posedge clk); // button press (in is 1, stored is 0) so out is 1
		assert (out === 1) else $error("edge detector not working correctly, output is %b", out);
																											  @(posedge clk); // input is 1, stored is 1, so out is 0
		assert (out === 0) else $error("edge detector not working correctly, output is %b", out);
		in <= 0;
																											  @(posedge clk); // input is 0, stored is 1, so out is 0
		assert (out === 0) else $error("edge detector not working correctly, output is %b", out);
		$stop;
	end
endmodule