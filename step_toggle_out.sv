module step_toggle_out (clk, reset, key_input, led_output);
	input logic clk, reset, key_input;
	output logic led_output;
	
	logic store_press;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			store_press <= 0;
		end else begin
			store_press <= key_input;
		end
	end
	
	assign led_output = store_press ^ key_input;
	
endmodule