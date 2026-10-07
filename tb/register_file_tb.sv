`default_nettype none

module register_file_tb(); // add case for step_en
    import CPU_parameters::*;

    logic clk, reset;
    logic [3:0] read_register_A, read_register_B, fpga_display_addr_in;
    logic [3:0] write_addr;
    logic [DATA_WIDTH-1:0] write_data;
    logic write_en;

    logic step_en;

    logic [DATA_WIDTH-1:0] read_data_A, read_data_B, fpga_display_data;

    register_file dut (.clk, .reset, .read_register_A, .read_register_B, .fpga_display_addr_in,
                       .write_addr, .write_data, .write_en, .step_en, .read_data_A, .read_data_B,
                       .fpga_display_data);

    // Set up a simulated clock.
    parameter real CLOCK_PERIOD = 100;
    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
    end

    initial begin // add assert statements, add fpga_display_addr and fpga_display_data cases
        reset <= 0;                                                                 @(posedge clk);
                                                                                    @(posedge clk);
        reset <= 1;                                                                 @(posedge clk);
                                                                                    @(posedge clk);
        // write register A
        reset <= 0; write_en <= 1; write_addr <= 4'h6; write_data <= 32'h49BA731F;  @(posedge clk);
                                                                                    @(posedge clk);
        // make sure nothing is written when write_en is 0
        reset <= 0; write_en <= 0; write_addr <= 4'hB; write_data <= 32'h8AC2492C;  @(posedge clk);
                                                                                    @(posedge clk);
        // write register B
        reset <= 0; write_en <= 1; write_addr <= 4'hE; write_data <= 32'h9911C26D;  @(posedge clk);
                                                                                    @(posedge clk);
        // check registers for data
        read_register_A <= 4'h6; read_register_B <= 4'hE;                           @(posedge clk);
                                                                                    @(posedge clk);
        // Both should have no data
        read_register_A <= 4'hB; read_register_B <= 4'h0;                           @(posedge clk);
                                                                                    @(posedge clk);
        // all data should be erased
        reset <= 1;                                                                 @(posedge clk);
                                                                                    @(posedge clk);
        // check registers for data, should be reset now
        read_register_A <= 4'h6; read_register_B <= 4'hE;                           @(posedge clk);
                                                                                    @(posedge clk);
        write_en <= 1; write_addr <= 4'h4; write_data <= 32'h11111111;              @(posedge clk);
                                                                                    @(posedge clk);
        // what happens when reading and writing at the same time to the same address?
        read_register_A <= 4'h4; write_addr <= 4'h4; write_data <= 32'hFFFFFFFF;    @(posedge clk);
                                                                                    @(posedge clk);
        read_register_A <= 4'h4;                                                    @(posedge clk);
        $stop;
    end
endmodule
