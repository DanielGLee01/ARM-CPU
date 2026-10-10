`default_nettype none

module alu_tb();
    import CPU_parameters::*;

    logic [DATA_WIDTH-1:0] a, b;
    logic [3:0] operation;
    logic [DATA_WIDTH-1:0] result;
    logic carry_flag, zero_flag, negative_flag, overflow_flag;

    alu dut (.a, .b, .operation, .result, .carry_flag, .zero_flag, .negative_flag, .overflow_flag);

    initial begin // add cases for flags
        a = 32'hFFFFFFFF; b = 32'h00000001; operation = 4'b0000; #100;
        assert (result === 32'h00000000)
        else $error("expected result is 32'h00000000, got %b instead", result); // carry flag is 1

        a = 32'hFFFFFFFF; b = 32'h00000001; operation = 4'b0001; #100;
        assert (result === 32'hFFFFFFFE)
        else $error("expected result is 32'hFFFFFFFE, got %b instead", result); // carry flag is 1

        a = 32'hAAAAAAAA; b = 32'h55555555; operation = 4'b0000; #100;
        assert (result === 32'hFFFFFFFF)
        else $error("expected result is 32'hFFFFFFFF, got %b instead", result); // carry flag is 1

        a = 32'hAAAAAAAA; b = 32'h55555555; operation = 4'b0001; #100;
        assert (result === 32'h55555555)
        else $error("expected result is 32'h55555555, got %b instead", result);

        a = 32'hBBBBBBBB; b = 32'h55555555; operation = 4'b0001; #100;
        assert (result === 32'h66666666)
        else $error("expected result is 32'h66666666, got %b instead", result);

        a = 32'h00000000; b = 32'h00000000; operation = 4'b0000; #100;
        assert (result === 32'h00000000)
        else $error("Expected result is 32'h00000000, got %b instead", result);

        a = 32'h00000000; b = 32'h00000000; operation = 4'b0001; #100;
        assert (result === 32'h00000000)
        else $error("Expected result is 32'h00000000, got %b instead", result);

        a = 32'h55555555; b = 32'hAAAAAAAA; operation = 4'b0001; #100; // find result - (32'hAAAAAAAB)

        a = 32'hAAAAAAAA; b = 32'h55555555; operation = 4'b0010; #100;
        assert (result === 32'h00000000)
        else $error("expected result is 32'h00000000, got %b instead", result);

        a = 32'hAAAAAAAA; b = 32'h55555555; operation = 4'b0011; #100;
        assert (result === 32'hFFFFFFFF)
        else $error("expected result is 32'hFFFFFFFF, got %b instead", result);

        a = 32'hAAAAAAAA; b = 32'hAAAAAAAA; operation = 4'b0100; #100;
        assert (result === 32'h00000000)
        else $error("expected result is 32'h00000000, got %b instead", result);
    end
endmodule
