module decoder import CPU_parameters::*; (instr_in, condition, opcode, Rn, Rd, class_identifier, I_bit, S_bit, operand_2);
	input logic [DATA_WIDTH-1:0] instr_in;
	
	output logic [3:0] condition, opcode, Rn, Rd;
	output logic [1:0] class_identifier;
	output logic I_bit, S_bit;
	output logic [11:0] operand_2;
	
	assign condition = instr_in[31:28];
	assign class_identifier = instr_in[27:26];
	assign I_bit = instr_in[25];
	assign opcode = instr_in[24:21];
	assign S_bit = instr_in[20];
	assign Rn = instr_in[19:16];
	assign Rd = instr_in[15:12];
	assign operand_2 = instr_in[11:0];
endmodule

module decoder_testbench();
	import CPU_parameters::*;
	
	logic [DATA_WIDTH-1:0] instr_in;
	
	logic [3:0] condition, opcode, Rn, Rd;
	logic [1:0] class_identifier;
	logic I_bit, S_bit;
	logic [11:0] operand_2;
	
	decoder dut (.instr_in, .condition, .opcode, .Rn, .Rd, .class_identifier, .I_bit, .S_bit, .operand_2);
	
	initial begin // number is in binary for easier visibility - TODO: Add assert here
		instr_in = 32'b11110011001011100001010110100011; #100; // 1111 00 1 1001 0 1110 0001 010110100011
	end
endmodule