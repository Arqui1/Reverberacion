module mux_ #(parameter bits=4)(input logic  select, 
									input logic [bits-1:0] A, B,
									output logic [bits-1:0] out);
always_comb 
	begin
		case(select)
			1'b0 :out = A;
			1'b1 :out = B;
			default :out = A;
		endcase 
	end

endmodule
