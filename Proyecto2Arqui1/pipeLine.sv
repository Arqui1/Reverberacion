module pipeLine #(parameter bits = 32) 
	(input logic clk, rst, input [bits-1:0] stateIn, 
	output logic [bits-1:0] stateOut);

logic [bits-1:0] state = 32'h0;
always_ff @ (posedge clk, posedge rst) begin
	if (rst)
		state = 32'b0;
	else
		state = stateIn;
end

assign stateOut = state;

endmodule
