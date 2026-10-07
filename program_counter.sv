`default_nettype none

module program_counter import CPU_parameters::*; (clk, reset, enable, PC_value);
    input logic clk, reset, enable;
    output logic [PC_WIDTH-1:0] PC_value;

    always_ff @(posedge clk) begin
        if (reset) begin
            PC_value <= 0;
        end
        else if (enable) begin
            PC_value <= PC_value + 11'd4;
        end
    end
endmodule
