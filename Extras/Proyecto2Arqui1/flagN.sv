module flagN #(parameter bits = 32)
				(input logic [3:0] s,
				input logic [bits-1:0] result,
				output logic flag);
				
	assign flag = result[bits-1];
	
endmodule 