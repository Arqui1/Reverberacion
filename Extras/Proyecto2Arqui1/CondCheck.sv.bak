module CondCheck (input logic Cond,
						input logic [3:0] Flags, 
						output logic CondEx);
						
	logic neg, zero, carry_, overflow;
    
	assign {carry_, neg, zero, overflow} = Flags;
    
	always_comb case(Cond) 
		1'b0:     CondEx = 1'b1;
		1'b1:     CondEx = zero;
		default:  CondEx = 1'bx;
	endcase
	
endmodule
