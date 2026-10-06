`default_nettype none

module edge_detector (clk, in, out);
	input logic clk, in;
	output logic out;
	
	logic stored_input;
	
	always_ff @(posedge clk) begin
		stored_input <= in;
	end
	
	assign out = in & ~stored_input;
endmodule