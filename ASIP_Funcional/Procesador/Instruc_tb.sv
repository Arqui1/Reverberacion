module Instruc_tb();
	
logic [31:0] address, q;
InstrucMemory DUT(address,q);

initial begin
		address = 32'd0;
		#10
		address = 32'd1;
		#10
		address = 32'd2;
		
		end

endmodule
//Exitoso