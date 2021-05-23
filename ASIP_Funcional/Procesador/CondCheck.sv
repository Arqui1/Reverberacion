module CondCheck (input logic [1:0] Cond,
						input logic [3:0] Flags,
						output logic CondEx);
						
	logic neg, zero, carry_, overflow;
    
	assign {carry_, neg, zero, overflow} = Flags;
    
	always_comb case(Cond) 
		2'b00:     CondEx = 1'b1; 				//B
		2'b01:     CondEx = zero; 				//BEQ
		2'b10:     CondEx = !neg && !zero; 	//BGT
		2'b11:     CondEx = neg; 				//BLT
		default:  CondEx = 1'bx;
	endcase
	
endmodule
