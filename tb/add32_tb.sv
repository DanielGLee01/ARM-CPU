`default_nettype none

module add32_tb();
    import CPU_parameters::*;

    logic [DATA_WIDTH-1:0] a, b, sum;
    logic cin, cout;

    add32 dut (.a, .b, .cin, .sum, .cout);

    initial begin
        a = 32'hFFFFFFFF; b = 32'h00000001; cin = 0; #10;
        a = 32'hAAAAAAAA; b = 32'h55555555; cin = 0; #10;
    end
endmodule
