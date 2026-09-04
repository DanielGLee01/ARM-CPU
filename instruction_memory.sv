module instruction_memory import CPU_parameters::*; (addr_in, instr_out);
	input logic [8:0] addr_in;
	output logic [DATA_WIDTH-1:0] instr_out;
	
	logic [DATA_WIDTH-1:0] memory_array [0:511];
	
	// loads contents of instruction memory into memory array
	initial begin
		$readmemh("instruction_memory.hex", memory_array);
	end
	
	assign instr_out = memory_array[addr_in];
endmodule

module instruction_memory_testbench();
	import CPU_parameters::*;
	
	logic [8:0] addr_in;
	logic [DATA_WIDTH-1:0] instr_out;
	
	instruction_memory dut (.addr_in, .instr_out);
	
	initial begin // Add assert statements here
		addr_in = 9'h000; #100;
		addr_in = 9'h008; #100;
		addr_in = 9'h010; #100;
	end
endmodule