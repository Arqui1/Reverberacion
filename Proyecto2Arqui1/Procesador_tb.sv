module Procesador_tb();

logic clk,rst,modeSelector;
logic [31:0] ResultW;

Procesador processor(clk,rst,modeSelector,ResultW);

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
		modeSelector = 0;
	end

endmodule
