`default_nettype none

module De0_SoC import CPU_parameters::*; (CLOCK_50, KEY, SW, HEX0, HEX1,
                                          HEX2, HEX3, HEX4, HEX5, LEDR);
    input logic CLOCK_50;
    input logic [3:0] KEY;
    input logic [9:0] SW;

    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    output logic [9:0] LEDR;

    logic [DATA_WIDTH-1:0] fpga_display_data, fpga_display_instr;
    logic [15:0] halfed_bits_data, halfed_bits_instr, halfed_bits;

    logic step_sync, step_pulse, reset_sync, toggle_led;

    // Turn off HEX displays and LEDS
    assign HEX4 = 7'b1111111;
    assign LEDR = {toggle_led, 9'b000000000};

    // Adds a counter to HEX5, showing which register is selected (may remove later)
    logic [6:0] reg_num;

    seg7_decoder track_reg_num (.four_bit_num(SW[3:0]), .segment_display(reg_num));
    mux_2_to_1 #(.WIDTH(7)) display_reg_num (.a(7'b1111111), .b(reg_num), .s(SW[5]), .y(HEX5));

    // Turns KEY3 into a step button, to advance instructions with one press
    double_ff key3_sync (.clk(CLOCK_50), .in(~KEY[3]), .out(step_sync));
    edge_detector key3_detect (.clk(CLOCK_50), .in(step_sync), .out(step_pulse));

    // Turns KEY0 into a reset button
    double_ff key0 (.clk(CLOCK_50), .in(~KEY[0]), .out(reset_sync));

    // Assign LEDR[9] to reflect a toggle between instructions
    step_toggle_out start_toggle_led (.clk(CLOCK_50), .reset(reset_sync), .key_input(step_pulse),
                                      .led_output(toggle_led));

    // Allows for display of either register or instructions
    mux_2_to_1 #(.WIDTH(16)) display_data_fpga (.a(fpga_display_data[31:16]),
                                                .b(fpga_display_data[15:0]), .s(SW[4]),
                                                .y(halfed_bits_data));
    mux_2_to_1 #(.WIDTH(16)) display_instr_fpga (.a(fpga_display_instr[31:16]),
                                                 .b(fpga_display_instr[15:0]), .s(SW[4]),
                                                 .y(halfed_bits_instr));
    mux_2_to_1 #(.WIDTH(16)) instr_or_data (.a(halfed_bits_instr), .b(halfed_bits_data), .s(SW[5]),
                                            .y(halfed_bits));

    // CPU Start
    cpu_core cpu_start (.clk(CLOCK_50), .reset(reset_sync), .step_en(step_pulse),
                        .fpga_display_addr_in(SW[3:0]), .fpga_display_data, .fpga_display_instr);

    // Splits halfed bits into 4 groups for 4 different hex lights
    seg7_decoder hex3_data (.four_bit_num(halfed_bits[15:12]), .segment_display(HEX3));
    seg7_decoder hex2_data (.four_bit_num(halfed_bits[11:8]), .segment_display(HEX2));
    seg7_decoder hex1_data (.four_bit_num(halfed_bits[7:4]), .segment_display(HEX1));
    seg7_decoder hex0_data (.four_bit_num(halfed_bits[3:0]), .segment_display(HEX0));
endmodule
