module mux_2_to_1_tb();
    localparam int WIDTH = 32;

    logic [WIDTH-1:0] a, b;
    logic s;
    logic [WIDTH-1:0] y;

    mux_2_to_1 #(.WIDTH(WIDTH)) dut (.a, .b, .s, .y);

    initial begin
        s = 0; a = 0; b = 0; #100;
        s = 0; a = 0; b = 1; #100;
        s = 0; a = 1; b = 0; #100;
        s = 0; a = 1; b = 1; #100;
        s = 1; a = 0; b = 0; #100;
        s = 1; a = 0; b = 1; #100;
        s = 1; a = 1; b = 0; #100;
        s = 1; a = 1; b = 1; #100;
    end
endmodule
