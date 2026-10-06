`default_nettype none

module persistent_flags(clk, reset, step_en, c_flag_in, z_flag_in, n_flag_in, v_flag_in, wr_en, c_flag_out, z_flag_out, n_flag_out, v_flag_out);
	input logic clk, reset, step_en;
	input logic c_flag_in, z_flag_in, n_flag_in, v_flag_in;
	input logic wr_en; // S Bit
	
	output logic c_flag_out, z_flag_out, n_flag_out, v_flag_out;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			c_flag_out <= 0;
			z_flag_out <= 0;
			n_flag_out <= 0;
			v_flag_out <= 0;
		end else if (wr_en & step_en) begin
			c_flag_out <= c_flag_in;
			z_flag_out <= z_flag_in;
			n_flag_out <= n_flag_in;
			v_flag_out <= v_flag_in;
		end
	end
endmodule