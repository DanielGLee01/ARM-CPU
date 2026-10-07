module program_counter_tb();
    import CPU_parameters::*;

    logic clk, reset, enable;
    logic [PC_WIDTH-1:0] PC_value;

    program_counter dut (.clk, .reset, .enable, .PC_value);

    // Set up a simulated clock.
    parameter real CLOCK_PERIOD = 100;
    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
    end

    initial begin
        reset <= 0;                                                                 @(posedge clk);
                                                                                    @(posedge clk);
        reset <= 1;                                                                 @(posedge clk);
                                                                                    @(posedge clk);
        reset <= 0;                                                                 @(posedge clk);
                                                                                    @(posedge clk);
        reset <= 1;                                                                 @(posedge clk);
                                                                                    @(posedge clk);
        reset <= 0;                                                                 @(posedge clk);
        // PC counter will keep incrementing by 4 unless reset
                                                                                    @(posedge clk);
                                                                                    @(posedge clk);
                                                                                    @(posedge clk);
                                                                                    @(posedge clk);
        $stop;
    end
endmodule
