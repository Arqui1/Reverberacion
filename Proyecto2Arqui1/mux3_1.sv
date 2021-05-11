module mux3_1 #(parameter bits=32)(input logic [1:0] select, 
									input logic [bits-1:0] A, B, C,
									output logic [bits-1:0] out);
always_comb 
	begin
		case(select)
			2'b00 :out = A;
			2'b01 :out = B;
			2'b10 :out = C;
			default :out = A;
		endcase 
	end

endmodule
