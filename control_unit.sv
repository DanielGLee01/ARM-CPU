module control_unit import CPU_parameters::*; (I_bit, S_bit, imm_rotated_num, reg_data, opcode_in, shifter_carry_out, ALU_carry_out, oper_2_data, flags_wr_en, ALU_opcode, reg_wr_en, log_arith, selected_c_out);
	// operand 2 immediate/register select I/O
	input logic I_bit, S_bit; // connect S_bit to decoder in top level
	input logic [DATA_WIDTH-1:0] imm_rotated_num, reg_data; // imm_rotated_num will come from register_rotator, and reg_data will come from register_file
	input logic [3:0] opcode_in; // Needs to be passed in from instruction from decoder
	
	input logic shifter_carry_out, ALU_carry_out; // Pass in from shifter and ALU respectively
	
	output logic [DATA_WIDTH-1:0] oper_2_data;
	output logic flags_wr_en; // this needs to be connected to persistent_flags
	
	output logic [3:0] ALU_opcode; // goes to ALU for operation
	output logic reg_wr_en, log_arith;
	output logic selected_c_out;
	
	logic implemented; // safety bit so no flag overwrite, for unimplemented data processing operations
	
	// Chooses between register and immediate mode for Operand 2
	mux_2_to_1 oper_2_reg_imm (.a(imm_rotated_num), .b(reg_data), .s(I_bit), .y(oper_2_data));
	
	// Pass S bit through to flags_wr_en
	assign flags_wr_en = S_bit & implemented;
	
	// ARM Data Processing Instructions
	always_comb begin
		ALU_opcode = 4'b1111;
		reg_wr_en = 0;
		log_arith = 0; // 0 = logical, 1 = arithmetic
		implemented = 0;
		case (opcode_in)
			4'b0000: begin // AND
				ALU_opcode = 4'b0010;
				reg_wr_en = 1;
				log_arith = 0;
				implemented = 1;
			end
			4'b0001: begin // EOR
				ALU_opcode = 4'b0100;
				reg_wr_en = 1;
				log_arith = 0;
				implemented = 1;
			end
			4'b0010: begin // SUB
				ALU_opcode = 4'b0001;
				reg_wr_en = 1;
				log_arith = 1;
				implemented = 1;
			end
			4'b0011: begin // RSB
				// op2 - Rn neds to be implemented
				ALU_opcode = 4'b0001;
				reg_wr_en = 0; // change once fixed
				log_arith = 1;
				implemented = 0; // change once fixed
			end
			4'b0100: begin // ADD
				ALU_opcode = 4'b0000;
				reg_wr_en = 1;
				log_arith = 1;
				implemented = 1;
			end
			4'b0101: begin // ADC
				// Cin needed
				ALU_opcode = 4'b0000;
				reg_wr_en = 0; // change once fixed
				log_arith = 1;
				implemented = 0; // change once fixed
			end
			4'b0110: begin // SBC
				// Cin needed
				ALU_opcode = 4'b0001;
				reg_wr_en = 0; // change once fixed
				log_arith = 1;
				implemented = 0; // change once fixed 
			end
			4'b0111: begin // RSC
				// Cin needed
				ALU_opcode = 4'b0001;
				reg_wr_en = 0; // change once fixed
				log_arith = 1;
				implemented = 0; // change once fixed
			end
			4'b1000: begin // TST
				ALU_opcode = 4'b0010;
				reg_wr_en = 0;
				log_arith = 0;
				implemented = 1;
			end
			4'b1001: begin // TEQ
				ALU_opcode = 4'b0100;
				reg_wr_en = 0;
				log_arith = 0;
				implemented = 1;
			end
			4'b1010: begin // CMP
				ALU_opcode = 4'b0001;
				reg_wr_en = 0;
				log_arith = 1;
				implemented = 1;
			end
			4'b1011: begin // CMN
				ALU_opcode = 4'b0000;
				reg_wr_en = 0;
				log_arith = 1;
				implemented = 1;
			end
			4'b1100: begin // ORR
				ALU_opcode = 4'b0011;
				reg_wr_en = 1;
				log_arith = 0;
				implemented = 1;
			end
			4'b1101: begin // MOV
			end
			4'b1110: begin // BIC
			end
			4'b1111: begin // MVN
			end
		endcase		
	end
	
	mux_2_to_1 #(.WIDTH(1)) sel_carry_out (.a(ALU_carry_out), .b(shifter_carry_out), .s(log_arith), .y(selected_c_out));
	
endmodule

module control_unit_testbench(); // TODO: Write Testbench
	import CPU_parameters::*;
	
	logic I_bit, S_bit;
	logic [DATA_WIDTH-1:0] imm_rotated_num, reg_data;
	logic [3:0] opcode_in;
	
	logic shifter_carry_out, ALU_carry_out;
	logic flags_wr_en;
	
	logic [DATA_WIDTH-1:0] oper_2_data;
	
	logic [3:0] ALU_opcode;
	logic reg_wr_en, log_arith;
	logic selected_c_out;
	
	control_unit dut (.I_bit, .S_bit, .imm_rotated_num, .reg_data, .opcode_in, .shifter_carry_out, .ALU_carry_out, .oper_2_data, .flags_wr_en, .ALU_opcode, .reg_wr_en, .log_arith, .selected_c_out);
	
	initial begin 
		// testing operand 2 imm/reg select
		I_bit = 0; imm_rotated_num = 32'hFFFFFFFF; reg_data = 32'hCCCCCCCC; #100; // register data should be output here
		I_bit = 1; imm_rotated_num = 32'hFFFFFFFF; reg_data = 32'hCCCCCCCC; #100; // immediate data should be output here
	end
endmodule