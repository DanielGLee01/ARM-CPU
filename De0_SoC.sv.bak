module De0_SoC(SW, KEY, LEDR);
	input logic [9:0] SW;
	input logic [3:0] KEY;
	output logic [9:0] LEDR;
	
	assign LEDR[0] = SW[0];
	assign LEDR[1] = ~KEY[1];

endmodule

module De0_SoC_testbench();
	logic [9:0] SW;
	logic [3:0] KEY;
	logic [9:0] LEDR;
	
	De0_SoC dut (.SW, .KEY, .LEDR);
	
	// Set up a simulated clock.
	//parameter CLOCK_PERIOD=100;
	//initial begin
		//clk <= 0;
		//forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	//end
	
	initial begin
		SW[0] = 0; #100;
		SW[0] = 1; #100;
		SW[0] = 0; KEY[1] = 0; #100;
		KEY[1] = 1; #100;
		$stop;
	end
endmodule