module Execute (input logic clk,rst,FlagWE,RegWriteE,
						MemWriteE,BranchE,ALUSrcE,NoWriteE,
						input logic [1:0] CondE,
						input logic [3:0] ALUControlE,
						input logic [31:0]immExtE,RD2E,RD1E,
						output logic [31:0] ALUResultE,
						output logic PCSrcE,RegWE,MemWE);
						
	logic [31:0] SrcBE;
	logic [3:0] AluFlags;
	
	mux_ #(32) muxRegOrInmExt(ALUSrcE,RD2E,immExtE,SrcBE);
	
	Alu #(32) ALU(ALUControlE,RD1E,SrcBE,ALUResultE,AluFlags);
	
	CondUnit unidadCond(clk,rst,FlagWE,NoWriteE,BranchE,
								MemWriteE,RegWriteE,CondE,AluFlags,PCSrcE,
								RegWE,MemWE);
	
endmodule
