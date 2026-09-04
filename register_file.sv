module register_file import CPU_parameters::*; (clk, reset, read_register_A, read_register_B, read_data_A, read_data_B, write_addr, write_data, write_en);
	input logic clk, reset;
	input logic [3:0] read_register_A, read_register_B; 
	input logic [3:0] write_addr;
	input logic [DATA_WIDTH-1:0] write_data;
	input logic write_en;
	
	output logic [DATA_WIDTH-1:0] read_data_A, read_data_B;
	
	logic [DATA_WIDTH-1:0] my_register [REG_COUNT-1:0];
	
	// write block
	always_ff @(posedge clk) begin
		if (reset) begin
			for (int i = 0; i < REG_COUNT; i++) begin
				my_register[i] <= 0;
			end
		end
		else if (write_en) begin
			my_register[write_addr] <= write_data; // Find which register to write to (according to write_addr) and write the data to it (write_data)
		end
	end
	
	// continuously check for data in register and assign read output
	// TODO: write this as mux and decoder for extra practice
	assign read_data_A = my_register[read_register_A];
	assign read_data_B = my_register[read_register_B];
endmodule

module register_file_testbench();
	import CPU_parameters::*;
	
	logic clk, reset;
	logic [3:0] read_register_A, read_register_B; 
	logic [3:0] write_addr;
	logic [DATA_WIDTH-1:0] write_data;
	logic write_en;
	
	logic [DATA_WIDTH-1:0] read_data_A, read_data_B;
	
	register_file dut (.clk, .reset, .read_register_A, .read_register_B, .read_data_A, .read_data_B, .write_addr, .write_data, .write_en);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin // add assert statements
		reset <= 0; 																				     @(posedge clk);
																										     @(posedge clk);
		reset <= 1; 																				     @(posedge clk);
																										     @(posedge clk);
		reset <= 0; write_en <= 1; write_addr <= 4'h6; write_data <= 32'h49BA731F;   @(posedge clk); // write register A
																										     @(posedge clk);
		reset <= 0; write_en <= 0; write_addr <= 4'hB; write_data <= 32'h8AC2492C;   @(posedge clk); // make sure nothing is written when write_en is 0																										 
																										     @(posedge clk);																										 
		reset <= 0; write_en <= 1; write_addr <= 4'hE; write_data <= 32'h9911C26D;   @(posedge clk); // write register B
																										     @(posedge clk);
		read_register_A <= 4'h6; read_register_B <= 4'hE;								     @(posedge clk); // check registers for data
																										     @(posedge clk);
		read_register_A <= 4'hB; read_register_B <= 4'h0;								     @(posedge clk); // Both should have no data
																										     @(posedge clk);
		reset <= 1; 																				     @(posedge clk); // all data should be erased
																										     @(posedge clk);
		read_register_A <= 4'h6; read_register_B <= 4'hE;								     @(posedge clk); // check registers for data, should be reset now
																										     @(posedge clk);
		write_en <= 1; write_addr <= 4'h4; write_data <= 32'h11111111;					  @(posedge clk);
																											  @(posedge clk);
		read_register_A <= 4'h4; write_addr <= 4'h4; write_data <= 32'hFFFFFFFF;     @(posedge clk); // what happens when reading and writing at the same time to the same address?
																											  @(posedge clk);
		read_register_A <= 4'h4;																	  @(posedge clk);																  
		$stop;
	end
endmodule