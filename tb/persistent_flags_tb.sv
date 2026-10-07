`default_nettype none

module persistent_flags_tb(); // add case for step_en
    logic clk, reset, step_en;
    logic c_flag_in, z_flag_in, n_flag_in, v_flag_in;
    logic wr_en;

    logic c_flag_out, z_flag_out, n_flag_out, v_flag_out;

    persistent_flags dut (.clk, .reset, .step_en, .c_flag_in, .z_flag_in, .n_flag_in, .v_flag_in,
                          .wr_en, .c_flag_out, .z_flag_out, .n_flag_out, .v_flag_out);

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
        wr_en <= 1; c_flag_in <= 1; z_flag_in <= 1; n_flag_in <= 1; v_flag_in <= 1; @(posedge clk);
                                                                                    @(posedge clk);
        // flags should not be overwritten here
        wr_en <= 0; c_flag_in <= 0; z_flag_in <= 0; n_flag_in <= 0; v_flag_in <= 0; @(posedge clk);
                                                                                    @(posedge clk);
        wr_en <= 1; c_flag_in <= 0; z_flag_in <= 1; n_flag_in <= 0; v_flag_in <= 1; @(posedge clk);
                                                                                    @(posedge clk);
        $stop;
    end
endmodule
