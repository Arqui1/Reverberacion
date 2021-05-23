module flipflop #(parameter bits = 2) 
	(input logic clk,rst,en, 
	input [bits-1:0] stateIn, 
	output logic [bits-1:0] stateOut);

logic [bits-1:0] state = 2'h0;
always_ff @ (posedge clk, posedge rst) begin
	if (rst)
		state = 2'b0;
	else begin
		if(en)
			state = stateIn;
	end
end

assign stateOut = state;

endmodule
