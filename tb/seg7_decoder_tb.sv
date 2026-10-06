`default_nettype none

module seg7_decoder_tb();
	logic [3:0] four_bit_num;
	logic [6:0] segment_display;
	
	seg7_decoder dut (.four_bit_num, .segment_display);
	
	initial begin
		four_bit_num = 4'b0000; #100;
		assert (segment_display === 7'b1000000) else $error("0 not coded correctly, got %b expecting 7'b1000000", segment_display);
		four_bit_num = 4'b0001; #100;
		assert (segment_display === 7'b1111001) else $error("1 not coded correctly, got %b expecting 7'b1111001", segment_display);
		four_bit_num = 4'b0010; #100;
		assert (segment_display === 7'b0100100) else $error("2 not coded correctly, got %b expecting 7'b0100100", segment_display);
		four_bit_num = 4'b0011; #100;
		assert (segment_display === 7'b0110000) else $error("3 not coded correctly, got %b expecting 7'b0110000", segment_display);
		four_bit_num = 4'b0100; #100;
		assert (segment_display === 7'b0011001) else $error("4 not coded correctly, got %b expecting 7'b0011001", segment_display);
		four_bit_num = 4'b0101; #100;
		assert (segment_display === 7'b0010010) else $error("5 not coded correctly, got %b expecting 7'b0010010", segment_display);
		four_bit_num = 4'b0110; #100;
		assert (segment_display === 7'b0000010) else $error("6 not coded correctly, got %b expecting 7'b0000010", segment_display);
		four_bit_num = 4'b0111; #100;
		assert (segment_display === 7'b1111000) else $error("7 not coded correctly, got %b expecting 7'b1111000", segment_display);
		four_bit_num = 4'b1000; #100;
		assert (segment_display === 7'b0000000) else $error("8 not coded correctly, got %b expecting 7'b0000000", segment_display);
		four_bit_num = 4'b1001; #100;
		assert (segment_display === 7'b0011000) else $error("9 not coded correctly, got %b expecting 7'b0011000", segment_display);
		four_bit_num = 4'b1010; #100;
		assert (segment_display === 7'b0001000) else $error("A not coded correctly, got %b expecting 7'b0001000", segment_display);
		four_bit_num = 4'b1011; #100;
		assert (segment_display === 7'b0000011) else $error("B not coded correctly, got %b expecting 7'b0000011", segment_display);
		four_bit_num = 4'b1100; #100;
		assert (segment_display === 7'b1000110) else $error("C not coded correctly, got %b expecting 7'b1000110", segment_display);
		four_bit_num = 4'b1101; #100;
		assert (segment_display === 7'b0100001) else $error("D not coded correctly, got %b expecting 7'b0100001", segment_display);
		four_bit_num = 4'b1110; #100;
		assert (segment_display === 7'b0000110) else $error("E not coded correctly, got %b expecting 7'b0000110", segment_display);
		four_bit_num = 4'b1111; #100;
		assert (segment_display === 7'b0001110) else $error("F not coded correctly, got %b expecting 7'b0001110", segment_display);
	end
endmodule

