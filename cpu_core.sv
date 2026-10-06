`default_nettype none

module cpu_core import CPU_parameters::*; (clk, reset, step_en, fpga_display_addr_in, fpga_display_data, fpga_display_instr);	
	input logic clk, reset, step_en;
	
	input logic [3:0] fpga_display_addr_in;
	output logic [DATA_WIDTH-1:0] fpga_display_data, fpga_display_instr;
	
	logic [PC_WIDTH-1:0] PC_value;
	logic [DATA_WIDTH-1:0] instruction;
	logic [DATA_WIDTH-1:0] rn_data, rm_data, op2_value;
	
	logic [3:0] condition, opcode, Rn, Rd;
	logic [1:0] class_identifier;
	logic I_bit, S_bit;
	logic [11:0] operand_2;
	
	logic shifter_carry_out; // First produced from rotator module, gets fed into control unit's mux
	
	logic alu_c_flag, alu_z_flag, alu_n_flag, alu_v_flag;
	logic flags_wr_en;
	
	logic mux_selected_carry, c_stored;
	
	logic [3:0] ALU_opcode;
	
	logic [DATA_WIDTH-1:0] rotated_num;
	logic [DATA_WIDTH-1:0] ALU_result;
	
	logic reg_wr_en;
	
	// This is currently unused, because no modules utilize these flags yet
	logic z_stored, n_stored, v_stored;

	// wiring modules for fetch stage
	program_counter pc (.clk, .reset, .enable(step_en), .PC_value);
	instruction_memory imem (.addr_in(PC_value[PC_WIDTH-1:2]), .instr_out(instruction), .fpga_display_instr);
	
	// wiring modules for decode/writeback stage
	decoder dec (.instr_in(instruction), .condition, .opcode, .Rn, .Rd, .class_identifier, .I_bit, .S_bit, .operand_2);
	register_file reg_file (.clk, .reset, .read_register_A(Rn), .read_register_B(operand_2[3:0]), .fpga_display_addr_in, .write_addr(Rd), .write_data(ALU_result), .write_en(reg_wr_en), .step_en, .read_data_A(rn_data), .read_data_B(rm_data), .fpga_display_data);
	register_rotator rotator (.operand_2, .curr_carry(c_stored), .rotated_num, .shifter_carry_out);
	control_unit control (.I_bit, .S_bit, .imm_rotated_num(rotated_num), .reg_data(rm_data), .opcode_in(opcode), .shifter_carry_out, .ALU_carry_out(alu_c_flag), .oper_2_data(op2_value), .flags_wr_en, .ALU_opcode, .reg_wr_en, .selected_c_out(mux_selected_carry));
	
	// wiring modules for execute stage
	alu alu_inst (.a(rn_data), .b(op2_value), .operation(ALU_opcode), .result(ALU_result), .carry_flag(alu_c_flag), .zero_flag(alu_z_flag), .negative_flag(alu_n_flag), .overflow_flag(alu_v_flag));
	
	// wiring for writeback to flags
	persistent_flags flags (.clk, .reset, .step_en, .c_flag_in(mux_selected_carry), .z_flag_in(alu_z_flag), .n_flag_in(alu_n_flag), .v_flag_in(alu_v_flag), .wr_en(flags_wr_en), .c_flag_out(c_stored), .z_flag_out(z_stored), .n_flag_out(n_stored), .v_flag_out(v_stored));
endmodule