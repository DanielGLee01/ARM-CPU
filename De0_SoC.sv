module De0_SoC import CPU_parameters::*; (clk, reset);
	input logic clk, reset;
	
	logic [PC_WIDTH-1:0] PC_value;
	logic [DATA_WIDTH-1:0] instruction;
	
	logic [3:0] condition, opcode, Rn, Rd;
	logic [1:0] class_identifier;
	logic I_bit, S_bit;
	logic [11:0] operand_2;
	
	logic shifter_carry_out, ALU_carry_out;
	
	logic c_flag, z_flag, n_flag, v_flag;
	logic flags_wr_en;

	// wiring modules for fetch stage
	program_counter PC_start (.clk, .reset, .PC_value); // done
	instruction_memory instr_memory_start (.addr_in(PC_value[10:2]), .instr_out(instruction)); // done
	
	// wiring modules for decode/writeback stage
	decoder decode_instr (.instr_in(instruction), .condition, .opcode, .Rn, .Rd, .class_identifier, .I_bit, .S_bit, .operand_2); // done
	register_file read_reg (.clk, .reset, .read_register_A(Rn), .read_register_B(operand_2[3:0]), .write_addr(/*do*/), .write_data(/*do*/), .write_en(/*do*/), .read_data_A(/*do*/), .read_data_B(/*do*/));
	register_rotator rotate_operand2 (.operand_2, .curr_carry(/*do*/), .rotated_num(/*do*/), .shifter_carry_out(/*do*/));
	control_unit control (.I_bit, .S_bit, .imm_rotated_num(rotated_num), .reg_data(/*do*/), .opcode_in(opcode), .shifter_carry_out, .ALU_carry_out, .oper_2_data(/*do*/), .flags_wr_en, .ALU_opcode(/*do*/), .reg_wr_en(/*do*/), .log_arith(/*do*/), .selected_c_out(/*do*/));
	
	// wiring modules for execute stage
	alu begin_op (.a(/*do*/), .b(/*do*/), .operation(/*do*/), .result(/*do*/), .carry_flag(c_flag), .zero_flag(z_flag), .negative_flag(n_flag), .overflow_flag(v_flag));
	
	// wiring for writeback to flags
	persistent_flags update_flags (.clk, .reset, .c_flag_in(c_flag), .z_flag_in(z_flag), .n_flag_in(n_flag), .v_flag_in(v_flag), .wr_en(flags_wr_en), .c_flag_out(/*do*/), .z_flag_out(/*do*/), .n_flag_out(/*do*/), .v_flag_out(/*do*/));
endmodule

module De0_SoC_testbench();
	import CPU_parameters::*;
	
	logic clk, reset;
	
	De0_SoC dut (.clk, .reset);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
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
																										     @(posedge clk);
																										     @(posedge clk);
																										     @(posedge clk);
	end
endmodule