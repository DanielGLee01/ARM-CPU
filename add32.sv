// 32 bit full adder
module add32(a, b, cin, sum, cout);
	input logic [31:0] a, b;
	input logic cin;
	
	output logic [31:0] sum;
	output logic cout;
	
	logic [32:0] carrywire;
	
	assign carrywire[0] = cin;
	
	genvar i;
	
	generate
		for (i = 0; i < 32; i++) begin : adders
			add1 adder (.a(a[i]), .b(b[i]), .cin(carrywire[i]), .sum(sum[i]), .cout(carrywire[i+1]));
		end
	endgenerate
	
	assign cout = carrywire[32];
	
	/*
	// One manual, tedious way to instantiate 32 bit full adder
	add1 adder1 (.a(a[0]), .b(b[0]), .cin, .sum(sum[0]), .cout(carrywire[0]));
	add1 adder2 (.a(a[1]), .b(b[1]), .cin(carrywire[0]), .sum(sum[1]), .cout(carrywire[1]));
	add1 adder3 (.a(a[2]), .b(b[2]), .cin(carrywire[1]), .sum(sum[2]), .cout(carrywire[2]));
	add1 adder4 (.a(a[3]), .b(b[3]), .cin(carrywire[2]), .sum(sum[3]), .cout(carrywire[3]));
	add1 adder5 (.a(a[4]), .b(b[4]), .cin(carrywire[3]), .sum(sum[4]), .cout(carrywire[4]));
	add1 adder6 (.a(a[5]), .b(b[5]), .cin(carrywire[4]), .sum(sum[5]), .cout(carrywire[5]));
	add1 adder7 (.a(a[6]), .b(b[6]), .cin(carrywire[5]), .sum(sum[6]), .cout(carrywire[6]));
	add1 adder8 (.a(a[7]), .b(b[7]), .cin(carrywire[6]), .sum(sum[7]), .cout(carrywire[7]));
	add1 adder9 (.a(a[8]), .b(b[8]), .cin(carrywire[7]), .sum(sum[8]), .cout(carrywire[8]));
	add1 adder10 (.a(a[9]), .b(b[9]), .cin(carrywire[8]), .sum(sum[9]), .cout(carrywire[9]));
	add1 adder11 (.a(a[10]), .b(b[10]), .cin(carrywire[9]), .sum(sum[10]), .cout(carrywire[10]));
	add1 adder12 (.a(a[11]), .b(b[11]), .cin(carrywire[10]), .sum(sum[11]), .cout(carrywire[11]));
	add1 adder13 (.a(a[12]), .b(b[12]), .cin(carrywire[11]), .sum(sum[12]), .cout(carrywire[12]));
	add1 adder14 (.a(a[13]), .b(b[13]), .cin(carrywire[12]), .sum(sum[13]), .cout(carrywire[13]));
	add1 adder15 (.a(a[14]), .b(b[14]), .cin(carrywire[13]), .sum(sum[14]), .cout(carrywire[14]));
	add1 adder16 (.a(a[15]), .b(b[15]), .cin(carrywire[14]), .sum(sum[15]), .cout(carrywire[15]));
	add1 adder17 (.a(a[16]), .b(b[16]), .cin(carrywire[15]), .sum(sum[16]), .cout(carrywire[16]));
	add1 adder18 (.a(a[17]), .b(b[17]), .cin(carrywire[16]), .sum(sum[17]), .cout(carrywire[17]));
	add1 adder19 (.a(a[18]), .b(b[18]), .cin(carrywire[17]), .sum(sum[18]), .cout(carrywire[18]));
	add1 adder20 (.a(a[19]), .b(b[19]), .cin(carrywire[18]), .sum(sum[19]), .cout(carrywire[19]));
	add1 adder21 (.a(a[20]), .b(b[20]), .cin(carrywire[19]), .sum(sum[20]), .cout(carrywire[20]));
	add1 adder22 (.a(a[21]), .b(b[21]), .cin(carrywire[20]), .sum(sum[21]), .cout(carrywire[21]));
	add1 adder23 (.a(a[22]), .b(b[22]), .cin(carrywire[21]), .sum(sum[22]), .cout(carrywire[22]));
	add1 adder24 (.a(a[23]), .b(b[23]), .cin(carrywire[22]), .sum(sum[23]), .cout(carrywire[23]));
	add1 adder25 (.a(a[24]), .b(b[24]), .cin(carrywire[23]), .sum(sum[24]), .cout(carrywire[24]));
	add1 adder26 (.a(a[25]), .b(b[25]), .cin(carrywire[24]), .sum(sum[25]), .cout(carrywire[25]));
	add1 adder27 (.a(a[26]), .b(b[26]), .cin(carrywire[25]), .sum(sum[26]), .cout(carrywire[26]));
	add1 adder28 (.a(a[27]), .b(b[27]), .cin(carrywire[26]), .sum(sum[27]), .cout(carrywire[27]));
	add1 adder29 (.a(a[28]), .b(b[28]), .cin(carrywire[27]), .sum(sum[28]), .cout(carrywire[28]));
	add1 adder30 (.a(a[29]), .b(b[29]), .cin(carrywire[28]), .sum(sum[29]), .cout(carrywire[29]));
	add1 adder31 (.a(a[30]), .b(b[30]), .cin(carrywire[29]), .sum(sum[30]), .cout(carrywire[30]));
	add1 adder32 (.a(a[31]), .b(b[31]), .cin(carrywire[30]), .sum(sum[31]), .cout);
	*/
endmodule

module add32_testbench();
	logic [31:0] a, b, sum;
	logic cin, cout;
	
	add32 dut (.a, .b, .cin, .sum, .cout);
	
	initial begin
		a = 32'hFFFFFFFF; b = 32'h00000001; cin = 0; #10;
		a = 32'hAAAAAAAA; b = 32'h55555555; cin = 0; #10;
	end
endmodule