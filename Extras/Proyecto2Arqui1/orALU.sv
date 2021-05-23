module orALU #(parameter bits = 32)
				(input logic [bits-1:0] a, b,
				output logic [bits-1:0] c);
				
	assign c = a | b;

endmodule
