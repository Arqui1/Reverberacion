module Decode_tb();

	logic clk,rst,WE3;
	logic [31:0]instr,pc,WD3;
	logic [3:0] A3;
	logic [3:0]ALUControl;
	logic [31:0] immExt,RD1,RD2;
	logic FlagW,RegWrite,MemtoReg,MemWrite,Branch,ALUSrc,NoWrite;
	
	Decode deco(clk,rst,WE3,instr,pc,WD3,A3,
					ALUControl,immExt,RD1,RD2,
					FlagW,RegWrite,MemtoReg,MemWrite,
					Branch,ALUSrc,NoWrite);
					
	always
	begin
		#5 
		clk=!clk;
	end
	
	always
	begin
		#10
		pc = pc + 1;
	end
	
	initial
	begin
		clk = 0;
		rst = 1;
		#10
		rst = 0;
		pc = 0;
		//CMP r2, #12
		instr = 32'b00000000100000000000000110011001;
		WE3 = 1;
		WD3 = 32'd2500;
		A3 = 4'd2;
		
		#10
		
		//B Label    Label=16
		instr = 32'b11000000000000000000001000000000;
		WE3 = 1;
		WD3 = 32'd5000;
		A3 = 4'd4;
		
		#10
		
		//ADD r3,r2,r4
		instr = 32'b00001100100100000000000000000000;
		WE3 = 1;
		WD3 = 32'd75000;
		A3 = 4'd6;
		
		#10
		
		//BEQ Label2    Label2=25
		instr = 32'b11000000000000000000001100110000;
		WE3 = 0;
		WD3 = 32'd85000;
		A3 = 4'd7;
		
		#10
		
		//MUL r8,r6,r7
		instr = 32'b00100001100111000000000000000010;
		WE3 = 1;
		WD3 = 32'd85000;
		A3 = 4'd7;
		
		#10
		
		//SUB r9,r7,#37040
		instr = 32'b00100101110100100001011000010001;
		WE3 = 0;
		
		#10
		
		//LDR r5,[r7,r2]
		instr = 32'b01010101110010000000000000000000;
		
		#10
		
		//STR r9,[r13,60000]
		instr = 32'b10100111010111010100110000000000;
		
		#10;
	end
					
endmodule
//Exitoso