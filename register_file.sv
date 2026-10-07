`default_nettype none

module register_file import CPU_parameters::*; (clk, reset, read_register_A, read_register_B,
                                                fpga_display_addr_in, write_addr, write_data,
                                                write_en, step_en, read_data_A, read_data_B,
                                                fpga_display_data);
    input logic clk, reset;
    input logic [3:0] read_register_A, read_register_B, fpga_display_addr_in;
    input logic [3:0] write_addr;
    input logic [DATA_WIDTH-1:0] write_data;
    input logic write_en;

    input logic step_en;

    output logic [DATA_WIDTH-1:0] read_data_A, read_data_B, fpga_display_data;

    logic [DATA_WIDTH-1:0] my_register [REG_COUNT]; // REG_COUNT-1:0

    // write block
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < REG_COUNT; i++) begin
                my_register[i] <= 0;
            end
        end
        else if (write_en & step_en) begin
            // Find which register to write to (according to write_addr) and write the data to it (write_data)
            my_register[write_addr] <= write_data;
        end
    end

    // continuously check for data in register and assign read output
    assign read_data_A = my_register[read_register_A];
    assign read_data_B = my_register[read_register_B];
    assign fpga_display_data = my_register[fpga_display_addr_in];
endmodule
