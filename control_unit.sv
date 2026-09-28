module control_unit import CPU_parameters::*; (I_bit, imm_rotated_num, reg_data, oper_2_data);
	// operand 2 immediate/register select I/O
	input logic I_bit;
	input logic [DATA_WIDTH-1:0] imm_rotated_num, reg_data; // imm_rotated_num will come from register_rotator, and reg_data will come from register_file
	output logic [DATA_WIDTH-1:0] oper_2_data;
	
	// Chooses between register and immediate mode for Operand 2
	mux_2_to_1 oper_2_reg_imm (.a(imm_rotated_num), .b(reg_data), .s(I_bit), .y(oper_2_data));
endmodule

module control_unit_testbench();
	import CPU_parameters::*;
	
	logic I_bit;
	logic [DATA_WIDTH-1:0] imm_rotated_num, reg_data;
	logic [DATA_WIDTH-1:0] oper_2_data;
	
	control_unit dut (.I_bit, .imm_rotated_num, .reg_data, .oper_2_data);
	
	initial begin 
		// testing operand 2 imm/reg select
		I_bit = 0; imm_rotated_num = 32'hFFFFFFFF; reg_data = 32'hCCCCCCCC; #100; // register data should be output here
		I_bit = 1; imm_rotated_num = 32'hFFFFFFFF; reg_data = 32'hCCCCCCCC; #100; // immediate data should be output here
	end
endmodule