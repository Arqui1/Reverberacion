module CondUnit(input logic clk,rst,FlagWE,NoWriteE,
						BranchE,MemWriteE,RegWriteE,
						input logic [1:0] CondE,
						input logic [3:0] AluFlags,
						output logic PCSrcE,RegWE,MemWE);
	
	logic [3:0] Flags;
	logic CondEx;

	flipflop #(2) ff1(clk,rst,FlagWE,AluFlags[3:2],Flags[3:2]);
	flipflop #(2) ff2(clk,rst,FlagWE,AluFlags[1:0],Flags[1:0]);
	
	CondCheck cc(CondE,Flags,CondEx);
	
	assign PCSrcE = CondEx & BranchE;
	assign RegWE = RegWriteE & !NoWriteE;
	assign MemWE = MemWriteE;

endmodule
