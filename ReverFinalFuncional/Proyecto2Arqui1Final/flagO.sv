module flagO# (parameter bits = 32)
					(input logic [bits-1:0] a, b, result,
					input logic [3:0]s,
					output logic flag);
							
logic aritmetic, signo, verif;


always_comb begin
		case(s)
			4'b0000 :aritmetic = 1;
			4'b0001 :aritmetic = 1;
			default :aritmetic = 0;
		endcase 
	end


assign signo = a[bits-1] ^ result[bits-1];


always_comb begin
		case(s)
			4'b0000 :verif = a[bits-1] == b[bits-1];
			4'b0001 :verif = a[bits-1] ^ b[bits-1];
			default :verif = 0;
		endcase 
	end


assign flag = aritmetic & signo & verif;	

endmodule 