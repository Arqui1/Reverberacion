module pipeExetoMem #(parameter bits = 32) 
							(input logic clk,rst,
							input logic [3:0] WA3E,
							input logic [bits-1:0]WriteDataE,ALUResultE,
							output logic [3:0] WA3M,
							output logic [bits-1:0] WriteDataM,ALUResultM);

logic [bits-1:0] WriteData = 32'h0;
logic [bits-1:0] ALUResult = 32'h0;
logic [3:0] WA3 = 4'h0;

always_ff @ (posedge clk, posedge rst) begin
	if (rst) begin
		WA3 = 4'b0;
		WriteData = 32'b0;
		ALUResult = 32'b0;
	end
	else begin
		WA3 = WA3E;
		WriteData = WriteDataE;
		ALUResult = ALUResultE;
	end
end

assign WA3M = WA3;
assign WriteDataM = WriteData;
assign ALUResultM = ALUResult;

endmodule
