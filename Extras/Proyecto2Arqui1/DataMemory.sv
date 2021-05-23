module DataMemory (input logic clk,WE,
	input logic [31:0] address,
	input logic [6:0] WData,
	output logic [31:0] RData);

logic [6:0] RAM[266810:0];
logic [6:0] RDataAux;

initial
begin
		$readmemb("C:/QuartusProjects/Files/RAMDatos1.txt", RAM);
end

always_ff @(negedge clk)
	begin
		if(WE) RAM[address] <= WData;
				RDataAux <= RAM[address];
	end
	
assign RData = {{25{RDataAux[6]}}, RDataAux};
	
endmodule
