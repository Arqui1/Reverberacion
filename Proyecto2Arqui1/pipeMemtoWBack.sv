module pipeMemtoWBack(input logic clk,rst,MemtoRegM,RegWriteM,PCSrcM,
							 input logic [3:0] WA3M,
							 input logic [31:0] ALUResultM,RDataM,
							 output logic MemtoRegW,RegWriteW,PCSrcW,
							 output logic [3:0] WA3W,
							 output logic [31:0] ALUResultW,RDataW);

logic MemtoReg,RegWrite,PCSrc;
logic [3:0] WA3 = 4'b0;
logic [31:0] ALUResult = 32'b0;
logic [31:0] RData = 32'b0;

always_ff @ (posedge clk, posedge rst) begin
	if (rst) begin
		{MemtoReg,RegWrite,PCSrc} = 3'b0;
		WA3 = 4'b0;
		ALUResult = 32'b0;
		RData = 32'b0;
	end
	else begin
		MemtoReg = MemtoRegM;
		RegWrite = RegWriteM;
		PCSrc = PCSrcM;
		WA3 = WA3M;
		ALUResult = ALUResultM;
		RData = RDataM;
	end
end

assign MemtoRegW = MemtoReg;
assign RegWriteW = RegWrite;
assign PCSrcW = PCSrc;
assign WA3W = WA3;
assign ALUResultW = ALUResult;
assign RDataW = RData;

endmodule
