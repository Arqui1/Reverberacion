module Data_tb();

logic clk,we;
logic [17:0] address;
logic [31:0] writeData,readData;

DataMemory RAMData(clk,we, address, writeData, readData);

always
	begin
		#5 clk=!clk;
	end

initial
	begin
	clk = 'b0;
	we = 0;
	address = 18'd0;
	writeData =32'd140;
	#10
	address = 18'd10000;
	#10
	address = 18'd20000;
	#10
	address = 18'd30000;
	#10
	address = 18'd40000;
	#10
	address = 18'd50000;
	#10
	address = 18'd60000;
	#10
	address = 18'd70000;
	#10
	address = 18'd80000;
	#10
	address = 18'd90000;
	#10
	address = 18'd100000;
	#10
	address = 18'd110000;
	#10
	address = 18'd120000;
	#10
	address = 18'd130000;
	#10
	address = 18'd140000;
	#10
	address = 18'd150000;
	
	#10
	we = 1;
	address = 18'd0;
	
end
	
	
endmodule
//Exitoso