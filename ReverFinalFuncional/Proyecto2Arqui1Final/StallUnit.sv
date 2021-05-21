 module StallUnit(input logic MemtoRegE,
						input logic [1:0] OpE,
						input logic [3:0] RA1D,RA2D,WA3E,
						output logic Stall);
						 
logic LDRStall = 1'b0;

always_comb begin
	if((OpE == 2'b01)&&((RA1D == WA3E)|(RA2D == WA3E))&&MemtoRegE)
		LDRStall = 1'b1;
	else 
		LDRStall = 1'b0;
end

assign Stall = LDRStall;

endmodule
