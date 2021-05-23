module muxALU #(parameter bits = 32)
				(input logic [3:0] s,
				input [bits-1:0] value0,value1,value2,value3,value4,value5,value6,value7,value8,
				output logic [bits-1:0] out);
				
	always_comb begin
		case(s)
			4'b0000: out = value0;
			4'b0001: out = value1;
			4'b0010: out = value2;
			4'b0011: out = value3;
			4'b0100: out = value4;
			4'b0101: out = value5;
			4'b0110: out = value6;
			4'b0111: out = value7;
			4'b1000: out = value8;
			default: out = value0;
		endcase
	end
	
endmodule
