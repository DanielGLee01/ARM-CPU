module d_ff (clk, in, out);
	input logic clk, in;
	output logic out;
	
	logic passthrough;
	
	always_ff @(posedge clk) begin
		passthrough <= in;
		out <= passthrough;
	end
endmodule

module d_ff_testbench ();
	logic clk, in;
	
	logic out;
	
	d_ff dut (.clk, .in, .out);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		in <= 0;																						     @(posedge clk);
																											  @(posedge clk);
																											  @(posedge clk);
      #1; assert (out === 0) else $error("double flip flop not instantiated correctly, output is %b", out);
		in <= 1;																						     @(posedge clk);
																											  @(posedge clk);
																											  @(posedge clk);
      #1; assert (out === 1) else $error("double flip flop not instantiated correctly, output is %b", out);
		in <= 0;																						     @(posedge clk);
																											  @(posedge clk);
																											  @(posedge clk);
      #1; assert (out === 0) else $error("double flip flop not instantiated correctly, output is %b", out);
		$stop;
	end
endmodule