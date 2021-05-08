module Procesador_tb();

logic clk,rst,SongSelector;
logic [31:0] ResultW;

Procesador processor(clk,rst,SongSelector,ResultW);

always
	begin
		#5 clk=!clk;
	end
	
	initial
	begin
		clk = 0;
		rst = 1;
		#2
		rst = 0;
		SongSelector = 0;
	end

endmodule
