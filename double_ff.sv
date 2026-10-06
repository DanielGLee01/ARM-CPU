`default_nettype none

module double_ff (clk, in, out);
	input logic clk, in;
	output logic out;
	
	logic passthrough;
	
	always_ff @(posedge clk) begin
		passthrough <= in;
		out <= passthrough;
	end
endmodule