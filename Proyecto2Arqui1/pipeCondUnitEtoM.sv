module pipeCondUnitEtoM(input logic clk,rst,MemWriteE,MemtoRegE,RegWriteE,PCSrcE,
								output logic MemWriteM,MemtoRegM,RegWriteM,PCSrcM);

logic MemWrite,MemtoReg,RegWrite,PCSrc;

always_ff @ (posedge clk, posedge rst) begin
	if (rst) begin
		{MemWrite,MemtoReg,RegWrite,PCSrc} = 4'b0;
	end
	else begin
		MemWrite = MemWriteE;
		MemtoReg = MemtoRegE;
		RegWrite = RegWriteE;
		PCSrc = PCSrcE;
	end
end

assign MemWriteM = MemWrite;
assign MemtoRegM = MemtoReg;
assign RegWriteM = RegWrite;
assign PCSrcM = PCSrc;

endmodule
