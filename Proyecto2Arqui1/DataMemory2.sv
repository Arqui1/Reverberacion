module DataMemory2 (input logic clk,WE,
	input logic [31:0] address,
	input logic [15:0] WData,
	output logic [31:0] RData);
						
logic [15:0] RAM[268000:0];
logic [15:0] RDataAux;

initial
begin
		$readmemb("C:/QuartusProjects/Files/RAMDatos2.txt", RAM);
end

always_ff @(negedge clk)
	begin
		if(WE) RAM[address] <= WData;
				RDataAux <= RAM[address];
	end
	
assign RData = {{16{RDataAux[15]}}, RDataAux};
	
endmodule
