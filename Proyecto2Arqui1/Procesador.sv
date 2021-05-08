module Procesador(input logic clk,rst,SongSelector,
						output logic [31:0] ResultW);
	
	logic FlagWD,MemtoRegD,ALUSrcD,RegWriteD,BranchD,MemWriteD,NoWriteD,
			FlagWE,RegWriteE,MemtoRegE,MemWriteE,BranchE,ALUSrcE,NoWriteE,CondE,
			PCSrcE,RegWE,MentoRE,MemWE,
			MemWriteM,MemtoRegM,RegWriteM,PCSrcM,
			MemtoRegW,RegWriteW,PCSrcW;
	logic [3:0] ALUControlD,ALUControlE,WA3E,WA3M,WA3W;
	logic [31:0] pc,pcmas1,pcNext;
	logic [31:0] instrF,instrD,RD1D,RD2D,immExtD,
					 immExtE,RD2E,RD1E,ALUResultE,
					 WriteDataM,ALUResultM,RDataM,
					 ALUResultW,RDataW;//ResultW;
	
	
	mux_ #(8) muxPC(PCSrcW,pcmas1,ResultW,pcNext);
	
	//Etapa de Fetch
	Fetch fetch(clk,rst,pcNext,instrF,pc,pcmas1);
	
	pipeLine #(32) pipeInstrFtoD(clk,rst,instrF,instrD);
	
	
	//Etapa de Decode
	Decode decode(clk,rst,RegWriteW,instrD,pc,ResultW,WA3W,ALUControlD,
					  immExtD,RD1D,RD2D,FlagWD,RegWriteD,MemtoRegD,
					  MemWriteD,BranchD,ALUSrcD,NoWriteD);
						
	pipeDecotoExe #(32) pipeDtoE(clk,rst,immExtD,RD2D,RD1D,instrD[29:26],
										  immExtE,RD2E,RD1E,WA3E);
	
	
	pipeContUnitDtoE pipeCUDtoE(clk,rst,FlagWD,RegWriteD,MemtoRegD,MemWriteD,
										 BranchD,ALUSrcD,NoWriteD,instrD[4],ALUControlD,
										 FlagWE,RegWriteE,MemtoRegE,MemWriteE,BranchE,
										 ALUSrcE,NoWriteE,CondE,ALUControlE);// Flags' ?
	
	//Etapa de Execute
	Execute execute(clk,rst,FlagWE,RegWriteE,MemWriteE,BranchE,
						 ALUSrcE,NoWriteE,CondE,ALUControlE,immExtE,
						 RD2E,RD1E,ALUResultE,PCSrcE,RegWE,MemWE);
							
	pipeExetoMem pipeEtoM(clk,rst,WA3E,RD2E,ALUResultE,
								 WA3M,WriteDataM,ALUResultM);
									
	pipeCondUnitEtoM pipeCondEtoM(clk,rst,MemWE,MemtoRegE,RegWE,PCSrcE,
											MemWriteM,MemtoRegM,RegWriteM,PCSrcM);
											
	//Etapa de Memory
	DataMemory DataRAM(clk,MemWriteM,ALUResultM,WriteDataM,RDataM);
	
	pipeMemtoWBack pipeMtoW(clk,rst,MemtoRegM,RegWriteM,PCSrcM,WA3M,ALUResultM,RDataM,
									MemtoRegW,RegWriteW,PCSrcW,WA3W,ALUResultW,RDataW);
	
	//Etapa de Write Back
	mux_ #(32) muxMemoryOrAlu(MemtoRegW,ALUResultW,RDataW,ResultW);
	
endmodule
