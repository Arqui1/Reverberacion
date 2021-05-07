module sumALU #(parameter bits = 32)( input logic [bits-1:0] a, b,
												output logic [bits-1:0] out,
												output logic cout);
	assign {cout, out} = a + b;

endmodule
