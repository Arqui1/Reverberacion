module divALU #(parameter bits = 32)( input logic [bits-1:0] a, b,
												output logic [bits-1:0] out);
	assign out = a / b;

endmodule
