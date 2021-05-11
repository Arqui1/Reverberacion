module ControlUnit(input logic Inmed,
						input logic [1:0] Op,
						input logic [3:0] func,
						output logic FlagW,RegWrite,MemtoReg,MemWrite,
						Branch,ALUSrc,NoWrite,RegSrcA1,RegSrcA2,
						output logic [3:0] ALUControl);

logic [8:0]generalOut;
logic ALUOp;

 always_comb begin
		case(Op)
			2'b00:if(Inmed)begin
						if(func == 4'b1001)
							generalOut = 9'b001101001;//Aritmethic Inmed
						else
							generalOut = 9'b000101001;//Aritmethic Inmed
						end
					else begin
						if(func == 4'b1001)
							generalOut = 9'b001001001;//Aritmethic No Inmed
						else
							generalOut = 9'b000001001;//Aritmethic No Inmed
						end
			2'b01: if(Inmed)
						generalOut = 9'b010111000;//LDR Inmed
					 else
						generalOut = 9'b000011000;//LDR No Inmed
			2'b10: generalOut = 9'b010100100;//STR
			2'b11: generalOut = 9'b110100010;//B
        default:
          generalOut = 9'bxxxxxxxxx;
		endcase
	end

assign{RegSrcA1,RegSrcA2,NoWrite,ALUSrc,MemtoReg,RegWrite,MemWrite,Branch,ALUOp} = generalOut;

always_comb begin
	if(ALUOp) begin
			case(func)
				4'b0000: ALUControl = 4'b0000;//ADD
				4'b0001: ALUControl = 4'b0001;//SUB
				4'b0010: ALUControl = 4'b0010;//MUL
				4'b0100: ALUControl = 4'b0100;//AND
				4'b0101: ALUControl = 4'b0101;//OR
				4'b0110: ALUControl = 4'b0110;//SLL
				4'b0111: ALUControl = 4'b0111;//SLR
				4'b1000: ALUControl = 4'b1000;//MOV
				4'b1001: ALUControl = 4'b0001;//CMP
				default: ALUControl = 4'bx;
			endcase
		FlagW = (func == 4'b1001);
	end
	else begin
	ALUControl = 4'b0000;
	FlagW = 1'b0;
	end
end

endmodule
