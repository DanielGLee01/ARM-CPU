module control_unit import CPU_parameters::*; ();
	// operand 2 immediate/register select I/O
	input logic I_bit;
	input logic 
	
	output logic 
	// Chooses between register and immediate mode for Operand 2
	mux_2_to_1 oper_2_reg_imm (.a, .b, .s(I_bit), y)
	
endmodule