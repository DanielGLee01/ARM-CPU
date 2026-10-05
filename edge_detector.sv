module edge_detector (clk, in, out);
	input logic clk, in;
	output logic out;
	
	logic stored_input;
	
	always_ff @(posedge clk) begin
		stored_input <= in;
	end
	
	always_comb begin
		if (in === 1 & stored_input === 0) begin
			out = 1;
		end else begin
			out = 0;
		end
	end
endmodule