`default_nettype none

module register_rotator(operand_2, curr_carry, rotated_num, shifter_carry_out);
    input logic [11:0] operand_2;
    input logic curr_carry;

    logic [4:0] rotate_field;

    output logic [31:0] rotated_num;
    output logic shifter_carry_out;

    assign rotate_field = {operand_2[11:8], 1'b0}; // multiplies rotate field by 2

    always_comb begin
        rotated_num = operand_2[7:0]; // imm8 is loaded into rotated_num
        if (!rotate_field) begin
            shifter_carry_out = curr_carry;
        end
        else begin // (value >> N*2) | (value << (32-N*2))
            rotated_num = (rotated_num >> rotate_field) | (rotated_num << (32-rotate_field));
            shifter_carry_out = rotated_num[31];
        end
    end
endmodule
