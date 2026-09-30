module De0_SoC import CPU_parameters::*; (clk, reset);
	input logic clk, reset;
	
	logic [PC_WIDTH-1:0] PC_value;
	logic [DATA_WIDTH-1:0] instruction;
	
	logic [3:0] condition, opcode, Rn, Rd;
	logic [1:0] class_identifier;
	logic I_bit, S_bit;
	logic [11:0] operand_2;

	// wiring modules for fetch stage
	program_counter PC_start (.clk, .reset, .PC_value);
	instruction_memory instr_memory_start (.addr_in(PC_value[10:2]), .instr_out(instruction));
	
	// wiring modules for decode stage
	decoder decode_instr (.instr_in(instruction), .condition, .opcode, .Rn, .Rd, .class_identifier, .I_bit, .S_bit, .operand_2);
	
endmodule

module De0_SoC_testbench();
	import CPU_parameters::*;
	
	logic clk, reset;
	
	logic [PC_WIDTH-1:0] PC_value;
	logic [DATA_WIDTH-1:0] instruction;	
	
	De0_SoC dut (.clk, .reset);
	
	// Set up a simulated clock.
	//parameter CLOCK_PERIOD=100;
	//initial begin
		//clk <= 0;
		//forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	//end
	
	/*
	initial begin
	end
	*/
endmodule