module De0_SoC import CPU_parameters::*; (clk, reset);
	input logic clk, reset;
	
	logic [PC_WIDTH-1:0] PC_value;
	logic [DATA_WIDTH-1:0] instruction;

	// wiring modules for fetch stage
	program_counter PC_start (.clk, .reset, .PC_value);
	instruction_memory instr_memory_start (.addr_in(PC_value), .instr_out(instruction));
	
endmodule

module De0_SoC_testbench();
	logic clk, reset;
	
	logic [PC_WIDTH-1:0] PC_value;
	logic [DATA_WIDTH-1:0] instruction;	
	
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