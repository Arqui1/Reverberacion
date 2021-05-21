module ControlUnit_tb();
	logic Inmed;
	logic [1:0] Op;
	logic [3:0] func;
	logic FlagW,RegWrite,MemtoReg,MemWrite,
			Branch,ALUSrc,NoWrite,RegSrcA1,RegSrcA2;
	logic [3:0] ALUControl;
	
	ControlUnit CU(Inmed,Op,func,FlagW,RegWrite,
						MemtoReg,MemWrite,Branch,ALUSrc,NoWrite,
						RegSrcA1,RegSrcA2,ALUControl);
						
	initial
	begin
	//CMP r2, #12
	Inmed = 1'b1;
	Op = 2'b00;
	func = 4'b1001;
	
	#10
	
	//CMP r2, r3
	Inmed = 1'b0;
	Op = 2'b00;
	func = 4'b1001;
	
	#10
	
	//ADD r2, r3, r4
	Inmed = 1'b0;
	Op = 2'b00;
	func = 4'b0000;
	
	#10
	
	//LDR r2, [r3]
	Inmed = 1'b1;
	Op = 2'b01;
	func = 4'b0000;
	
	#10
	
	//LDR r2, [r3,r5]
	Inmed = 1'b0;
	Op = 2'b01;
	func = 4'b0000;
	
	#10
	
	//STR r2, [r3]
	Inmed = 1'b0;
	Op = 2'b10;
	func = 4'b0000;
	
	#10
	
	//B Label
	Inmed = 1'b0;
	Op = 2'b11;
	func = 4'b0000;
	
	#10
	
	//B Label
	Inmed = 1'b0;
	Op = 2'b11;
	func = 4'b0000;
	end

endmodule
//Exitoso