module muxflag(input logic [3:0]s, 
					input logic	[3:0]flags,
					output logic [3:0] out);
	
	always_comb begin
		case(s)
			4'b0000 :out = flags;
			4'b0001 :out = flags;
			4'b0010 :out = {1'b0,flags[2:0]};
			4'b0011 :out = {1'b0,flags[2:0]};
			default :out = 4'b0000;
		endcase 
	end

endmodule
