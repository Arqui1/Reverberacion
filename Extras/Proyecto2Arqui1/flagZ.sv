module flagZ #(parameter bits = 32)
					(input logic [3:0] s,
					input logic [bits-1:0] result,
					output logic flag);
	
	assign flag = (result == '0) & (s == 4'b0000
												| s == 4'b0001
												| s == 4'b0010
												| s == 4'b0011);

endmodule
