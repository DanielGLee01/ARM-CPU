`default_nettype none

module instruction_memory import CPU_parameters::*; (addr_in, instr_out, fpga_display_instr);
    input logic [8:0] addr_in;
    output logic [DATA_WIDTH-1:0] instr_out, fpga_display_instr;

    logic [DATA_WIDTH-1:0] memory_array [512];

    // loads contents of instruction memory into memory array
    initial begin
        $readmemh("instruction_memory.hex", memory_array);
    end

    assign instr_out = memory_array[addr_in];
    assign fpga_display_instr = memory_array[addr_in];
endmodule

