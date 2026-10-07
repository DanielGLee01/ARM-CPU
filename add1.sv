`default_nettype none

// 1 bit full adder
module add1(a, b, cin, sum, cout);
    input logic a, b, cin;
    output logic sum, cout;

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule
