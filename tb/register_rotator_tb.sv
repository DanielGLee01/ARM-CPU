`default_nettype none

module register_rotator_tb();
    logic [11:0] operand_2;
    logic curr_carry;

    logic [31:0] rotated_num;
    logic shifter_carry_out;

    register_rotator dut (.operand_2, .curr_carry, .rotated_num, .shifter_carry_out);

    initial begin
        operand_2 = 12'b011101011010; curr_carry = 0; #100;
        assert (shifter_carry_out === 0 && rotated_num === 32'b00000001011010000000000000000000)
        else $error("Test 1 failed, rotated_num and carry_out mismatch:",
                    "got carry=%b and rotated_num=%b", shifter_carry_out, rotated_num);
        // check for zero rotate logic
        operand_2 = 12'b000011011010; curr_carry = 0; #100;
        assert (shifter_carry_out === 0 && rotated_num === 32'b00000000000000000000000011011010)
        else $error("Test 2 failed, rotated_num and carry_out mismatch:",
                    "got carry=%b and rotated_num=%b", shifter_carry_out, rotated_num);
        operand_2 = 12'b000011111111; curr_carry = 1; #100;
        assert (shifter_carry_out === 1 && rotated_num === 32'b00000000000000000000000011111111)
        else $error("Test 3 failed, rotated_num and carry_out mismatch:",
                     "got carry=%b and rotated_num=%b", shifter_carry_out, rotated_num);
        // check non-zero rotate and curr_carry true are being correctly used
        operand_2 = 12'hCFF; curr_carry = 1; #100;
        assert (shifter_carry_out === 0 && rotated_num === 32'b00000000000000001111111100000000)
        else $error("Test 4 failed, rotated_num and carry_out mismatch:",
                     "got carry=%b and rotated_num=%b", shifter_carry_out, rotated_num);
        operand_2 = 12'h103; curr_carry = 1; #100;
        assert (shifter_carry_out === 1 && rotated_num === 32'b11000000000000000000000000000000)
        else $error("Test 5 failed, rotated_num and carry_out mismatch:",
                    "got carry=%b and rotated_num=%b", shifter_carry_out, rotated_num);
    end
endmodule
