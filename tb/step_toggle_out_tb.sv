`default_nettype none

module step_toggle_out_tb();
    logic clk, reset, key_input;
    logic led_output;

    step_toggle_out dut (.clk, .reset, .key_input, .led_output);

    // Set up a simulated clock.
    parameter real CLOCK_PERIOD=100;
    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
    end

    initial begin
        reset <= 1;                                                                 @(posedge clk);
                                                                                    @(posedge clk);
        reset <= 0;                                                                 @(posedge clk);
                                                                                    @(posedge clk);
        assert (led_output === 0)
        else $error("input is 0, stored is 0, so output should be 0 but is %b", led_output);
        key_input <= 1;                                                             @(posedge clk);
        #1; assert (led_output === 1)
        else $error("input is 1, stored is 0, so output should be 1 but is %b", led_output);
                                                                                    @(posedge clk);
        assert (led_output === 0)
        else $error("input is 1, stored is 1, so output should be 0 but is %b", led_output);
        key_input <= 0;                                                             @(posedge clk);
        assert (led_output === 1)
        else $error("input is 0, stored is 1, so output should be 1 but is %b", led_output);
                                                                                    @(posedge clk);
        $stop;
    end
endmodule
