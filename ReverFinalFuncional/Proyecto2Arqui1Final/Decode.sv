module Decode (input logic clk,rst,WE3,
					input logic [31:0]instr,pc,WD3,
					input logic [3:0] A3,
					output logic [3:0]ALUControl,RA1,RA2,
					output logic [31:0]immExt,RD1,RD2,
					output logic FlagW,RegWrite,MemtoReg,MemWrite,Branch,ALUSrc,NoWrite,txt);
					
	logic RegSrcA1,RegSrcA2;
//	logic [3:0] RA1,RA2;
	
	ControlUnit  CU(instr[4],instr[31:30],instr[3:0],
					FlagW,RegWrite,MemtoReg,MemWrite,Branch,
					ALUSrc,NoWrite,RegSrcA1,RegSrcA2,txt,ALUControl);
   
	mux_ #(4) muxA1(RegSrcA1,instr[25:22],4'b1111,RA1);
	mux_ #(4) muxA2(RegSrcA2,instr[21:18],instr[29:26],RA2);
	
	RegFile RF(clk,rst,WE3,RA1,RA2,A3,WD3,pc,RD1,RD2);
	
	Extend EI(instr[21:5],immExt);
						
endmodule
//Recordar que PCSrc=Branch
//Completo