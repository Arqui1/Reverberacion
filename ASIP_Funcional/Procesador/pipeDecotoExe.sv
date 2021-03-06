module pipeDecotoExe #(parameter bits = 32) 
	(input logic clk,rst,flush,
	input logic [bits-1:0] immExtD,RD2D,RD1D,
	input logic [3:0] WA3D,
	output logic [bits-1:0] immExtE, RD2E,RD1E,
	output logic [3:0] WA3E);

logic [bits-1:0] immExt = 32'h0;
logic [bits-1:0] RD2 = 32'h0;
logic [bits-1:0] RD1 = 32'h0;
logic [3:0] WA3 = 4'h0;

always_ff @ (posedge clk, posedge rst) begin
	if (rst) begin
		immExt = 32'b0;
		RD2 = 32'b0;
		RD1 = 32'b0;
		WA3 = 4'b0;
	end
	else if (flush) begin
		immExt = 32'b0;
		RD2 = 32'b0;
		RD1 = 32'b0;
		WA3 = 4'b0;
	end
	else begin
		immExt = immExtD;
		RD2 = RD2D;
		RD1 = RD1D;
		WA3 = WA3D;
	end
end

assign immExtE = immExt;
assign RD2E = RD2;
assign RD1E = RD1;
assign WA3E = WA3;

endmodule
