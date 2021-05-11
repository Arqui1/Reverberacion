module Procesador(input logic clk,rst,SongSelector,
						output logic [31:0] ResultW);
	
	logic FlagWD,MemtoRegD,ALUSrcD,RegWriteD,BranchD,MemWriteD,NoWriteD,
			FlagWE,RegWriteE,MemtoRegE,MemWriteE,BranchE,ALUSrcE,NoWriteE,CondE,
			PCSrcE,RegWE,MentoRE,MemWE,
			MemWriteM,MemtoRegM,RegWriteM,PCSrcM,
			MemtoRegW,RegWriteW,PCSrcW,
			Stall;
	logic [1:0] RD1ESelect,RD2ESelect,OpE;
	logic [3:0] ALUControlD,ALUControlE,WA3E,WA3M,WA3W,
					RA1D,RA2D,RA1E,RA2E;
	logic [31:0] pc,pcmas1,pcNext,pcNextPrev,pcD;
	logic [31:0] instrF,instrD,RD1D,RD2D,immExtD,
					 immExtE,RD2E,RD1E,ALUResultE,SrcAE,SrcBE,
					 WriteDataM,ALUResultM,RDataM,
					 ALUResultW,RDataW;//ResultW;
	
	
	mux_ #(32) muxPC1(PCSrcW,pcmas1,ResultW,pcNextPrev);
	mux_ #(32) muxPC2(PCSrcE,pcNextPrev,ALUResultE,pcNext);
	
	//Etapa de Fetch----------------------------------------------------------
	Fetch fetch(clk,rst,Stall,pcNext,instrF,pc,pcmas1);
	//------------------------------------------------------------------------
	
	//PipeLine de la etapa de Fetch a Decode----------------------------------
	pipeLine #(32) pipeInstrFtoD(clk,rst,Stall,PCSrcE,instrF,instrD);
	
	pipeLine #(32) pipePCFtoD(clk,rst,Stall,PCSrcE,pc,pcD);
	//------------------------------------------------------------------------
	
	//Etapa de Decode---------------------------------------------------------
	Decode decode(clk,rst,RegWriteW,instrD,pcD,ResultW,WA3W,ALUControlD,
					  RA1D,RA2D,immExtD,RD1D,RD2D,FlagWD,RegWriteD,MemtoRegD,
					  MemWriteD,BranchD,ALUSrcD,NoWriteD);
	//------------------------------------------------------------------------
	
	//PipeLine de la etapa de Decode a Execute--------------------------------
	pipeDecotoExe #(32) pipeDtoE(clk,rst,(Stall|PCSrcE),immExtD,RD2D,RD1D,instrD[29:26],
										  immExtE,RD2E,RD1E,WA3E);
	
	pipeContUnitDtoE pipeCUDtoE(clk,rst,(Stall|PCSrcE),FlagWD,RegWriteD,MemtoRegD,MemWriteD,
										 BranchD,ALUSrcD,NoWriteD,instrD[4],ALUControlD,
										 FlagWE,RegWriteE,MemtoRegE,MemWriteE,BranchE,
										 ALUSrcE,NoWriteE,CondE,ALUControlE);// Flags' ?
	
	pipeLine #(4) pipeRA1DtoE(clk,rst,1'b0,(Stall|PCSrcE),RA1D,RA1E);
	pipeLine #(4) pipeRA2DtoE(clk,rst,1'b0,(Stall|PCSrcE),RA2D,RA2E);
	pipeLine #(2) pipeOpDtoE(clk,rst,1'b0,(Stall|PCSrcE),instrD[31:30],OpE);
	//------------------------------------------------------------------------
	
	//Etapa de Execute--------------------------------------------------------
	mux3_1 #(32) muxRD1E(RD1ESelect,RD1E,ResultW,ALUResultM,SrcAE);
	mux3_1 #(32) muxRD2E(RD2ESelect,RD2E,ResultW,ALUResultM,SrcBE);
	
	Execute execute(clk,rst,FlagWE,RegWriteE,MemWriteE,BranchE,
						 ALUSrcE,NoWriteE,CondE,ALUControlE,immExtE,
						 SrcBE,SrcAE,ALUResultE,PCSrcE,RegWE,MemWE);
	//------------------------------------------------------------------------
	
	//PipeLine de la etapa de Execute a Memory--------------------------------
	pipeExetoMem pipeEtoM(clk,rst,WA3E,SrcBE,ALUResultE,
								 WA3M,WriteDataM,ALUResultM);
									
	pipeCondUnitEtoM pipeCondEtoM(clk,rst,MemWE,MemtoRegE,RegWE,PCSrcE,
											MemWriteM,MemtoRegM,RegWriteM,PCSrcM);
	//------------------------------------------------------------------------
											
	//Etapa de Memory---------------------------------------------------------
	DataMemory DataRAM(clk,MemWriteM,ALUResultM,WriteDataM,RDataM);
	//------------------------------------------------------------------------
	
	//PipeLine de la etapa de Memory a Write Back-----------------------------
	pipeMemtoWBack pipeMtoW(clk,rst,MemtoRegM,RegWriteM,PCSrcM,WA3M,ALUResultM,RDataM,
									MemtoRegW,RegWriteW,PCSrcW,WA3W,ALUResultW,RDataW);
	//------------------------------------------------------------------------
	
	//Etapa de Write Back-----------------------------------------------------
	mux_ #(32) muxMemoryOrAlu(MemtoRegW,ALUResultW,RDataW,ResultW);
	//------------------------------------------------------------------------
	
	//Manejo de Riesgos-------------------------------------------------------
	ForwardUnit forwardU(RegWriteM,RegWriteW,RA1E,RA2E,WA3M,WA3W,RD1ESelect,RD2ESelect);
	StallUnit ldrHazard(MemtoRegE,OpE,RA1D,RA2D,WA3E,Stall);
	
endmodule
