`default_nettype none

module seg7_decoder (four_bit_num, segment_display);
	input logic [3:0] four_bit_num;
	output logic [6:0] segment_display;
	
	always_comb begin
		case (four_bit_num) // active low
			4'b0000: segment_display = 7'b1000000; // 0
         4'b0001: segment_display = 7'b1111001; // 1
			4'b0010: segment_display = 7'b0100100; // 2
			4'b0011: segment_display = 7'b0110000; // 3
			4'b0100: segment_display = 7'b0011001; // 4
			4'b0101: segment_display = 7'b0010010; // 5
			4'b0110: segment_display = 7'b0000010; // 6
			4'b0111: segment_display = 7'b1111000; // 7
			4'b1000: segment_display = 7'b0000000; // 8
			4'b1001: segment_display = 7'b0011000; // 9
			4'b1010: segment_display = 7'b0001000; // A
			4'b1011: segment_display = 7'b0000011; // B
			4'b1100: segment_display = 7'b1000110; // C
			4'b1101: segment_display = 7'b0100001; // D
			4'b1110: segment_display = 7'b0000110; // E
			4'b1111: segment_display = 7'b0001110; // F
		endcase
	end
endmodule