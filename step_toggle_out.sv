module step_toggle_out (clk, reset, key_input, led_output);
    input logic clk, reset, key_input;
    output logic led_output;

    logic store_led;

    always_ff @(posedge clk) begin
        if (reset) begin
            store_led <= 0;
        end else if (key_input) begin
            store_led <= led_output;
        end
    end

    assign led_output = store_led ^ key_input;

endmodule
