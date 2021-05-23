module Alu_tb();


logic [31:0] op1, op2,result;
logic [3:0] ALUControl,flags;


Alu #(32) ALU( ALUControl,op1,op2,result,flags);


initial
	begin
	op1 = 32'h7; //Suma 7+2
	op2 = 32'h2;
	ALUControl = 4'b0000;
	
	#10
	op1 = 32'h7; //Resta 7-2
	op2 = 32'h2;
	ALUControl = 4'b0001;
	
	#10
	op1 = 32'd10; //mult 3*2
	op2 = 32'd2;
	ALUControl = 4'b0010;
	
	#10
	op1 = 32'd3; //div 10/2
	op2 = 32'd2;
	ALUControl = 4'b0011;
	
	#10
	op1 = 32'b11111; //and 31&21
	op2 = 32'b10101;
	ALUControl = 4'b0100;
	
	#10
	op1 = 32'b11111; //or 31v21
	op2 = 32'b10101;
	ALUControl = 4'b0101;
	
	#10
	op1 = 32'b11111; //shift left 5
	op2 = 32'd5;
	ALUControl = 4'b0110;
	
	#10
	op1 = 32'b11111; //shift right 5
	op2 = 32'd5;
	ALUControl = 4'b0111;
	
	#10
	op1 = 32'd2; //mov 2
	op2 = 32'd5;
	ALUControl = 4'b1000;
	
	#10
	op1 = 32'd2; //mov 2
	op2 = 32'd5;
	end

endmodule
//Exitoso