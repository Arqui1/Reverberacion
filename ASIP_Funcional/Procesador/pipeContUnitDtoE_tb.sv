module pipeContUnitDtoE_tb();
	logic clk,rst,FlagWD,RegWriteD,MemtoRegD,
			MemWriteD,BranchD,ALUSrcD,NoWriteD, CondD,
			FlagWE,RegWriteE,MemtoRegE,MemWriteE,
			BranchE,ALUSrcE,NoWriteE,CondE;
	logic [3:0] ALUControlD,ALUControlE;
	
	pipeContUnitDtoE pipeCUDtoE(clk,rst,FlagWD,RegWriteD,MemtoRegD,
										MemWriteD,BranchD,ALUSrcD,NoWriteD, CondD,
										ALUControlD,FlagWE,RegWriteE,MemtoRegE,
										MemWriteE,BranchE,ALUSrcE,NoWriteE,CondE,
										ALUControlE);
	
	always
	begin
		#5 clk=!clk;
	end
	
	initial
	begin
		clk = 0;
		{FlagWD,RegWriteD,MemtoRegD,MemWriteD,
		BranchD,ALUSrcD,NoWriteD,CondD} = 8'b10101011;
		ALUControlD = 4'b1110;
		
		#10
		
		rst = 1'b1;
		#5
		rst = 1'b0;
		
		{FlagWD,RegWriteD,MemtoRegD,MemWriteD,
		BranchD,ALUSrcD,NoWriteD,CondD} = 8'b11111111;
		ALUControlD = 4'b1111;
		
		#10
		
		{FlagWD,RegWriteD,MemtoRegD,MemWriteD,
		BranchD,ALUSrcD,NoWriteD,CondD} = 8'b001001000;
		ALUControlD = 4'b0100;
		
		#10;
		
	end

endmodule
//Exitoso