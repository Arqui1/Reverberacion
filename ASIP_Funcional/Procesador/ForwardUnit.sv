module ForwardUnit (input logic RegWriteM,RegWriteW,
						 input logic [3:0] RA1E,RA2E,WA3M,WA3W,
						 output logic [1:0] RD1ESelect,RD2ESelect);

logic [1:0] ForwardRD1E, ForwardRD2E;						 
						 
always_comb begin
	if((RA1E == WA3M) && RegWriteM)begin
		ForwardRD1E = 2'b10;
	end
	else if((RA1E == WA3W) && RegWriteW)begin
		ForwardRD1E = 2'b01;
	end
	else begin
		ForwardRD1E = 2'b00;
	end
end

always_comb begin
	if((RA2E == WA3M) && RegWriteM)begin
		ForwardRD2E = 2'b10;
	end
	else if((RA2E == WA3W) && RegWriteW)begin
		ForwardRD2E = 2'b01;
	end
	else begin
		ForwardRD2E = 2'b00;
	end
end

assign RD1ESelect = ForwardRD1E;
assign RD2ESelect = ForwardRD2E;

endmodule
