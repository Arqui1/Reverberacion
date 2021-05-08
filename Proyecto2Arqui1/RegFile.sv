module RegFile (input logic clk, rst, WE3,
					input logic [3:0] A1, A2, A3,
					input logic [31:0] WD3,R15,
					output logic [31:0] RD1, RD2);
	
	logic [31:0] regF [14:0];
	int n;
		
	always_ff @(negedge clk) begin
		if(rst)begin
			for (n = 0; n < 15; n = n + 1) begin
				regF[n] <= 32'b0;
			end
		end
		else begin
			if(WE3)
				regF[A3] <= WD3;
		end
	end
	
	always_comb begin
		if (A1 == 4'h0)begin 
            RD1 = 32'h0;
		end
      else begin
			if(A1==4'b1111)
            RD1 = R15 - 32'b1;
			else
				RD1 = regF[A1];
		end
	end
	
	always_comb begin
		if (A2 == 4'h0)
            RD2 =32'h0;
        else    
            RD2 = regF[A2];     
	end
	
endmodule
