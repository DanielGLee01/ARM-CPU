`default_nettype none

module alu import CPU_parameters::*; (a, b, operation, result, carry_flag,
                                      zero_flag, negative_flag, overflow_flag);
    input logic [DATA_WIDTH-1:0] a, b;
    input logic [3:0] operation;
    output logic [DATA_WIDTH-1:0] result;
    output logic carry_flag, zero_flag, negative_flag, overflow_flag;

    logic cin, cout;
    logic [DATA_WIDTH-1:0] b_xored, arithmetic_result;
    logic add_or_sub_sig;

    always_comb begin
        case(operation)
            4'b0000: begin // addition operation
                cin = 0;
                add_or_sub_sig = 0;
                result = arithmetic_result;
                carry_flag = cout;
                overflow_flag = (a[31] & b[31] & ~arithmetic_result[31]) ||
                                (~a[31] & ~b[31] & arithmetic_result[31]);
            end
            4'b0001: begin // subtraction operation
                cin = 1;
                add_or_sub_sig = 1;
                result = arithmetic_result;
                carry_flag = cout;
                overflow_flag = (a[31] & ~b[31] & ~arithmetic_result[31]) ||
                                (~a[31] & b[31] & arithmetic_result[31]);
            end
            4'b0010: begin // bitwise AND
                result = a & b;
            end
            4'b0011: begin // bitwise OR
                result = a | b;
            end
            4'b0100: begin // bitwise XOR
                result = a ^ b;
            end
            4'b0101: begin // reserved
            end
            4'b0110: begin // reserved
            end
            4'b0111: begin // reserved
            end
            4'b1000: begin // reserved
            end
            4'b1001: begin // reserved
            end
            4'b1010: begin // reserved
            end
            4'b1011: begin // reserved
            end
            4'b1100: begin // reserved
            end
            4'b1101: begin // reserved
            end
            4'b1110: begin // reserved
            end
            4'b1111: begin // reserved
            end
            default: begin
                result = 0;
                carry_flag = 0;
                overflow_flag = 0;
                cin = 0;
                add_or_sub_sig = 0;
            end
        endcase
    end

    assign b_xored = b ^ {32{add_or_sub_sig}};

    add32 add_or_subtract (.a, .b(b_xored), .cin, .sum(arithmetic_result), .cout);

    assign zero_flag = (result == 0);
    assign negative_flag = result[31];
endmodule
