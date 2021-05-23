module TestProcesador();

logic clk,rst,SongSelector;
logic [31:0] ResultW;

Procesador(clk,rst,SongSelector,ResultW);

always
	begin
		#5 clk=!clk;
	end
	
	initial
	begin
		clk = 0;
		rst = 0;
		SongSelector = 0;
	end

endmodule
