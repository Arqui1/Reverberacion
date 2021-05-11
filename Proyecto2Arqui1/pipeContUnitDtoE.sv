module pipeContUnitDtoE (input logic clk,rst,flush,FlagWD,RegWriteD,MemtoRegD,
										MemWriteD,BranchD,ALUSrcD,NoWriteD, CondD,
								input logic [3:0] ALUControlD,
								output logic FlagWE,RegWriteE,MemtoRegE,MemWriteE,
												BranchE,ALUSrcE,NoWriteE,CondE,
								output logic [3:0] ALUControlE);

logic FlagW,RegWrite,MemtoReg,MemWrite,
		Branch,ALUSrc,NoWrite,Cond;
logic [3:0] ALUControl;

always_ff @ (posedge clk, posedge rst) begin
	if (rst) begin
		{FlagW,RegWrite,MemtoReg,MemWrite,
		Branch,ALUSrc,NoWrite,Cond} = 8'b0;
		ALUControl = 4'b0;
	end
	else if (flush) begin
		{FlagW,RegWrite,MemtoReg,MemWrite,
		Branch,ALUSrc,NoWrite,Cond} = 8'b0;
		ALUControl = 4'b0;
	end
	else begin
		FlagW = FlagWD;
		RegWrite = RegWriteD;
		MemtoReg = MemtoRegD;
		MemWrite = MemWriteD;
		Branch = BranchD;
		ALUSrc = ALUSrcD;
		NoWrite = NoWriteD;
		Cond = CondD;
		ALUControl = ALUControlD;
	end
end

assign FlagWE = FlagW;
assign RegWriteE = RegWrite;
assign MemtoRegE = MemtoReg;
assign MemWriteE = MemWrite;
assign BranchE = Branch;
assign ALUSrcE = ALUSrc;
assign NoWriteE = NoWrite;
assign CondE = Cond;
assign ALUControlE = ALUControl;

endmodule
