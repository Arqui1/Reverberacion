module sumador #(parameter N=8)(input logic [N-1:0] A,B,
										  output logic [N-1:0] C);
assign C = A + B;
			
endmodule
