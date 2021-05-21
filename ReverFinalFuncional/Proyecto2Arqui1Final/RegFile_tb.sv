module RegFile_tb();
	logic clk, rst, WE3;
	logic [3:0] A1, A2, A3;
	logic [31:0] WD3,R15,RD1, RD2;
	
	RegFile RF(clk,rst,WE3,A1,A2,A3,WD3,R15,RD1,RD2);
	
	always
	begin
		#5 
		clk=!clk;
		R15 = R15 + 1;
	end
	
	initial
	begin
		clk = 0;
		R15 = 0;
		WE3 = 1;
		A1 = 4'd2;
		A2 = 4'b0;
		A3 = 4'd4;
		WD3 = 32'd255;
		
		#10
		
		WE3 = 1;
		A1 = 4'd3;
		A2 = 4'b1;
		A3 = 4'd5;
		WD3 = 32'd25500;
		
		#10
		
		WE3 = 0;
		A1 = 4'd4;
		A2 = 4'd5;
		A3 = 4'd7;
		WD3 = 32'd25500;
		
		#10
		
		WE3 = 0;
		A1 = 4'd7;
		A2 = 4'd5;
		A3 = 4'd7;
		WD3 = 32'd25500;
		
		#10
		
		WE3 = 1;
		A1 = 4'd7;
		A2 = 4'd5;
		A3 = 4'd7;
		WD3 = 32'd500;
		
		#10
		
		WE3 = 0;
		A1 = 4'd7;
		A2 = 4'd5;
		A3 = 4'd7;
		WD3 = 32'd500;
		
		#10;
	end
endmodule
//Exitoso