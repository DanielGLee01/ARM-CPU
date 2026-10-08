`default_nettype none

module control_unit_tb();
    import CPU_parameters::*;

    logic I_bit, S_bit;
    logic [DATA_WIDTH-1:0] imm_rotated_num, reg_data;
    logic [3:0] opcode_in;

    logic shifter_carry_out, ALU_carry_out;
    logic flags_wr_en;

    logic [DATA_WIDTH-1:0] oper_2_data;

    logic [3:0] ALU_opcode;
    logic reg_wr_en;
    logic selected_c_out;

    control_unit dut (.I_bit, .S_bit, .imm_rotated_num, .reg_data, .opcode_in, .shifter_carry_out,
                      .ALU_carry_out, .oper_2_data, .flags_wr_en, .ALU_opcode,
                      .reg_wr_en, .selected_c_out);

    initial begin
        // testing operand 2 imm/reg select
        // register data should be output here
        I_bit = 0; imm_rotated_num = 32'hFFFFFFFF; reg_data = 32'hCCCCCCCC; #100;
        // immediate data should be output here
        I_bit = 1; imm_rotated_num = 32'hFFFFFFFF; reg_data = 32'hCCCCCCCC; #100;

        // test data processing and carry out selection, make sure correct cases are being selected
        // SUB Test
        opcode_in = 4'b0010; S_bit = 1; ALU_carry_out = 0; shifter_carry_out = 1; #100;
        assert (ALU_opcode === 4'b0001)
            else $error("Test 1 failed, ALU_opcode mismatch: got %b expected 4'b0001", ALU_opcode);
        assert (reg_wr_en === 1)
            else $error("Test 1 failed, reg_wr_en mismatch: got %b expected 1", reg_wr_en);
        assert (flags_wr_en === 1)
            else $error("Test 1 failed, flags_wr_en mismatch: got %b expected 1", flags_wr_en);
        assert (selected_c_out === 0)
            else $error("Test 1 failed, selected_c_out returned %b expected 0", selected_c_out);

        // CMP Test
        opcode_in = 4'b1010; S_bit = 0; ALU_carry_out = 1; shifter_carry_out = 0; #100;
        assert (ALU_opcode === 4'b0001)
            else $error("Test 2 failed, ALU_opcode mismatch: got %b expected 4'b0001", ALU_opcode);
        assert (reg_wr_en === 0)
            else $error("Test 2 failed, reg_wr_en mismatch: got %b expected 1", reg_wr_en);
        assert (flags_wr_en === 0)
            else $error("Test 2 failed, flags_wr_en mismatch: got %b expected 0", flags_wr_en);
        assert (selected_c_out === 1)
            else $error("Test 2 failed, selected_c_out returned %b expected 1", selected_c_out);

        // TST Test
        opcode_in = 4'b1000; S_bit = 0; ALU_carry_out = 0; shifter_carry_out = 1; #100;
        assert (ALU_opcode === 4'b0010)
            else $error("Test 3 failed, ALU_opcode mismatch: got %b expected 4'b0001", ALU_opcode);
        assert (reg_wr_en === 0)
            else $error("Test 3 failed, reg_wr_en mismatch: got %b expected 0", reg_wr_en);
        assert (flags_wr_en === 0)
            else $error("Test 3 failed, flags_wr_en mismatch: got %b expected 0", flags_wr_en);
        assert (selected_c_out === 1)
            else $error("Test 3 failed, selected_c_out returned %b expected 1", selected_c_out);

        // Testing SBC (unimplemented)
        opcode_in = 4'b0110; S_bit = 1; ALU_carry_out = 1; shifter_carry_out = 0; #100;
        assert (ALU_opcode === 4'b0001)
            else $error("Test 4 failed, ALU_opcode mismatch: got %b expected 4'b0001", ALU_opcode);
        assert (reg_wr_en === 0)
            else $error("Test 4 failed, reg_wr_en mismatch: got %b expected 1", reg_wr_en);
        assert (flags_wr_en === 0)
            else $error("Test 4 failed, flags_wr_en mismatch: got %b expected 1", flags_wr_en);
        assert (selected_c_out === 1)
            else $error("Test 4 failed, selected_c_out returned %b expected 1", selected_c_out);
    end
endmodule
