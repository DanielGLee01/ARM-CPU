`default_nettype none

module double_ff_tb();
    logic clk, in, out;

    double_ff dut (.clk, .in, .out);

    // Set up a simulated clock.
    parameter real CLOCK_PERIOD=100;
    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
    end

    initial begin
        in <= 0;                                                                    @(posedge clk);
                                                                                    @(posedge clk);
                                                                                    @(posedge clk);
        #1; assert (out === 0) else $error("double_ff not started correctly, output is %b", out);
        in <= 1;                                                                    @(posedge clk);
                                                                                    @(posedge clk);
                                                                                    @(posedge clk);
        #1; assert (out === 1) else $error("double_ff not started correctly, output is %b", out);
        in <= 0;                                                                    @(posedge clk);
                                                                                    @(posedge clk);
                                                                                    @(posedge clk);
        #1; assert (out === 0) else $error("double_ff not started correctly, output is %b", out);
        $stop;
    end
endmodule
