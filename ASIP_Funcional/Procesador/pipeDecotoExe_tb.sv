module pipeDecotoExe_tb();
	logic clk,rst;
	logic [31:0] immExtD,RD2D,RD1D,immExtE, RD2E,RD1E;
	logic [3:0] WA3D,WA3E;
	
	pipeDecotoExe pipeDtoE(clk,rst,immExtD,RD2D,RD1D,WA3D,
									immExtE, RD2E,RD1E,WA3E);
	
	always
	begin
		#5 clk=!clk;
	end
	
	initial
	begin
		clk = 0;
		immExtD = 32'b1;
		RD2D = 32'd7;
		RD1D = 32'd15;
		WA3D = 32'd17;
		
		#10
		
		rst = 1'b1;
		#5
		rst = 1'b0;
		
		immExtD = 32'b1;
		RD2D = 32'd7;
		RD1D = 32'd15;
		WA3D = 32'd17;
		
		#10
		rst = 1'b0;
		
	end

endmodule
//Exitoso