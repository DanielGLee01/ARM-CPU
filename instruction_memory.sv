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
	
	initial begin
		addr_in = 9'h000; #100;
		assert (instr_out === 32'hE290100F) else $error("data mismatch: got %b, expected E290100F", instr_out);
		addr_in = 9'h003; #100;
		assert (instr_out === 32'hE29AC31B) else $error("data mismatch: got %b, expected E29AC31B", instr_out);
		addr_in = 9'h005; #100;
		assert (instr_out === 32'hE1510001) else $error("data mismatch: got %b, expected E1510001", instr_out);
	end
endmodule