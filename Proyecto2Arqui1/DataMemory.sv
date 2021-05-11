module DataMemory (input logic clk,WE,
	input logic [17:0] address,
	input logic [31:0] WData,
	output logic [31:0] RData);
						
logic [31:0] RAM[26214:0];

initial
begin
		$readmemh("C:/QuartusProjects/Files/RAM1.txt", RAM);
end

always_ff @(negedge clk)
	begin
		if(WE) RAM[address] <= WData;
				RData <= RAM[address];
	end
	
endmodule
